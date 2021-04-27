//
//  CZStringExtension.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension String {
    
    /// 将原始的url编码为合法的url
    func cz_encode() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    /// 将编码后的url转换回原始的url
    func cz_decode() -> String {
        return removingPercentEncoding ?? ""
    }
    
    /// 正则替换字符串
    func cz_replacingCharacters(_ pattern: String, _ template: String) -> String {
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, count), withTemplate: template)
        } catch {return self}
    }
    
    /// 去除首尾 空格 / 换行
    var cz_removeHeadAndTailSpace: String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾空格 包括后面的换行 \n
    var cz_removeHeadAndTailSpacePro: String { return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) }
    
    /// 去除所有空格
    var cz_removeAllSapce: String { return replacingOccurrences(of: " ", with: "") }
    
    /// 去除所有 \r \n \t
    var cz_removeEnterAll: String { return replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: "") }
    
    /// 去除所有空格换行
    //  var cz_removeSapceEnterAll: String { return cz_removeAllSapce.replacingOccurrences(of: "\n", with: "") }
    
    /// 通过时间字符串获取日期（Date）
    ///
    /// - Parameters:
    ///   - dateFormat: 日期格式
    /// - Returns: 日期
    func cz_conversionDate(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: self)
        return date!
    }
    
    /// 通过时间字符串获取时间戳
    ///
    /// - Parameters:
    ///   - time: 时间字符串
    ///   - dateFormat: 时间格式
    /// - Returns: 时间戳
    func cz_toTimeStamp(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Double {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let last = dfmatter.date(from: self)
        let timeStamp = last?.timeIntervalSince1970
        return timeStamp!
    }
    
    /// 中文字符串转GBK字符串
    var cz_utf8TurnGbkEncode: String {
        guard let regex = try? CZRegularManage(pattern: "[^\\u4E00-\\u9FA5，。！、……《》（）【】：；“‘”’？￥]") else { return "" }
        var gbkString = ""
        for i in self {
            if regex.firstMatch(in: String(i)) != nil {
                gbkString.append(i)
            } else {
                let data = String(i).data(using: .cz_gb_18030_2000)
                let bytes = [UInt8](data!)
                var string = ""
                for val in bytes {
                    string =  string + "%" + String(format: "%02X",val)
                }
                gbkString.append(string)
            }
        }
        return gbkString
    }
    
    /// 去除百分比编码
    var cz_gbkTurnUtf8Encode: String {
        guard let regex = try? CZRegularManage(pattern: "(%[0-9A-F]{2})|(.)", options: .caseInsensitive) else { return "" }
        var bytes = Data()
        for match in regex.matches(string: self) {
            if match.range(at: 1).location != NSNotFound {
                let hexString = cz_subString(location: match.range(at: 1).location+1, length: 2)
                bytes.append(UInt8(hexString, radix: 16)!)
            } else {
                let singleChar = cz_subString(location: match.range(at: 2).location, length: match.range(at: 2).length)
                bytes.append(singleChar.data(using: .cz_gb_18030_2000) ?? "?".data(using: .ascii)!)
            }
        }
        return String(data: bytes, encoding: .cz_gb_18030_2000) ?? ""
    }
    
    /// 计算字符串宽度
    /// - Parameters:
    ///   - text: 内容
    ///   - font: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    func cz_textWidth(font : UIFont, height: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size.width
    }
    
    /// 计算字符串高度
    /// - Parameters:
    ///   - text: 内容
    ///   - font: 字体大小
    ///   - width: 宽度
    /// - Returns: 高度
    func cz_textHeight(font : UIFont, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size.height
    }
    
    /// 字符串截取
    /// - Parameters:
    ///   - location: 起始位置
    ///   - length: 长度
    ///   - suffix: 后缀
    /// - Returns: 截取后的字符串
    func cz_subString(location: Int, length: Int, suffix: String? = nil) -> String {
        guard length < count else {  return self }
        let start = index(startIndex, offsetBy: location)
        let end = index(start, offsetBy: length)
        let result = String(self[start ..< end])
        if let suffix = suffix {
            return "\(result)\(suffix)"
        } else {
            return result
        }
    }
    
    /// 设置文字行间距
    /// - Parameters:
    ///   - lineSpacing: 间距
    ///   - font: 字体
    /// - Returns: NSAttributedString
    func cz_setLineSpacing(lineSpacing: CGFloat, font: UIFont) -> NSAttributedString {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paraph]
        return NSAttributedString(string: self, attributes: attributes)
    }
}

public extension String.Encoding {
    /// gbk编码
    static let cz_gb_18030_2000 = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
}

public extension NSString {
    
    /// 计算字符串宽度
    ///
    /// - Parameters:
    ///   - font: 待显示的文字大小
    ///   - size: 预估字符串大小
    ///   - text: 字符串
    /// - Returns: CGSize
    func cz_textWidth(font: UIFont, size: CGSize = CGSize(width: CGFloat(MAXFLOAT), height: CZDeviceManage.screenHeight)) -> CGSize {
        var textSize:CGSize
        if __CGSizeEqualToSize(size,CGSize.zero){
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = self.size(withAttributes:attributes as? [NSAttributedString.Key : Any])
        }else{
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            let stringRect = self.boundingRect(with:size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes as? [NSAttributedString.Key : Any], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
    
    /// 计算字符串高度
    ///
    /// - Parameters:
    ///   - font: 待显示的文字大小
    ///   - size: 预估字符串大小
    ///   - text: 字符串
    /// - Returns: CGSize
    func cz_textHeight(font: UIFont, size: CGSize = CGSize(width: CZDeviceManage.screenWidth, height: CGFloat(MAXFLOAT))) -> CGSize {
        var textSize:CGSize
        if __CGSizeEqualToSize(size,CGSize.zero){
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = self.size(withAttributes:attributes as? [NSAttributedString.Key : Any])
        }else{
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            let stringRect = self.boundingRect(with:size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes as? [NSAttributedString.Key : Any], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}

