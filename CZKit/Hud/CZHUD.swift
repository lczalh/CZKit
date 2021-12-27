//
//  CZHUD.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/3/20.
//

import Foundation
import UIKit
import SVProgressHUD

struct CZHUD {
    
    /// 记录当前网络请求数
    static var currentNetworkRequestCount: Int = 0
    
    /// 默认隐藏时长
    private static let delay: TimeInterval = 2
    
    private static var backgroundColor: UIColor = .black
    
    private static var foregroundColor: UIColor = .white
    
    static func configStyle(backgroundColor: UIColor = UIColor.black,
                            foregroundColor: UIColor = UIColor.white,
                            defaultMaskType: SVProgressHUDMaskType = .clear,
                            defaultAnimationType: SVProgressHUDAnimationType = .flat,
                            font: UIFont = .cz_systemFont(14),
                            cornerRadius: CGFloat = CZCommonManage.dynamicFitWidth(14),
                            imageViewSize: CGSize = CGSize(width: CZCommonManage.dynamicFitWidth(28), height: CZCommonManage.dynamicFitWidth(28)),
                            errorImage: UIImage? = nil,
                            successImage: UIImage? = nil,
                            infoImage: UIImage? = nil
    ) {
        CZHUD.backgroundColor = backgroundColor
        CZHUD.foregroundColor = foregroundColor
        setupHUD()
        SVProgressHUD.setDefaultMaskType(defaultMaskType)
        SVProgressHUD.setDefaultAnimationType(defaultAnimationType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setCornerRadius(cornerRadius)
        SVProgressHUD.setImageViewSize(imageViewSize)
        if errorImage != nil { SVProgressHUD.setErrorImage(errorImage!) }
        if successImage != nil { SVProgressHUD.setSuccessImage(successImage!) }
        if infoImage != nil { SVProgressHUD.setInfoImage(infoImage!) }
    }
    
    /// 设置hud是否可见
    private static func setupHUD(isVisible: Bool = true) {
        SVProgressHUD.setImageViewSize(CGSize(width: 28, height: 28))
        if isVisible {
            SVProgressHUD.setBackgroundColor(backgroundColor)
            SVProgressHUD.setForegroundColor(foregroundColor)
        } else {
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.setForegroundColor(.clear)
        }
    }
    
    /// 循环小圈圈
    static func show(isVisible: Bool = true) {
        setupHUD(isVisible: isVisible)
        SVProgressHUD.show()
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
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -28))
        SVProgressHUD.showInfo(withStatus: text)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 显示信息的提示框 默认两秒消失
    static func showInfo(text: String?, delay: TimeInterval = delay, isVisible: Bool = true) {
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

