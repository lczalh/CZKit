//
//  CZHud.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/3/20.
//

import Foundation
import UIKit
import SVProgressHUD

public struct CZHud {
    
    /// 记录当前网络请求数
    static var currentNetworkRequestCount: Int = 0
    
    /// 默认隐藏时长
    private static let delay: TimeInterval = 2
    
    /// 背景颜色
    private static var backgroundColor: UIColor = .black
    
    /// 前景颜色
    private static var foregroundColor: UIColor = .white
    
    static func configStyle(backgroundColor: UIColor = UIColor.black,
                            foregroundColor: UIColor = UIColor.white,
                            defaultMaskType: SVProgressHUDMaskType = .clear,
                            defaultAnimationType: SVProgressHUDAnimationType = .flat,
                            font: UIFont = .systemFont(ofSize: 14, weight: .regular),
                            cornerRadius: CGFloat = 14,
                            imageViewSize: CGSize = CGSize(width: 28, height: 28),
                            errorImage: UIImage? = nil,
                            successImage: UIImage? = nil,
                            infoImage: UIImage? = nil
    ) {
        CZHud.backgroundColor = backgroundColor
        CZHud.foregroundColor = foregroundColor
        setupHUD()
        SVProgressHUD.setDefaultMaskType(defaultMaskType)
        SVProgressHUD.setDefaultAnimationType(defaultAnimationType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setCornerRadius(cornerRadius)
        SVProgressHUD.setImageViewSize(imageViewSize)
        if let errorImage = errorImage { SVProgressHUD.setErrorImage(errorImage) }
        if let successImage = successImage { SVProgressHUD.setSuccessImage(successImage) }
        if let infoImage = infoImage { SVProgressHUD.setInfoImage(infoImage) }
    }
    
    /// 设置hud是否可见
    private static func setupHUD(isVisible: Bool = true) {
        if isVisible {
            SVProgressHUD.setBackgroundColor(backgroundColor)
            SVProgressHUD.setForegroundColor(foregroundColor)
        } else {
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.setForegroundColor(.clear)
        }
    }
    
    /// 循环小圈圈 + 文字
    /// - Parameter title: 显示文字
    static func show(text: String? = "加载中...", isVisible: Bool = true) {
        setupHUD(isVisible: isVisible)
        SVProgressHUD.show(withStatus: text)
    }
    
    /// 成功的提示框 默认两秒消失
    static func showSuccess(text: String?, delay: TimeInterval = delay, isVisible: Bool = true) {
        guard currentNetworkRequestCount == 0 else { return }
        setupHUD(isVisible: isVisible)
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 失败的提示框 默认两秒消失
    static func showError(text: String?, delay: TimeInterval = delay, isVisible: Bool = true) {
        guard currentNetworkRequestCount == 0 else { return }
        setupHUD(isVisible: isVisible)
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 显示加载进度
    static func showProgress(progress: Float, text: String?, isVisible: Bool = true) {
        guard currentNetworkRequestCount == 0 else { return }
        setupHUD(isVisible: isVisible)
        SVProgressHUD.showProgress(progress, status: text)
    }
    
    /// 显示消息的提示框 默认两秒消失
    static func showMessage(text: String?, delay: TimeInterval = delay, isVisible: Bool = true) {
        guard currentNetworkRequestCount == 0 else { return }
        setupHUD(isVisible: isVisible)
        (SVProgressHUD.value(forKey: "sharedView") as? UIView)?.setValue(nil, forKey: "infoImage")
        SVProgressHUD.showInfo(withStatus: text)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 显示信息的提示框 默认两秒消失
    static func showInfo(text: String?, delay: TimeInterval = delay, isVisible: Bool = true) {
        guard currentNetworkRequestCount == 0 else { return }
        setupHUD(isVisible: isVisible)
        SVProgressHUD.showInfo(withStatus: text)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    
    /// 立即隐藏
    static func dismiss() {
        guard currentNetworkRequestCount == 0 else { return }
        SVProgressHUD.dismiss()
    }

}

