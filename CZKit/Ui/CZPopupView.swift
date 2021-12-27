//
//  CZPopupView.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/7/29.
//

import UIKit

public class CZPopupView: UIView {
    
    /// 弹出方向
    enum PopUpDirectionEnum {
        case 上
        case 下
        case 左
        case 右
    }
    
    /// 弹出位置
    enum PopUpLocationEnum {
        case 居中
        case 边缘
        case 自定义
    }
    
    /// 背景视图
    private lazy var backgroundView: UIView = {
        let view = UIView()
            .cz
            .frame(UIScreen.main.bounds)
            .alpha(0)
            .build
        return view
    }()
    
    /// 内容视图
    private var contentView: UIView!
    
    /// 添加到的父视图
    private var superView: UIView?
    
    /// 弹出方向
    private var direction: PopUpDirectionEnum = .右
    
    /// 弹出位置
    private var popUpLocation: PopUpLocationEnum = .居中
    
    /// 是否允许点击背景销毁弹窗 默认true
    private var isTapBackground: Bool = true
    
    /// 显示的位置
    private var showLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    /// 隐藏的位置
    private var hiddenLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    /// 自定义显示的位置
    private var location: CGPoint = CGPoint(x: 0, y: 0)
    
    /// 角的位置
    private var corners: UIRectCorner = .allCorners
    
    /// 角的半径
    private var radius: CGFloat = 0
    
    /// 点击背景的回调
    var tapBackgroundBlock: (() -> Void)?
    
    override private init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - direction: 弹出方向
    ///   - backgroundColor: 蒙版颜色
    ///   - isTapBackground: 是否可点击背景隐藏
    ///   - isCenter: 是否居中
    ///   - contentView: 内容视图
    ///   - location: 自定义显示的位置
    init(direction: PopUpDirectionEnum = .下,
         backgroundColor: UIColor = .cz_rgbColor(0, 0, 0, alpha: 0.5),
         popUpLocation: PopUpLocationEnum = .居中,
         isTapBackground: Bool = true,
         location: CGPoint = CGPoint(x: 0, y: 0),
         contentView: UIView,
         superView: UIView? = CZApplicationManage.lastWindow(),
         corners: UIRectCorner = .allCorners,
         radius: CGFloat = 0
    ) {
        super.init(frame: UIScreen.main.bounds)
        self.direction = direction
        self.isTapBackground = isTapBackground
        self.popUpLocation = popUpLocation
        self.location = location
        self.corners = corners
        self.radius = radius
        self.superView = superView != nil ? superView : CZApplicationManage.lastWindow()
        backgroundView.backgroundColor = backgroundColor
        addSubview(backgroundView)
        let tapBackgroundRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBackgroundRecognizerAction))
        tapBackgroundRecognizer.delegate = self
        backgroundView.addGestureRecognizer(tapBackgroundRecognizer)
        self.contentView = contentView
        addSubview(self.contentView)
    }
    
    // MARK: 点击背景事件
    @objc private func tapBackgroundRecognizerAction(recognizer: UITapGestureRecognizer) {
        if isTapBackground == true {
            if tapBackgroundBlock != nil {
                tapBackgroundBlock!()
            }
            dismiss()
        }
    }
    
    /// 显示
    func show() {
        superView?.addSubview(self)
        superView?.layoutIfNeeded()
        if contentView.frame == .zero {
            let size = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            contentView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        contentView.cz_roundCorners(corners, radius: radius)
        // 计算中心点
        let centerPoint = CGPoint(x: CZDeviceManage.screenCenter.x - contentView.frame.size.width / 2, y: CZDeviceManage.screenCenter.y - contentView.frame.size.height / 2)
        // 计算边缘点
        let edgePoint = CGPoint(x: CZDeviceManage.screenWidth - contentView.frame.size.width, y: CZDeviceManage.screenHeight - contentView.frame.size.height)
        switch popUpLocation {
        case .居中:
            switch direction {
            case .上:
                hiddenLocation = CGPoint(x: centerPoint.x, y: -CZDeviceManage.screenHeight)
                showLocation = CGPoint(x: centerPoint.x, y: centerPoint.y)
            case .下:
                hiddenLocation = CGPoint(x: centerPoint.x, y: CZDeviceManage.screenHeight)
                showLocation = CGPoint(x: centerPoint.x, y: centerPoint.y)
            case .左:
                hiddenLocation = CGPoint(x: -CZDeviceManage.screenWidth, y: centerPoint.y)
                showLocation = CGPoint(x: centerPoint.x, y: centerPoint.y)
            case .右:
                hiddenLocation = CGPoint(x: CZDeviceManage.screenWidth, y: centerPoint.y)
                showLocation = CGPoint(x: centerPoint.x, y: centerPoint.y)
            }
        case .边缘:
            switch direction {
            case .上:
                hiddenLocation = CGPoint(x: 0, y: -CZDeviceManage.screenHeight)
                showLocation = CGPoint(x: 0, y: 0)
            case .下:
                hiddenLocation = CGPoint(x: 0, y: CZDeviceManage.screenHeight)
                showLocation = CGPoint(x: 0, y: edgePoint.y)
            case .左:
                hiddenLocation = CGPoint(x: -CZDeviceManage.screenWidth, y: 0)
                showLocation = CGPoint(x: 0, y: 0)
            case .右:
                hiddenLocation = CGPoint(x: CZDeviceManage.screenWidth, y: 0)
                showLocation = CGPoint(x: edgePoint.x, y: 0)
            }
        case .自定义:
            switch direction {
            case .上:
                hiddenLocation = CGPoint(x: location.x, y: -CZDeviceManage.screenHeight)
                showLocation = CGPoint(x: location.x, y: location.y)
            case .下:
                hiddenLocation = CGPoint(x: location.x, y: CZDeviceManage.screenHeight)
                showLocation = CGPoint(x: location.x, y: location.y)
            case .左:
                hiddenLocation = CGPoint(x: -CZDeviceManage.screenWidth, y: location.y)
                showLocation = CGPoint(x: location.x, y: location.y)
            case .右:
                hiddenLocation = CGPoint(x: CZDeviceManage.screenWidth, y: location.y)
                showLocation = CGPoint(x: location.x, y: location.y)
            }
        }
        contentView.frame.origin = hiddenLocation
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.backgroundView.alpha = 1
                self.contentView.frame.origin = self.showLocation
            })
        }
    }
    
    /// 隐藏
    func dismiss() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundView.alpha = 0
                self.contentView.frame.origin = self.hiddenLocation
            }, completion: { state in
                self.removeFromSuperview()
            })
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CZPopupView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == backgroundView {
            return true
        }
        return false
    }
}

