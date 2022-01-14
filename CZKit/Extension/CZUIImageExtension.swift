//
//  CZImageExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/11/29.
//

import Foundation
import UIKit

public extension UIImage {
    
    /// 修改图片颜色
    /// - Parameter color: 颜色
    /// - Parameter blendMode: 模式
    func cz_alterColor(color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        UIRectFill(drawRect)
        self.draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    /// 保存图片到相册
    /// - Parameters:
    ///   - completionTarget: self
    ///   - completionSelector: #selector(image(image:didFinishSavingWithError:contextInfo:))
    ///   - contextInfo: contextInfo description
    func cz_savedPhotosAlbum(_ completionTarget: Any?, _ completionSelector: Selector?, _ contextInfo: UnsafeMutableRawPointer? = nil) {
        UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, contextInfo)
    }
    
    /// 获取图片平均颜色
    var cz_averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    /// 修复转向
    func cz_fixOrientation() -> UIImage {
        if self.imageOrientation == .up { return self }
        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = CGAffineTransform(translationX: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = CGAffineTransform(translationX: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
        case .right, .rightMirrored:
            transform = CGAffineTransform(translationX: 0, y: self.size.height)
            transform = transform.rotated(by: -CGFloat.pi / 2)
        default:
            break
        }
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        guard let ci = self.cgImage, let colorSpace = ci.colorSpace else {
            return self
        }
        let context = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: ci.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: ci.bitmapInfo.rawValue)
        context?.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context?.draw(ci, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        default:
            context?.draw(ci, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        }
        guard let newCgimg = context?.makeImage() else { return self }
        return UIImage(cgImage: newCgimg)
    }
    
    /// 获取范围内的图片等比大小
    /// - Parameters:
    ///   - maxHeight: 限制最大高度，默认最大图片的高度
    ///   - maxWidth: 现在最大宽度，默认最大图片的宽度
    /// - Returns: 范围内的等比大小
    func cz_getWithinScopeEqualRatioSize(maxHeight: CGFloat? = nil, maxWidth: CGFloat? = nil) -> CGSize {
        var imageHeight: CGFloat = 0
        var imageWidth: CGFloat = 0
        let maxHeight = maxHeight ?? size.height
        let maxWidth = maxWidth ?? size.width
        let widthRatio = size.width / maxWidth
        let heightRatio = size.height / maxHeight
        if widthRatio >= heightRatio {
            imageWidth = maxWidth
            imageHeight = size.height / widthRatio
        } else {
            imageWidth = size.width / heightRatio
            imageHeight = maxHeight
        }
        return CGSize(width: imageWidth, height: imageHeight)
    }
    
    
    /// 裁剪图片
    /// - Parameters:
    ///   - angle: 角度
    ///   - editRect: 裁剪范围
    ///   - isCircle: 是否裁剪为圆
    /// - Returns: 裁剪后的图片
    func cz_clipImage(angle: CGFloat, editRect: CGRect, isCircle: Bool) -> UIImage? {
        let a = ((Int(angle) % 360) - 360) % 360
        var newImage = self
        if a == -90 {
            newImage = self.cz_rotate(orientation: .left)
        } else if a == -180 {
            newImage = self.cz_rotate(orientation: .down)
        } else if a == -270 {
            newImage = self.cz_rotate(orientation: .right)
        }
        guard editRect.size != newImage.size else { return newImage }
        let origin = CGPoint(x: -editRect.minX, y: -editRect.minY)
        UIGraphicsBeginImageContextWithOptions(editRect.size, false, newImage.scale)
        let context = UIGraphicsGetCurrentContext()
        if isCircle {
            context?.addEllipse(in: CGRect(origin: .zero, size: editRect.size))
            context?.clip()
        }
        newImage.draw(at: origin)
        let temp = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgi = temp?.cgImage else {
            return temp
        }
        let clipImage = UIImage(cgImage: cgi, scale: newImage.scale, orientation: .up)
        return clipImage
    }
    
    /// 旋转方向
    func cz_rotate(orientation: UIImage.Orientation) -> UIImage {
        guard let imagRef = self.cgImage else {
            return self
        }
        let rect = CGRect(origin: .zero, size: CGSize(width: CGFloat(imagRef.width), height: CGFloat(imagRef.height)))
        
        var bnds = rect
        
        var transform = CGAffineTransform.identity
        
        switch orientation {
        case .up:
            return self
        case .upMirrored:
            transform = transform.translatedBy(x: rect.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .down:
            transform = transform.translatedBy(x: rect.width, y: rect.height)
            transform = transform.rotated(by: .pi)
        case .downMirrored:
            transform = transform.translatedBy(x: 0, y: rect.height)
            transform = transform.scaledBy(x: 1, y: -1)
        case .left:
            bnds = cz_swapRectWidthAndHeight(bnds)
            transform = transform.translatedBy(x: 0, y: rect.width)
            transform = transform.rotated(by: CGFloat.pi * 3 / 2)
        case .leftMirrored:
            bnds = cz_swapRectWidthAndHeight(bnds)
            transform = transform.translatedBy(x: rect.height, y: rect.width)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat.pi * 3 / 2)
        case .right:
            bnds = cz_swapRectWidthAndHeight(bnds)
            transform = transform.translatedBy(x: rect.height, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
        case .rightMirrored:
            bnds = cz_swapRectWidthAndHeight(bnds)
            transform = transform.scaledBy(x: -1, y: 1)
            transform = transform.rotated(by: CGFloat.pi / 2)
        @unknown default:
            return self
        }
        
        UIGraphicsBeginImageContext(bnds.size)
        let context = UIGraphicsGetCurrentContext()
        switch orientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context?.scaleBy(x: -1, y: 1)
            context?.translateBy(x: -rect.height, y: 0)
        default:
            context?.scaleBy(x: 1, y: -1)
            context?.translateBy(x: 0, y: -rect.height)
        }
        context?.concatenate(transform)
        context?.draw(imagRef, in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    /// 交换宽高
    private func cz_swapRectWidthAndHeight(_ rect: CGRect) -> CGRect {
        var r = rect
        r.size.width = rect.height
        r.size.height = rect.width
        return r
    }
}
