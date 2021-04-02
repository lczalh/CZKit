//
//  CZApplicationJumpManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/4/1.
//

import UIKit

public struct CZApplicationManage {
    
    /// 应用内跳转
    /// 例：CZApplicationJumpManage.push(type: .应用设置, completion: nil)
    /// - Parameters:
    ///   - type: 跳转类型
    ///   - completion: 完成回调
    public static func push(type: CZApplicationJumpEnum, completion: ((Bool) -> Void)?) {
        guard let url = URL(string: type.value) else {
            completion != nil ? completion!(false) : nil
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            completion != nil ? completion!(false) : nil
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
    public static func systemShare(controller: UIViewController = lastController(), activityItems: [Any], applicationActivities: [UIActivity]? = nil, excludedActivityTypes: [UIActivity.ActivityType]? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        if Thread.current.isMainThread {
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
            activityViewController.excludedActivityTypes = excludedActivityTypes
            controller.present(activityViewController, animated: animated, completion: completion)
        } else {
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
                activityViewController.excludedActivityTypes = excludedActivityTypes
                controller.present(activityViewController, animated: animated, completion: completion)
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
        if let window = UIApplication.shared.windows.first { return window }
        if let window = UIApplication.shared.keyWindow { return window }
        return nil
    }

    /// 获取最上层的控制器
    public static func lastController(_ viewController: UIViewController = firstController(rootControllerType: UIViewController.self)!) -> UIViewController {
        if viewController.isKind(of: UINavigationController.self) {
            return lastController((viewController as! UINavigationController).visibleViewController!)
        } else if viewController.isKind(of: UITabBarController.self) {
            return lastController((viewController as! UITabBarController).selectedViewController!)
        } else {
            if (viewController.presentedViewController != nil) {
                return lastController(viewController.presentedViewController!)
            } else {
                return viewController
            }
        }
    }
    
    /// 获取最底层控制器
    /// - Parameter rootControllerType: 底层控制器类型
    /// - Returns: 底层控制器对象
    public static func firstController<T: UIViewController>(rootControllerType: T.Type) -> T? {
        if let controller = UIApplication.shared.windows.first?.rootViewController as? T { return controller }
        if let controller = UIApplication.shared.delegate?.window?!.rootViewController as? T { return controller }
        return nil
    }
    
}
