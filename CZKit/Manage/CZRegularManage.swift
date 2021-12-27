//
//  CZRegularManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/4/20.
//

/* 枚举类型
 一、NSRegularExpressionOptions:
 NSRegularExpressionCaseInsensitive          = 1 << 0,   // 不区分大小写的
 NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1,   // 忽略空格和# (注释符)
 NSRegularExpressionIgnoreMetacharacters        = 1 << 2,   // 整体化
 NSRegularExpressionDotMatchesLineSeparators    = 1 << 3,   // 匹配任何字符，包括行分隔符
 NSRegularExpressionAnchorsMatchLines          = 1 << 4,   // 允许^和$在匹配的开始和结束行
 NSRegularExpressionUseUnixLineSeparators      = 1 << 5,   // (查找范围为整个的话无效)
 NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6    // (查找范围为整个的话无效)
 
 二、NSMatchingOptions：
 NSMatchingReportProgress         = 1 << 0, //找到最长的匹配字符串后调用block回调
 NSMatchingReportCompletion       = 1 << 1, //找到任何一个匹配串后都回调一次block
 NSMatchingAnchored               = 1 << 2, //从匹配范围的开始处进行匹配
 NSMatchingWithTransparentBounds  = 1 << 3, //允许匹配的范围超出设置的范围
 NSMatchingWithoutAnchoringBounds = 1 << 4  //禁止^和$自动匹配行还是和结束
 
 */

import Foundation

public struct CZRegularManage {
    
    private let regularExpression: NSRegularExpression
    
    init(pattern: String,
         options: NSRegularExpression.Options = []) throws {
        regularExpression = try NSRegularExpression(pattern: pattern, options: options)
    }
    
    /// 获取所有的匹配结果
    public func matches(string: String,
                        options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        return regularExpression.matches(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }
    
    /// 获取匹配数
    public func numberOfMatches(string: String,
                                options: NSRegularExpression.MatchingOptions = []) -> Int {
        return regularExpression.numberOfMatches(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }
    
    /// 替换匹配
    /// - Parameters:
    ///   - string: 字符串
    ///   - value: 替换值
    /// - Returns: 替换后的值
    public func replacingMatches(string: String,
                                 options: NSRegularExpression.MatchingOptions = [],
                                 value: String) -> String {
        return regularExpression.stringByReplacingMatches(in: string, options: options, range: NSRange(location: 0, length: string.count), withTemplate: value)
    }
    
    
    /// 获取第一个匹配结果
    /// - Parameters:
    ///   - string: 字符串
    ///   - options: options description
    /// - Returns: 匹配结果
    public func firstMatch(in string: String,
                           options: NSRegularExpression.MatchingOptions = []) -> NSTextCheckingResult? {
        return regularExpression.firstMatch(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }
}
