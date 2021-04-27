//
//  CZNavigationControllerExtension.swift
//  Random
//
//  Created by yu mingming on 2020/5/7.
//  Copyright © 2020 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension UINavigationController {
    
    /// 是否禁用导航条侧滑返回
    /// - Parameter isEnabled: false: 禁用  true: 启用
    func cz_interactivePopDisabled(isEnabled: Bool) {
        if (self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer))) {
            for popGesture in self.interactivePopGestureRecognizer?.view?.gestureRecognizers ?? [] {
                popGesture.isEnabled = isEnabled
            }
        }
    }
    
    /// 获取导航栏背景视图
    /// - Returns: 导航栏背景视图
    func cz_getNavigationBarBackgroundView() -> UIView? {
        return navigationBar.subviews.first
    }
    
    /// Push ViewController with completion handler.
    /// - Parameters:
    ///   - viewController: 目标控制器
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func cz_pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        viewControllers.count == 1 ? viewController.hidesBottomBarWhenPushed = true : nil
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    /// Pop ViewController with completion handler.
    /// - Parameters:
    ///   - animated: 是否动画
    ///   - completion: 完成回调
    func cz_popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
}
