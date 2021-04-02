//
//  LCZProgressHUD.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation
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
    private static func setupHUD(_ isVisible: Bool = true) {
        if isVisible {
            SVProgressHUD.setBackgroundColor(backgroundColor)
            SVProgressHUD.setForegroundColor(foregroundColor)
        } else {
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.setForegroundColor(.clear)
        }
    }
    
    /// 循环小圈圈
    static func show(_ isVisible: Bool = true) {
        if Thread.current.isMainThread {
            setupHUD(isVisible)
            SVProgressHUD.show()
        } else {
            DispatchQueue.main.async {
                setupHUD(isVisible)
                SVProgressHUD.show()
            }
        }
    }
    
    /// 循环小圈圈 + 文字
    /// - Parameter title: 显示文字
    static func show(_ title: String? = "加载中...", _ isVisible: Bool = true) {
        if Thread.current.isMainThread {
            setupHUD(isVisible)
            SVProgressHUD.show(withStatus: title)
        } else {
            DispatchQueue.main.async {
                setupHUD(isVisible)
                SVProgressHUD.show(withStatus: title)
            }
        }
    }
    
    /// 成功的提示框 默认两秒消失
    static func showSuccess(_ title: String?, _ delay: TimeInterval = delay, _ isVisible: Bool = true) {
        if Thread.current.isMainThread {
            setupHUD(isVisible)
            SVProgressHUD.showSuccess(withStatus: title)
            SVProgressHUD.dismiss(withDelay: delay)
        } else {
            DispatchQueue.main.async {
                setupHUD(isVisible)
                SVProgressHUD.showSuccess(withStatus: title)
                SVProgressHUD.dismiss(withDelay: delay)
            }
        }
    }
    
    /// 失败的提示框 默认两秒消失
    static func showError(_ title: String?, delay: TimeInterval = delay, _ isVisible: Bool = true) {
        if Thread.current.isMainThread {
            setupHUD(isVisible)
            SVProgressHUD.showError(withStatus: title)
            SVProgressHUD.dismiss(withDelay: delay)
        } else {
            DispatchQueue.main.async {
                setupHUD(isVisible)
                SVProgressHUD.showError(withStatus: title)
                SVProgressHUD.dismiss(withDelay: delay)
            }
        }
    }
    
    /// 显示加载进度
    static func showProgress(_ progress: Float, _ status: String?, _ isVisible: Bool = true) {
        if Thread.current.isMainThread {
            setupHUD(isVisible)
            SVProgressHUD.showProgress(progress, status: status)
        } else {
            DispatchQueue.main.async {
                setupHUD(isVisible)
                SVProgressHUD.showProgress(progress, status: status)
            }
        }
    }
    
    /// 显示信息的提示框 默认两秒消失
    static func showInfo(_ title: String?, delay: TimeInterval = delay, _ isVisible: Bool = true) {
        if Thread.current.isMainThread {
            setupHUD(isVisible)
            SVProgressHUD.showInfo(withStatus: title)
            SVProgressHUD.dismiss(withDelay: delay)
        } else {
            DispatchQueue.main.async {
                setupHUD(isVisible)
                SVProgressHUD.showInfo(withStatus: title)
                SVProgressHUD.dismiss(withDelay: delay)
            }
        }
    }
    
    
    /// 立即隐藏
    static func dismiss() {
        guard currentNetworkRequestCount == 0 else { return }
        if Thread.current.isMainThread {
            SVProgressHUD.dismiss()
        } else {
            DispatchQueue.main.async { SVProgressHUD.dismiss() }
        }
    }

}

