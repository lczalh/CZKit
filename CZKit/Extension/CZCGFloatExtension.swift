//
//  CZCGFloatExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/11/25.
//

import Foundation

public extension CGFloat {
    
    /// 角度转换为弧度
    var cz_angleConversionRadian: CGFloat {
        return self / 180 * .pi
    }
    
    /// 弧度转换为角度
    var cz_radianConversionAngle: CGFloat {
        return self * 180 / .pi
    }
}


