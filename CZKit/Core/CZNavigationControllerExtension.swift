//
//  CZNavigationControllerExtension.swift
//  Random
//
//  Created by yu mingming on 2020/5/7.
//  Copyright © 2020 刘超正. All rights reserved.
//

import Foundation

extension UINavigationController {
    
    /// 是否禁用导航条侧滑返回
    /// - Parameter isEnabled: false: 禁用  true: 启用
    func cz_interactivePopDisabled(isEnabled: Bool) {
        if (self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer))) {
            for popGesture in self.interactivePopGestureRecognizer?.view?.gestureRecognizers ?? [] {
                popGesture.isEnabled = isEnabled
            }
        }
    }
    
}
