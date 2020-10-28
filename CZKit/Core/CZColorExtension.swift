//
//  CZColorExtension.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//

import Foundation

public extension UIColor {
    
    /// 通过RGB获取颜色
    static func cz_rgbColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        return .init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }

    /// 通过16进制数获取颜色
    static func cz_hexColor(_ hex: String, _ alpha: CGFloat = 1) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) { cString.remove(at: cString.startIndex) }
        if ((cString.count) != 6) { return UIColor.gray }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    /// 获取随机颜色
    static var cz_randomColor: UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
