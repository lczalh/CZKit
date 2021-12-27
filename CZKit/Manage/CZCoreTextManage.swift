//
//  CZCoreTextManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/5/11.
//

import Foundation

public struct CZCoreTextManage {
    
    /// 通过富文本以及显示范围获取CTFrame
    ///
    /// - Parameters:
    ///   - attrString: 富文本
    ///   - rect: 显示范围
    /// - Returns: CTFrame
    public static func getCtFrame(attributedString: NSAttributedString,
                                  rect: CGRect) -> CTFrame {
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let path = CGPath(rect: rect, transform: nil)
        let frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        return frameRef
    }
    
    /// 获得触摸位置那一行文字的Range
    ///
    /// - Parameters:
    ///   - point: 触摸位置
    ///   - ctFrame: CTFrame
    /// - Returns: CTLine
    public static func getTouchLineRange(point:CGPoint,
                                         ctFrame: CTFrame) -> NSRange {
        var range: NSRange = NSMakeRange(NSNotFound, 0)
        let line = getTouchLine(point: point, ctFrame: ctFrame)
        if line != nil {
            let lineRange = CTLineGetStringRange(line!)
            range = NSMakeRange(lineRange.location == kCFNotFound ? NSNotFound : lineRange.location, lineRange.length)
        }
        return range
    }
    
    /// 获得触摸位置在哪一行
    ///
    /// - Parameters:
    ///   - point: 触摸位置
    ///   - ctFrame: CTFrame
    /// - Returns: CTLine
    public static func getTouchLine(point: CGPoint,
                                    ctFrame: CTFrame) -> CTLine? {
        var line: CTLine? = nil
        let path: CGPath = CTFrameGetPath(ctFrame)
        let bounds: CGRect = path.boundingBox
        let lines: [CTLine] = CTFrameGetLines(ctFrame) as! [CTLine]
        if lines.isEmpty { return line }
        let lineCount = lines.count
        let origins = malloc(lineCount * MemoryLayout<CGPoint>.size).assumingMemoryBound(to: CGPoint.self)
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), origins)
        for i in 0..<lineCount {
            let origin: CGPoint = origins[i]
            let tempLine: CTLine = lines[i]
            var lineAscent: CGFloat = 0
            var lineDescent: CGFloat = 0
            var lineLeading: CGFloat = 0
            CTLineGetTypographicBounds(tempLine, &lineAscent, &lineDescent, &lineLeading)
            let lineWidth: CGFloat = bounds.width
            let lineheight: CGFloat = lineAscent + lineDescent + lineLeading
            var lineFrame = CGRect(x: origin.x, y: bounds.height - origin.y - lineAscent, width: lineWidth, height: lineheight)
            lineFrame = lineFrame.insetBy(dx: -5, dy: -5)
            if lineFrame.contains(point) {
                line = tempLine
                break
            }
        }
        free(origins)
        return line
    }
    
    /// 通过 range 返回字符串所覆盖的位置 [CGRect]
    ///
    /// - Parameter range: NSRange
    /// - Parameter ctFrame: CTFrame
    /// - Parameter content: 内容字符串(有值则可以去除选中每一行区域内的 开头空格 - 尾部换行符 - 所占用的区域,不传默认返回每一行实际占用区域)
    /// - Returns: 覆盖位置
    public static func getRangeRects(range: NSRange,
                                     ctFrame: CTFrame,
                                     content: String) -> [CGRect] {
        var rects: [CGRect] = []
        if range.length == 0 || range.location == NSNotFound { return rects }
        let lines: [CTLine] = CTFrameGetLines(ctFrame) as! [CTLine]
        if lines.isEmpty { return rects }
        let lineCount: Int = lines.count
        let origins = malloc(lineCount * MemoryLayout<CGPoint>.size).assumingMemoryBound(to: CGPoint.self)
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), origins)
        for i in 0..<lineCount {
            let line: CTLine = lines[i]
            let lineCFRange = CTLineGetStringRange(line)
            let lineRange = NSMakeRange(lineCFRange.location == kCFNotFound ? NSNotFound : lineCFRange.location, lineCFRange.length)
            var contentRange: NSRange = NSMakeRange(NSNotFound, 0)
            if (lineRange.location + lineRange.length) > range.location && lineRange.location < (range.location + range.length) {
                contentRange.location = max(lineRange.location, range.location)
                let end = min(lineRange.location + lineRange.length, range.location + range.length)
                contentRange.length = end - contentRange.location
            }
            if contentRange.length > 0 {
                // 去掉 -> 开头空格 - 尾部换行符 - 所占用的区域
                if !content.isEmpty {
                    let tempContent: String = content.cz_subString(range: contentRange)
                    if let spaceExpression = try? CZRegularManage(pattern: "\\s\\s", options: .caseInsensitive) {
                        let result = spaceExpression.matches(string: tempContent, options: .reportProgress)
                        if !result.isEmpty {
                            let spaceRange = result.first!.range
                            contentRange = NSMakeRange(contentRange.location + spaceRange.length, contentRange.length - spaceRange.length)
                        }
                    }
                    if let spaceExpression = try? CZRegularManage(pattern: "\\n", options: .caseInsensitive) {
                        let result = spaceExpression.matches(string: tempContent, options: .reportProgress)
                        if !result.isEmpty {
                            let enterRange = result.first!.range
                            contentRange = NSMakeRange(contentRange.location, contentRange.length - enterRange.length)
                        }
                    }
                }
                // 正常使用(如果不需要排除段头空格跟段尾换行符可将上面代码删除)
                let xStart: CGFloat = CTLineGetOffsetForStringIndex(line, contentRange.location, nil)
                let xEnd: CGFloat = CTLineGetOffsetForStringIndex(line, contentRange.location + contentRange.length, nil)
                let origin: CGPoint = origins[i]
                var lineAscent: CGFloat = 0
                var lineDescent: CGFloat = 0
                var lineLeading: CGFloat = 0
                CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading)
                let contentRect: CGRect = CGRect(x: origin.x + xStart, y: origin.y - lineDescent, width: abs(xEnd - xStart), height: lineAscent + lineDescent + lineLeading)
                
                rects.append(contentRect)
            }
        }
        
        free(origins)
        
        return rects
    }
}
