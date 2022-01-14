//
//  CZCommonManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/21.
//

import Foundation
import UIKit

/// 调试输出
///
/// - Parameters:
///   - message: 打印内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行数
public func cz_print(_ message: Any..., file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\n********** CZKit debug **********\n类名名称     :     \((file as NSString).lastPathComponent)\n内存地址     :     \(String(format: "%p", message))\n方法名称     :     \(method)\n打印位置     :     第\(line)行\n打印内容     :     \(message)\n")
    #endif
}


/// 主线程队列回调
public func cz_mainAsync(after: TimeInterval = 0, handler: @escaping (() -> Void)) {
    if after > 0 {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    } else {
        DispatchQueue.main.async {
            handler()
        }
    }
}

/// 全局异步队列
public func cz_globalAsync(after: TimeInterval = 0, handler: @escaping (() -> Void)) {
    if after > 0 {
        DispatchQueue.global().asyncAfter(deadline: .now() + after) {
            handler()
        }
    } else {
        DispatchQueue.global().async {
            handler()
        }
    }
}

public struct CZCommonManage {
    
    /// 动态适应宽度
    public static func dynamicFitWidth(_ width: CGFloat) -> CGFloat { return width * CZDeviceManage.screenWidthScale }
    
    /// 动态适应高度
    public static func dynamicFitHeight(_ height: CGFloat) -> CGFloat { return height * CZDeviceManage.screenHeightScale }
    
    /// 获取指定年月开始日期
    public static func specifiedYearStartDate(year: Int,
                                              month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps) ?? Date()
        return startDate
    }
    
    /// 获取指定年月结束日期 returnEndTime：true 则为23:59:59 false： 00:00:00
    public static  func specifiedYearEndDate(year: Int,
                                             month: Int,
                                             returnEndTime: Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let endOfYear = calendar.date(byAdding: components, to: CZCommonManage.specifiedYearStartDate(year: year, month: month)) ?? Date()
        return endOfYear
    }
    
    
    /// 检测是否开启了网络代理
    /// - Parameter complete: false: 开启了代理  true：未开启代理
    public static func isProxyDetection() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue(), let url = URL(string: "https://www.baidu.com") else { return false }
        let arr = CFNetworkCopyProxiesForURL(url as CFURL, proxySettings).takeUnretainedValue()
        let obj = (arr as [AnyObject]).first
        return obj?.object(forKey: kCFProxyTypeKey) == kCFProxyTypeNone
    }
    
    /// 通过字符串转类  cz_classFromString(className: model.moduleControllerName!, classType: UIViewController.self)!
    /// - Parameters:
    ///   - className: 字符串类名
    ///   - classType: 类型
    public static func classFromString<T>(className: String,
                                          classType: T.Type) -> T.Type? {
        guard let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return nil }
        let classStringName = appName + "." + className
        guard let className = NSClassFromString(classStringName) as? T.Type else { return nil }
        return className
    }
    
    /// 返回gbk编码格式
    public static func gbkEncoding() -> String.Encoding {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        return String.Encoding(rawValue: encoding)
    }
    
    /// 获取渐变颜色
    public static func gradientColor(bounds: CGRect,
                                     colors: [CGColor],
                                     locations: [NSNumber]? = nil,
                                     startPoint: CGPoint = CGPoint(x: 0, y: 0),
                                     endPoint: CGPoint = CGPoint(x: 1, y: 0)) -> UIColor? {
        UIGraphicsBeginImageContext(bounds.size)
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = locations
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image)
    }
    
    /// 创建二维码
    /// - Parameters:
    ///   - content: 二维码内容
    ///   - defaultImage: 无数据图片
    ///   - logoImage: logo
    ///   - color: 二维码颜色
    ///   - completion: 创建完成回调
    public static func createQrCode(_ content: String?,
                                    _ defaultImage: UIImage? = nil,
                                    _ logoImage: UIImage? = nil,
                                    _ color: UIColor = .cz_hexColor("#333333"),
                                    _ transformScale: CGFloat = 10,
                                    _ completion: ((_ image: UIImage?) -> Void)?) {
        guard let content = content, content.isEmpty == false else {
            completion?(defaultImage)
            return
        }
        DispatchQueue.global().async {
            let stringData = content.data(using: .utf8, allowLossyConversion: false)
            // 创建一个二维码的滤镜
            guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
                completion?(defaultImage)
                return
            }
            qrFilter.setValue(stringData, forKey: "inputMessage")
            // 设置二维码颜色
            // 反转颜色
            guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else {
                completion?(defaultImage)
                return
            }
            invertedColorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
            // 将所有黑色转换为透明
            guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else {
                completion?(defaultImage)
                return
            }
            blackTransparentFilter.setValue(invertedColorFilter.outputImage, forKey: "inputImage")
            // 应用给定的颜色作为色调颜色
            guard  let transparentQRImage = blackTransparentFilter.outputImage,
                   let filter = CIFilter(name: "CIMultiplyCompositing"),
                   let colorFilter = CIFilter(name: "CIConstantColorGenerator") else {
                       completion?(defaultImage)
                       return
                   }
            let ciColor = CIColor(color: color)
            colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
            let colorImage = colorFilter.outputImage
            filter.setValue(colorImage, forKey: kCIInputImageKey)
            filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)
            // 返回二维码image
            guard let outputImage = filter.outputImage else {
                completion?(defaultImage)
                return
            }
            let codeImage = UIImage(ciImage: outputImage.transformed(by: CGAffineTransform(scaleX: transformScale, y: transformScale)))
            // 通常,二维码都是定制的,中间都会放想要表达意思的图片
            if let iconImage = logoImage {
                let rect = CGRect(x:0, y:0, width:codeImage.size.width, height:codeImage.size.height)
                UIGraphicsBeginImageContext(rect.size)
                codeImage.draw(in: rect)
                let avatarSize = CGSize(width:rect.size.width * 0.25, height:rect.size.height * 0.25)
                let x = (rect.width - avatarSize.width) * 0.5
                let y = (rect.height - avatarSize.height) * 0.5
                iconImage.draw(in: CGRect(x:x, y:y, width:avatarSize.width, height:avatarSize.height))
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                completion?(resultImage ?? defaultImage)
            } else {
                completion?(codeImage)
            }
        }
    }
    
    /// 根据颜色和大小创建UIImage
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    static func createImage(color: UIColor,
                            size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        UIGraphicsEndImageContext()
        return UIImage(cgImage: aCgImage)
    }

}
