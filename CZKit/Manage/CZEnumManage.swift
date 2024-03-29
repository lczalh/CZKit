//
//  CZEnum.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/4/1.
//

import Foundation

/// 枚举协议
public protocol CZEnumValueProtocol {
    var value: String { get }
}

/// 应用跳转枚举
public enum CZApplicationJumpEnum: CZEnumValueProtocol {
    case 打电话(tel: String)
    case 商店首页(appId: String)
    case 商店评分(appId: String)
    case 设置
    case 发短信(tel: String)
    case 发邮件
    case 其它(path: String)
    
    public var value: String {
        switch self {
        case .打电话(let tel):
            return "tel://\(tel)"
        case .商店首页(let appId):
            return "https://itunes.apple.com/us/app/itunes-u/id\(appId)?mt=8"
        case .商店评分(let appId):
            return "https://itunes.apple.com/us/app/itunes-u/id\(appId)?action=write-review&mt=8"
        case .设置:
            return UIApplication.openSettingsURLString
        case .发短信(let tel):
            return "sms://\(tel)"
        case .其它(let path):
            return path
        case .发邮件:
            return "mailto://"
        }
    }
}

/// 正则枚举
public enum CZRegularEnum: CZEnumValueProtocol {
    case 中文(totalLenght: Int? = nil)
    case 英文(totalLenght: Int? = nil)
    case 中文_英文(totalLenght: Int? = nil)
    case 中文_数字(totalLenght: Int? = nil)
    case 中文_英文_数字(totalLenght: Int? = nil)
    case 数字(totalLenght: Int? = nil)
    /// numberLenght: 数字长度 decimalLenght：小数点后的长度
    case 数字_小数(numberLenght: Int? = nil, decimalLenght: Int? = nil)
    case 英文_数字(totalLenght: Int? = nil)
    case 手机号码
    /// numberLenght: 除去首位数字后的长度 decimalLenght：小数点后的长度 specifyValue：指定匹配的数值
    case 零和非零开头的数字_小数(numberLenght: Int? = nil, decimalLenght: Int? = nil, specifyValue: Int? = nil)
    case 其它(regularString: String)
    
    public var value: String {
        switch self {
        case .中文(let totalLenght):
            return "^[\\u4e00-\\u9fa5]{0,\(totalLenght?.cz_string ?? "")}$"
        case .英文(let totalLenght):
            return "^[A-Za-z]{0,\(totalLenght?.cz_string ?? "")}$"
        case .中文_英文(let totalLenght):
            return "^[\\u4E00-\\u9FA5A-Za-z]{0,\(totalLenght?.cz_string ?? "")}$"
        case .中文_数字(let totalLenght):
            return "^[\\u4E00-\\u9FA50-9]{0,\(totalLenght?.cz_string ?? "")}$"
        case .中文_英文_数字(let totalLenght):
            return "^[\\u4E00-\\u9FA5A-Za-z0-9]{0,\(totalLenght?.cz_string ?? "")}$"
        case .数字(let totalLenght):
            return "^[0-9]{0,\(totalLenght?.cz_string ?? "")}$"
        case .数字_小数(let numberLenght, let decimalLenght):
            return "^([0-9]{0,\(numberLenght?.cz_string ?? "")})(\\.[0-9]{0,\(decimalLenght?.cz_string ?? "")})?$"
        case .其它(let regularString):
            return regularString
        case .英文_数字(let totalLenght):
            return "^[A-Za-z0-9]{0,\(totalLenght?.cz_string ?? "")}$"
        case .手机号码:
            return "^(1[0-9]{0,10})?$"
        case .零和非零开头的数字_小数(let numberLenght, let decimalLenght, let specifyValue):
            return "^(((0|[1-9][0-9]{0,\(numberLenght?.cz_string ?? "")})((\\.)[0-9]{0,\(decimalLenght?.cz_string ?? "")})?)|\(specifyValue?.cz_string ?? ""))?$"
        }
    }
    
}

/// 比较类型枚举
public enum CZCompareTypeEnum: Int {
    case 等于 = 0
    case 小于 = 1
    case 大于 = 2
}

/// 应用更新类型枚举
public enum CZApplyUpdateTypeEnum: Int {
    case 无须更新 = 0
    case 提示更新 = 1
    case 强制更新 = 2
}
