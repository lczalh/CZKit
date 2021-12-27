//
//  CZUITabBarControllerExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/2/25.
//

import Foundation
import UIKit

public extension UITabBarController {
    
    /// 是否隐藏TabBar上的分割线
    /// - Parameter isHidden: true: 隐藏 false：显示
    func cz_isHiddenTabBarDivider(_ isHidden: Bool) {
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            guard isHidden else {
                tabBar.standardAppearance = tabBarAppearance
                tabBarAppearance.shadowImage = nil
                return
            }
            tabBarAppearance.shadowImage = CZCommonManage.createImage(color: .clear, size: CGSize(width: CZDeviceManage.screenWidth, height: 1))
            tabBar.standardAppearance = tabBarAppearance
        } else {
            guard isHidden else {
                tabBar.shadowImage = nil
                return
            }
            tabBar.shadowImage = UIImage()
        }
    }
}
