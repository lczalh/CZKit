//
//  CZStringExtension.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//

import Foundation

public extension String {
    
    //将原始的url编码为合法的url
    func cz_encoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
     
    //将编码后的url转换回原始的url
    func cz_decoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    /// 正则表达式替换
    /// - Parameters:
    ///   - pattern: 正则表达式字符串
    ///   - with: 替换值
    ///   - options: 替换后的字符串
    func cz_regularReplacement(pattern: String,
                     with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: with)
    }
    
    
    /// 去除首尾空格
    var cz_removeHeadAndTailSpace: String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    
    /// 去除首尾空格 包括后面的换行 \n
    var cz_removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    /// 去除所有空格
    var cz_removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
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
}

public extension NSString {
    
    /// 计算字符串宽度
    ///
    /// - Parameters:
    ///   - font: 待显示的文字大小
    ///   - size: 预估字符串大小
    ///   - text: 字符串
    /// - Returns: CGSize
    func cz_textWidth(font: UIFont, size: CGSize = CGSize(width: CGFloat(MAXFLOAT), height: CZCommon.cz_screenHeight)) -> CGSize {
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
    func cz_textHeight(font: UIFont, size: CGSize = CGSize(width: CZCommon.cz_screenWidth, height: CGFloat(MAXFLOAT))) -> CGSize {
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