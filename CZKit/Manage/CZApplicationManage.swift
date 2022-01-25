//
//  CZApplicationJumpManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/4/1.
//

import Foundation
import UIKit

public struct CZApplicationManage {
    
    /// 获取当前APP版本号
    public static var version: String { return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
    
    /// 获取当前APP构建号
    public static var buildVersion: String { return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "" }

    /// 获取APP名称  Xcode 11需要在info.plist里面添加 Bundle display name
    public static var appName: String { return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "" }
    
    /// 获取构建时间
    public static var buildDate: Date {
        if let infoPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate = infoAttr[.modificationDate] as? Date {
            return infoDate
        }
        return Date()
    }
    
    /// 应用内跳转
    /// 例：CZApplicationJumpManage.push(type: .应用设置, completion: nil)
    /// - Parameters:
    ///   - type: 跳转类型
    ///   - completion: 完成回调
    public static func push(_ type: CZApplicationJumpEnum, _ completion: ((Bool) -> Void)?) {
        guard let url = URL(string: type.value) else {
            completion?(false)
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            completion?(false) 
            return
        }
        if Thread.current.isMainThread {
            UIApplication.shared.open(url, options: [:], completionHandler: completion)
        } else {
            DispatchQueue.main.async { UIApplication.shared.open(url, options: [:], completionHandler: completion) }
        }
    }
    
    /// 系统分享
    /// 例：CZApplicationJumpManage.systemShare(activityItems: ["我在用“\(CZDeviceManage.appName)”，快来看看吧！", R.image.icon_logo()!, URL(string: "https://xxx".cz_encoded())!])
    /// - Parameters:
    ///   - controller: 当前控制器
    ///   - activityItems: 文本、图片、链接
    ///   - applicationActivities: 自定义的分享对象数组
    ///   - excludedActivityTypes: 过滤调的类型
    ///   - animated: animated description
    ///   - completion: 完成回调
    public static func systemShare(controller: UIViewController? = lastController(),
                                   activityItems: [Any],
                                   applicationActivities: [UIActivity]? = nil,
                                   excludedActivityTypes: [UIActivity.ActivityType]? = nil,
                                   animated: Bool = true,
                                   completion: (() -> Void)? = nil) {
        if Thread.current.isMainThread {
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
            activityViewController.excludedActivityTypes = excludedActivityTypes
            controller?.present(activityViewController, animated: animated, completion: completion)
        } else {
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
                activityViewController.excludedActivityTypes = excludedActivityTypes
                controller?.present(activityViewController, animated: animated, completion: completion)
            }
        }
    }
    
    /// 应用是否是第一次启动
    public static func isFirstLaunch() -> Bool {
        let hasBeenLaunched = "hasBeenLaunched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }

    /// 当前版本是否是第一次启动
    public static func isFirstLaunchOfNewVersion() -> Bool {
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
            UserDefaults.standard.set(majorVersion, forKey: hasBeenLaunchedOfNewVersion)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunchOfNewVersion
    }

    /// 获取最上层window
    public static func lastWindow() -> UIWindow? {
        if #available(iOS 13.0, *), UIApplication.shared.supportsMultipleScenes {
            guard let window = UIApplication.shared.windows.first else { return nil }
            return window
        } else {
            guard let window = UIApplication.shared.delegate?.window else { return nil }
            return window
        }
    }

    /// 获取最上层的控制器
    public static func lastController(_ currentController: UIViewController? = firstController(rootControllerType: UIViewController.self)) -> UIViewController? {
        if let navigationController = currentController as? UINavigationController {
            guard let visibleViewController = navigationController.visibleViewController else { return navigationController }
            return lastController(visibleViewController)
        } else if let tabBarController = currentController as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else { return tabBarController }
            return lastController(selectedViewController)
        } else {
            guard let presentedViewController = currentController?.presentedViewController else { return currentController }
            return lastController(presentedViewController)
        }
    }
    
    /// 获取最底层控制器
    /// - Parameter rootControllerType: 底层控制器类型
    /// - Returns: 底层控制器对象
    public static func firstController<T: UIViewController>(rootControllerType: T.Type) -> T? {
        if #available(iOS 13.0, *), UIApplication.shared.supportsMultipleScenes {
            guard let controller = UIApplication.shared.windows.first?.rootViewController as? T else { return nil }
            return controller
        } else {
            guard let controller = UIApplication.shared.delegate?.window??.rootViewController as? T else { return nil }
            return controller
        }
    }
    
    /// 获取沙盒Document路径
    public static var documentPath: String { return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first ?? "" }

    /// 获取沙盒Library路径
    public static var libraryPath: String { return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true).first ?? "" }
    
    /// 获取沙盒caches路径
    public static var cachesPath: String { return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true).first ?? "" }

    /// 获取沙盒tmp路径
    public static var tmpPath: String { return NSTemporaryDirectory() }
    
    /// 检查版本更新
    /// - Parameters:
    ///   - newVersion: 新版本号
    ///   - newBuild: 新构建号
    /// - Returns: 是否更新类型
    public static func examineVersionUpdate(newVersion: String, newBuild: String) -> CZApplyUpdateTypeEnum {
        let versionType = compareVersion(newVersion: newVersion, oldVersion: version)
        let buildType = compareVersion(newVersion: newBuild, oldVersion: buildVersion)
        if versionType == .大于 && buildType == .大于 {
            return .强制更新
        } else if versionType == .大于 || buildType == .大于 {
            return .提示更新
        } else {
            return .无须更新
        }
    }
    
    /// 版本比较
    /// - Parameters:
    ///   - newVersion: 新版本
    ///   - oldVersion: 旧版本
    /// - Returns: 新版本 是否大于等于小于 旧版本
    public static func compareVersion(newVersion: String, oldVersion: String) -> CZCompareTypeEnum {
        let oldVersionArray = oldVersion.components(separatedBy: ".")
        let newVersionArray = newVersion.components(separatedBy: ".")
        for i in 0 ..< oldVersionArray.count where i < newVersionArray.count {
            let oldVersion = oldVersionArray[i].int ?? 0
            let newVersion = newVersionArray[i].int ?? 0
            if oldVersion > newVersion {
                return .小于
            } else if oldVersion < newVersion {
                return .大于
            }
        }
        if oldVersionArray.count > newVersionArray.count {
            return .小于
        } else if oldVersionArray.count < newVersionArray.count {
            return .大于
        } else {
            return .等于
        }
    }
     
}
