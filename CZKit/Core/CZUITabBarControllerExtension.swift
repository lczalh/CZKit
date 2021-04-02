//
//  CZUITabBarControllerExtension.swift
//  letaoshijie
//
//  Created by udream3 on 2021/2/25.
//

extension UITabBarController {
    
    /// 是否隐藏TabBar上的分割线
    /// - Parameter isHidden: true: 隐藏 false：显示
    func cz_isHiddenTabBarDivider(isHidden: Bool) {
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            guard isHidden else {
                tabBar.standardAppearance = tabBarAppearance
                tabBarAppearance.shadowImage = nil
                return
            }
            tabBarAppearance.shadowImage = UIImage(color: .clear, size: CGSize(width: CZDeviceManage.screenWidth, height: 1))
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
