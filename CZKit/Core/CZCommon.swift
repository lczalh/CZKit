//
//  CZKitCommon.swift
//  Random
//
//  Created by 刘超正 on 2019/9/21.
//  Copyright © 2019 刘超正. All rights reserved.
//

import UIKit

/// 获取当前APP版本号
public var cz_appVersion: String {
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
}

/// 获取屏幕宽度
public var cz_screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

/// 获取屏幕大小
public var cz_screenSize: CGSize {
    return UIScreen.main.bounds.size
}

/// 获取屏幕高度
public var cz_screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

/// 获取TabBar高度
public var cz_tabbarHeight: CGFloat {
    return UITabBarController().tabBar.frame.height
}

/// 获取导航条高度
public var cz_navigationHeight: CGFloat {
    return UINavigationController().navigationBar.frame.height
}

/// 获取状态栏高度
public var cz_statusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        return (cz_lastWindow()?.windowScene?.statusBarManager?.statusBarFrame.height)!
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}

/// 获取屏幕比例
public var cz_screenScale: CGFloat {
    return cz_screenWidth / 375.0
}

/// 获取APP名称  Xcode 11需要在info.plist里面添加 Bundle display name
public var cz_appName: String {
    return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
}

/// 获取沙盒Document路径
public var cz_documentPath: String {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
}

/// 获取沙盒Library路径
public var cz_libraryPath: String {
    return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true).first!
}

/// 获取沙盒tmp路径
public var cz_tmpPath: String {
    return NSTemporaryDirectory()
}

/// 调试输出
///
/// - Parameters:
///   - message: 打印内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行数
public func cz_print(_ items: Any..., file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("********** CZKit debug **********\n类名:\((file as NSString).lastPathComponent)\n方法名:\(method)\n打印位置:第\(line)行\n内存地址:\(Unmanaged.passUnretained(items as AnyObject).toOpaque())\n打印内容:\(items)")
    #endif
}

/// 通过RGB获取颜色
public func cz_rgbColor(_ red : CGFloat,_ green : CGFloat,_ blue : CGFloat,_ alpha : CGFloat = 1) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

/// 通过16进制数获取颜色
public func cz_hexColor(_ hex: String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

/// 常规字体  根据屏幕大小动态调整字体大小
public func cz_font(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: cz_screenScale * size)
}

/// 粗体字体  根据屏幕大小动态调整字体大小
public func cz_boldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: cz_screenScale * size)
}

/// 获取随机颜色
public var cz_randomColor: UIColor {
    let red = CGFloat(arc4random()%256)/255.0
    let green = CGFloat(arc4random()%256)/255.0
    let blue = CGFloat(arc4random()%256)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

/// 删除所有偏好设置
public func cz_removeAllUserDefaults() -> Void {
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
}

/// 跳转到AppStore进行评分
/// - Parameter appId: appId
public func cz_jumpAppStoreScore(_ appId: String) {
    UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?action=write-review&mt=8")!, options: [:], completionHandler: nil)
}

/// 跳转到AppStore首页
/// - Parameter appId: appId
public func cz_jumpAppStotrScore(_ appId: String) {
    UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?mt=8")!, options: [:], completionHandler: nil)
}

/// 应用是否是第一次启动
public func cz_isFirstLaunch() -> Bool {
    let hasBeenLaunched = "hasBeenLaunched"
    let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
    if isFirstLaunch {
        UserDefaults.standard.set(true, forKey: hasBeenLaunched)
        UserDefaults.standard.synchronize()
    }
    return isFirstLaunch
}

/// 当前版本是否是第一次启动
public func cz_isFirstLaunchOfNewVersion() -> Bool {
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
public func cz_callSystemDial(phoneNumber: String) {
    UIApplication.shared.open(URL(string: "tel://\(phoneNumber)")!, options: [:], completionHandler: nil)
}

/// 获取最上层window
public func cz_lastWindow() -> UIWindow? {
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
public func cz_topController(_ viewController: UIViewController = (UIApplication.shared.delegate?.window?!.rootViewController)!) -> UIViewController {
    if viewController.isKind(of: UINavigationController.self) {
        return cz_topController((viewController as! UINavigationController).visibleViewController!)
    } else if viewController.isKind(of: UITabBarController.self) {
        return cz_topController((viewController as! UITabBarController).selectedViewController!)
    } else {
        if (viewController.presentedViewController != nil) {
            return cz_topController(viewController.presentedViewController!)
        } else {
            return viewController
        }
    }
}
