//
//  CZDeviceManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/3/31.
//

import Foundation
import UIKit
import AudioToolbox
import AdSupport
import AppTrackingTransparency

public struct CZDeviceManage {
    
    /// 获取屏幕大小
    public static var screenSize: CGSize { return UIScreen.main.bounds.size }

    /// 获取屏幕高度
    public static var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    
    /// 获取屏幕宽度
    public static var screenWidth: CGFloat { return UIScreen.main.bounds.width }

    /// 获取TabBar高度
    public static var tabbarHeight: CGFloat { return UITabBarController().tabBar.frame.height }

    /// 获取导航条高度
    public static var navigationHeight: CGFloat { return UINavigationController().navigationBar.frame.height }
    
    /// 屏幕中心点
    public static var screenCenter: CGPoint { CGPoint(x: screenWidth / 2, y: screenHeight / 2)}
    
    /// 获取状态栏高度
    public static var statusBarHeight: CGFloat {
        guard #available(iOS 13.0, *) else { return UIApplication.shared.statusBarFrame.height }
        return CZApplicationManage.lastWindow()?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }

    /// 获取屏幕宽度比例
    public static var screenWidthScale: CGFloat {
        if UIDevice.current.model == "iPad" {
            return screenWidth / 768.0
        } else {
            return screenWidth / 375.0
        }
    }
    
    /// 获取屏幕高度比例
    public static var screenHeightScale: CGFloat {
        if UIDevice.current.model == "iPad" {
            return screenHeight / 1024.0
        } else {
            return screenHeight / 667.0
        }
    }
    
    /// 判断是否是Ipad
    public static var isIpad: Bool { return UIDevice.current.model == "iPad" }
    
    /// 判断是否是iPhone
    public static var isIphone: Bool { return UIDevice.current.model == "iPhone" }
    
    
    /// 安全区域底部高度
    public static var safeAreaBottomHeight: CGFloat {
        guard #available(iOS 11.0, *) else { return 0.0 }
        return CZApplicationManage.lastWindow()?.safeAreaInsets.bottom ?? 0.0
    }
    
    /// 记录是否在播放系统音效
    private static var isPlaySystemSound = false
    
    /// 存储播放系统音效完成回调
    private static var playSystemSoundCompletionBlock: (() -> Void)?
    
    /// 播放系统音效
    /// - Parameters:
    ///   - soundId: soundId 查询地址：http://iphonedevwiki.net/index.php/AudioServices
    ///   - completion: 完成回调
    public static func playSystemSound(soundId: Int, completion: (() -> Void)?) {
        playSystemSoundCompletionBlock = completion
        guard isPlaySystemSound == false else { return }
        let soundID = SystemSoundID(soundId)
        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, {
            (soundID, inClientData) -> Void in
            CZDeviceManage.isPlaySystemSound = false
             AudioServicesRemoveSystemSoundCompletion(soundID)
             AudioServicesDisposeSystemSoundID(soundID)
            CZDeviceManage.playSystemSoundCompletionBlock?()
        }, nil)
        AudioServicesPlaySystemSound(soundID)
        isPlaySystemSound = true
    }
    
    /// 设备标识
    public static var idfvUuidString: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

    /// 广告标示符 Info中添加  Privacy - Tracking Usage Description：获取设备信息用以精准推送您喜欢的内容
    public static func getIdfaUuid(value: @escaping ((String) -> Void)) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { (state) in
                value(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
            }
        } else {
            value(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
        }
    }
}
