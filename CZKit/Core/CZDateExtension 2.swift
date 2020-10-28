//
//  CZDate.swift
//  csomanage
//
//  Created by yu mingming on 2019/12/11.
//  Copyright © 2019 glgs. All rights reserved.
//

import Foundation

public extension Date {
    
    /// 通过日期（Date）获取时间字符串
    ///
    /// - Parameters:
    ///   - dateFormat: 日期格式
    /// - Returns: 字符串
    func cz_conversionString(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: self)
        return date
    }
}
