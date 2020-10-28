//
//  CZKitCommon.swift
//  Random
//
//  Created by 刘超正 on 2019/9/21.
//  Copyright © 2019 刘超正. All rights reserved.
//

import UIKit

/// 调试输出
///
/// - Parameters:
///   - message: 打印内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行数
public func cz_print(_ items: Any..., file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\n********** CZKit debug **********\n类名名称     :     \((file as NSString).lastPathComponent)\n内存地址     :     \(String(format: "%p", items))\n方法名称     :     \(method)\n打印位置     :     第\(line)行\n打印内容     :     \(items)\n")
    #endif
}


public class CZCommon: NSObject {
    
    /// 获取屏幕大小
    public static var cz_screenSize: CGSize { return UIScreen.main.bounds.size }

    /// 获取屏幕高度
    public static var cz_screenHeight: CGFloat { return UIScreen.main.bounds.height }

    /// 获取TabBar高度
    public static var cz_tabbarHeight: CGFloat { return UITabBarController().tabBar.frame.height }

    /// 获取导航条高度
    public static var cz_navigationHeight: CGFloat { return UINavigationController().navigationBar.frame.height }

    /// 获取状态栏高度
    public static var cz_statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = CZCommon.cz_lastWindow()?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight =  UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }

    /// 获取屏幕宽度比例
    public static var cz_screenWidthScale: CGFloat {
        if UIDevice.current.model == "iPad" {
            return CZCommon.cz_screenWidth / 768.0
        } else {
            return CZCommon.cz_screenWidth / 375.0
        }
    }
    
    /// 获取屏幕高度比例
    public static var cz_screenHeightScale: CGFloat {
        if UIDevice.current.model == "iPad" {
            return CZCommon.cz_screenHeight / 1024.0
        } else {
            return CZCommon.cz_screenHeight / 667.0
        }
    }
    
    /// 判断是否是Ipad
    public static var cz_isIpad: Bool {
        return UIDevice.current.model == "iPad"
    }
    
    /// 判断是否是iPhone
    public static var cz_isIphone: Bool {
        return UIDevice.current.model == "iPhone"
    }
    
    /// 动态适应宽度
    public static func cz_dynamicFitWidth(_ size: CGFloat) -> CGFloat { return size * CZCommon.cz_screenWidthScale }
    
    /// 动态适应高度
    public static func cz_dynamicFitHeight(_ size: CGFloat) -> CGFloat { return size * CZCommon.cz_screenHeightScale }
    
    /// 获取屏幕宽度
    public static var cz_screenWidth: CGFloat { return UIScreen.main.bounds.width }
    
    /// 获取当前APP版本号
    public static var cz_appVersion: String { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String }

    /// 获取APP名称  Xcode 11需要在info.plist里面添加 Bundle display name
    public static var cz_appName: String { return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String }

    /// 获取沙盒Document路径
    public static var cz_documentPath: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    }

    /// 获取沙盒Library路径
    public static var cz_libraryPath: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true).first!
    }
    
    /// 获取沙盒caches路径
    public static var cz_cachesPath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true).first!
    }

    /// 获取沙盒tmp路径
    public static var cz_tmpPath: String { return NSTemporaryDirectory() }

    /// 删除所有偏好设置
    public static func cz_removeAllUserDefaults() -> Void {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    /// 清理 LaunchScreen 缓存
    public static func cz_clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }

    /// 跳转到AppStore进行评分
    /// - Parameter appId: appId
    public static func cz_jumpAppStoreScore(_ appId: String) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?action=write-review&mt=8")!, options: [:], completionHandler: nil)
    }

    /// 跳转到AppStore首页
    /// - Parameter appId: appId
    public static func cz_jumpAppStotrScore(_ appId: String) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?mt=8")!, options: [:], completionHandler: nil)
    }

    /// 应用是否是第一次启动
    public static func cz_isFirstLaunch() -> Bool {
        let hasBeenLaunched = "hasBeenLaunched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }

    /// 当前版本是否是第一次启动
    public static func cz_isFirstLaunchOfNewVersion() -> Bool {
        //主程序版本号
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
        //上次启动的版本号
        let hasBeenLaunchedOfNewVersion = "hasBeenLaunchedOfNewVersion"
        let lastLaunchVersion = UserDefaults.standard.string(forKey:
            hasBeenLaunchedOfNewVersion)
        //版本号比较
        let isFirstLaunchOfNewVersion = majorVersion != lastLaunchVersion
        if isFirstLaunchOfNewVersion {
            UserDefaults.standard.set(majorVersion, forKey:
                hasBeenLaunchedOfNewVersion)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunchOfNewVersion
    }

    /// 调用系统拨号
    /// - Parameter phoneNumber: phoneNumber
    public static func cz_callSystemDial(phoneNumber: String) {
        UIApplication.shared.open(URL(string: "tel://\(phoneNumber)")!, options: [:], completionHandler: nil)
    }

    /// 获取最上层window
    public static func cz_lastWindow() -> UIWindow? {
        for window in UIApplication.shared.windows.reversed() {
            if window.isKind(of: UIWindow.self) && window.bounds == UIScreen.main.bounds {
                return window
            }
        }
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }

    /// 获取最上层的控制器
    public static func cz_topmostController(_ viewController: UIViewController = (UIApplication.shared.delegate?.window?!.rootViewController)!) -> UIViewController {
        if viewController.isKind(of: UINavigationController.self) {
            return CZCommon.cz_topmostController((viewController as! UINavigationController).visibleViewController!)
        } else if viewController.isKind(of: UITabBarController.self) {
            return CZCommon.cz_topmostController((viewController as! UITabBarController).selectedViewController!)
        } else {
            if (viewController.presentedViewController != nil) {
                return CZCommon.cz_topmostController(viewController.presentedViewController!)
            } else {
                return viewController
            }
        }
    }
    
    /// 获取指定年月开始日期
    public static func cz_specifiedYearStartDate(year: Int, month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    /// 获取指定年月结束日期 returnEndTime：true 则为23:59:59 false： 00:00:00
    public static  func cz_specifiedYearEndDate(year: Int, month: Int, returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        let endOfYear = calendar.date(byAdding: components, to: CZCommon.cz_specifiedYearStartDate(year: year, month:month))!
        return endOfYear
    }
    
    
    /// 检测是否开启了网络代理
    /// - Parameter complete: false: 开启了代理  true：未开启代理
    public static func cz_isProxyDetection() -> Bool {
        let proxySettings = CFNetworkCopySystemProxySettings()!.takeUnretainedValue()
        let arr = CFNetworkCopyProxiesForURL(URL(string: "https://www.baidu.com")! as CFURL, proxySettings).takeUnretainedValue()
        let obj = (arr as [AnyObject]).first
        return obj?.object(forKey: kCFProxyTypeKey) == kCFProxyTypeNone
    }
    
    /// 通过字符串转类  cz_classFromString(className: model.moduleControllerName!, classType: UIViewController.self)!
    /// - Parameters:
    ///   - className: 字符串类名
    ///   - classType: 类型
    public static func cz_classFromString<T>(className: String, classType: T.Type) -> T.Type? {
        guard let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return nil }
        let classStringName = appName + "." + className
        guard let className = NSClassFromString(classStringName) as? T.Type else { return nil }
        return className
    }
    
    /// 返回gbk编码格式
    public static func cz_gbkEncoding() -> String.Encoding {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        return String.Encoding(rawValue: encoding)
    }
    
    /// iphone4
    public static let cz_iphone4: Bool = cz_screenHeight == CGFloat(480) && cz_screenWidth == CGFloat(320)

    /// iphone5
    public static let cz_iphone5: Bool = cz_screenHeight == CGFloat(568) && cz_screenWidth == CGFloat(320)
    
    /// iphone6 /  iphone7 /  iphone8
    public static let cz_iphone678: Bool = cz_screenHeight == CGFloat(667) && cz_screenWidth == CGFloat(375)
    
    /// iphone6P /  iphone7P /  iphone8P
    public static let cz_iphone678Plus: Bool = cz_screenHeight == CGFloat(736) && cz_screenWidth == CGFloat(414)
    
    /// iphoneX / iphoneXS / iPhone 11 Pro
    public static let cz_iphoneX: Bool = cz_screenHeight == CGFloat(812) && cz_screenWidth == CGFloat(375)
    
    /// iphoneXR / iphoneXS MAX / iPhone 11 Pro Max /  iPhone 11
    public static let cz_iphoneXR: Bool = cz_screenHeight == CGFloat(896) && cz_screenWidth == CGFloat(414)
    
    /// 安全区域高度
    public static let cz_safeAreaHeight: CGFloat = CZCommon.cz_lastWindow()?.safeAreaInsets.bottom ?? 0.0
    
    /// 刘海屏设备
//    public static let cz_bangScreenDevice: Bool = cz_iphoneX || cz_iphoneXR
    
    /// 清理WKWebView缓存
    public static func cz_clearWKWebViewCache() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
            for record in records{
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        })
    }

}
