//
//  CZViewControllerExtension.swift
//  letaoshijie
//
//  Created by yu mingming on 2020/10/15.
//
import Foundation
import UIKit

public extension UIViewController {
    
    /// 是否隐藏导航条
    /// - Parameters:
    ///   - isHidden: true 隐藏 false 显示
    ///   - animated: true 动画 false 无动画
    @objc func cz_isHiddenNavigationBar(isHidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }
}
