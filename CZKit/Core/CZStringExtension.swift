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
    
//    /// 正则表达式替换
//    /// - Parameters:
//    ///   - pattern: 正则表达式字符串
//    ///   - with: 替换值
//    ///   - options: 替换后的字符串
//    func cz_regularReplacement(pattern: String,
//                     with: String,
//                     options: NSRegularExpression.Options = []) -> String {
//        do {
//            let regex = try NSRegularExpression(pattern: pattern, options: options)
//            return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.count), withTemplate: with)
//        } catch {
//            return self
//        }
//
//
//    }
    
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
    var cz_removeAllSapce: String { return replacingOccurrences(of: " ", with: "", options: .literal, range: nil) }
    
    /// 去除所有换行
    var cz_removeEnterAll: String { return replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "") }

    /// 去除所有空格换行
    var cz_removeSapceEnterAll: String { return cz_removeAllSapce.replacingOccurrences(of: "\n", with: "") }
    
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
    
    init?(gbkData: Data) {
        //获取GBK编码, 使用GB18030是因为它向下兼容GBK
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        //从GBK编码的Data里初始化NSString, 返回的NSString是UTF-16编码
        if let str = NSString(data: gbkData, encoding: encoding) {
            self = str as String
        } else {
            return nil
        }
    }
    
    /// 中文字符串转GBK字符串
    var cz_chineseTurnGbkString: String {
        let pattern = "[^\\u4E00-\\u9FA5，。！、……《》（）【】：；“‘”’？￥]"
        let regex = try! CZRegex(pattern)
        var str = ""
        for i in self {
            if regex.matches(String(i)){
                str.append(i)
            }else{
                let data = String(i).data(using: .cz_gb_18030_2000)
                let bytes = [UInt8](data!)
                var string = ""
                for val in bytes {
                    string =  string + "%" + String(format: "%02X",val)
                }
                str.append(string)
            }
        }
        return str
    }
    
    /// 去除百分比编码
    func cz_removingPercentEncoding(using encoding: String.Encoding) -> String? {
        let regex = try! NSRegularExpression(pattern: "(%[0-9A-F]{2})|(.)", options: .caseInsensitive)
        var bytes = Data()
        let nsSelf = self as NSString
        for match in regex.matches(in: self, range: NSRange(0..<self.utf16.count)) {
            if match.range(at: 1).location != NSNotFound {
                let hexString = nsSelf.substring(with: NSMakeRange(match.range(at: 1).location+1, 2))
                bytes.append(UInt8(hexString, radix: 16)!)
            } else {
                let singleChar = nsSelf.substring(with: match.range(at: 2))
                bytes.append(singleChar.data(using: encoding) ?? "?".data(using: .ascii)!)
            }
        }
        return String(data: bytes, encoding: encoding)
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

