//
//  UIImage+CZ.swift
//  Random
//
//  Created by yu mingming on 2019/10/25.
//  Copyright © 2019 刘超正. All rights reserved.
//

import Foundation

public extension CZ where Base: UIImage {
    
    /// 修改图片颜色
    /// - Parameter color: 颜色
    /// - Parameter blendMode: 模式
    @discardableResult
    func alterColor(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage
    {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: base.size.width, height: base.size.height)
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        color.setFill()
        UIRectFill(drawRect)
        base.draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
