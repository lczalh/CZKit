//
//  CZImageExtension.swift
//  Random
//
//  Created by yu mingming on 2019/11/29.
//  Copyright © 2019 刘超正. All rights reserved.
//

import Foundation

public extension UIImage {
     
    
    /// 将图片裁剪成指定比例（多余部分自动删除）
    /// - Parameter ratio: 比例
    func cz_crop(ratio: CGFloat) -> UIImage {
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
     
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height
        rect.origin.x    = (newSize.width - size.width ) / 2.0
        rect.origin.y    = (newSize.height - size.height ) / 2.0
         
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return scaledImage!
    }
    
    
    /// 将图片缩放成指定尺寸（多余部分自动删除）
    /// - Parameter size: 尺寸
    func cz_scaled(size: CGSize) -> UIImage {
        //计算比例
        let aspectWidth  = size.width/size.width
        let aspectHeight = size.height/size.height
        let aspectRatio = max(aspectWidth, aspectHeight)
         
        //图片绘制区域
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width  = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x    = (size.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y    = (size.height - size.height * aspectRatio) / 2.0
         
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(size)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        return scaledImage!
    }
    
    /// 修改图片颜色
    /// - Parameter color: 颜色
    /// - Parameter blendMode: 模式
    func cz_alterColor(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage
    {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        UIRectFill(drawRect)
        self.draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}
