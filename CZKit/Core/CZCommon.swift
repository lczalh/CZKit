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
    print("\n********** CZKit debug **********\n类名名称     :     \((file as NSString).lastPathComponent)\n方法名称     :     \(method)\n打印位置     :     第\(line)行\n内存地址     :     \(Unmanaged.passUnretained(items as AnyObject).toOpaque())\n打印内容     :     \(items)\n")
    #endif
}



public class CZCommon: NSObject {
    
    /// 获取屏幕大小
    public static var cz_screenSize: CGSize {
        return UIScreen.main.bounds.size
    }

    /// 获取屏幕高度
    public static var cz_screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    /// 获取TabBar高度
    public static var cz_tabbarHeight: CGFloat {
        return UITabBarController().tabBar.frame.height
    }

    /// 获取导航条高度
    public static var cz_navigationHeight: CGFloat {
        return UINavigationController().navigationBar.frame.height
    }

    /// 获取状态栏高度
    public static var cz_statusBarHeight: CGFloat? {
        if #available(iOS 13.0, *) {
            return CZCommon.cz_lastWindow()?.windowScene?.statusBarManager?.statusBarFrame.height
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }

    /// 获取屏幕比例
    public static var cz_screenScale: CGFloat {
        return CZCommon.cz_screenWidth / 375.0
    }
    
    /// 获取屏幕宽度
    public static var cz_screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 获取当前APP版本号
    public static var cz_appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }

    /// 获取APP名称  Xcode 11需要在info.plist里面添加 Bundle display name
    public static var cz_appName: String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }

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
    public static var cz_tmpPath: String {
        return NSTemporaryDirectory()
    }

    /// 删除所有偏好设置
    public static func cz_removeAllUserDefaults() -> Void {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
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
    public static func cz_topController(_ viewController: UIViewController = (UIApplication.shared.delegate?.window?!.rootViewController)!) -> UIViewController {
        if viewController.isKind(of: UINavigationController.self) {
            return CZCommon.cz_topController((viewController as! UINavigationController).visibleViewController!)
        } else if viewController.isKind(of: UITabBarController.self) {
            return CZCommon.cz_topController((viewController as! UITabBarController).selectedViewController!)
        } else {
            if (viewController.presentedViewController != nil) {
                return CZCommon.cz_topController(viewController.presentedViewController!)
            } else {
                return viewController
            }
        }
    }
}
