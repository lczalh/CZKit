//
//  CZStickerView.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/12/3.
//  贴纸视图

import UIKit

@objc protocol CZStickerViewDelegate {
    
    // 缩放、旋转或移动时调用
    func stickerBeginOperation(_ stickerView: CZStickerView)
    
    // 在缩放、旋转或移动期间调用
    func stickerChangeOperation(_ stickerView: CZStickerView)
    
    // 在缩放、旋转或移动后调用
    func stickerEndOperation(_ stickerView: CZStickerView)
    
    // 点击标签时调用
    func stickerDidTap(_ stickerView: CZStickerView)
}

open class CZStickerView: UIView {
    
    /// 代理
    weak var delegate: CZStickerViewDelegate?
    
    /// 手势是否启用
    var gestureIsEnabled: Bool = true
    
    /// 轮廓边框颜色
    var outlineBorderColor: UIColor = .white
    
    /// 单击唤醒手势
    var tapRouseGesture: UITapGestureRecognizer!
    
    /// 移动手势
    var moveGesture: UIPanGestureRecognizer!
    
    /// 双指捏合手势
    var doubleFingerPinchGesture: UIPinchGestureRecognizer!
    
    /// 双指旋转手势
    var doubleFingerRotationGesture: UIRotationGestureRecognizer!
    
    /// 内容视图
    private var contentView: UIView!
    
    /// 旋转和缩放图标视图
    private var singleFingerRotateAndZoomImageView: UIImageView?
    
    /// 删除图标视图
    private var deleteImageView: UIImageView?
    
    /// 内边距
    private var padding: CGFloat = 10
    
    /// 开始移动起始坐标点
    private var beginMovePoint = CGPoint.zero
    
    /// 开始移动起始中心点
    private var beginMoveCenter = CGPoint.zero
    
    /// 开始缩放 / 旋转起始 bounds
    private var beganRotateOrZoomBounds = CGRect.zero
    
    /// 开始缩放 / 旋转起始距离
    private var beganRotateOrZoomDistance:CGFloat = 0
    
    /// 开始缩放 / 旋转起始角度
    private var beganRotateOrZoomAngle:CGFloat = 0
    
    /// 可缩放的最小大小
    private var minSize: CGSize = CGSize(width: 40, height: 40)
    
    /// 定时器
    private var timer: Timer?
    
    /// 是否在操作中
    private var isOperation = false
    
    /// 当前旋转弧度
    private var currentRotationRadian: CGFloat = 0
    
    /// 初始化
    /// - Parameters:
    ///   - contentView: 贴纸视图
    ///   - padding: 内边距
    ///   - outlineBorderColor: 轮廓边框颜色
    ///   - rotateOrZoomImage: 单手旋转 / 缩放图标，为nil则不创建
    ///   - deleteImage: 删除图标，为nil则不创建
    init(contentView: UIView,
         padding: CGFloat = 10,
         outlineBorderColor: UIColor = .white,
         rotateOrZoomImage: UIImage? = nil,
         deleteImage: UIImage? = nil) {
        self.padding = padding
        self.outlineBorderColor = outlineBorderColor
        super.init(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width + padding * 2, height: contentView.frame.size.height + padding * 2))
        backgroundColor = .clear
        
        // 单击唤醒手势
        tapRouseGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(tapRouseGesture)
        
        // 移动手势
        moveGesture = UIPanGestureRecognizer(target: self, action: #selector(moveAction(_:)))
        moveGesture.delegate = self
        addGestureRecognizer(moveGesture)
        
        // 捏合缩放手势
        doubleFingerPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        doubleFingerPinchGesture.delegate = self
        addGestureRecognizer(doubleFingerPinchGesture)
        
        // 旋转手势
        doubleFingerRotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationAction(_:)))
        doubleFingerRotationGesture.delegate = self
        addGestureRecognizer(doubleFingerRotationGesture)
        
        // 手势冲突处理
        tapRouseGesture.require(toFail: moveGesture)
        
        // 贴纸
        self.contentView = contentView
            .cz
            .addSuperView(self)
            .center(center)
            .autoresizingMask([.flexibleWidth, .flexibleHeight])
            .isUserInteractionEnabled(true)
            .backgroundColor(.clear)
            .borderWidth(1)
            .build
        
        // 旋转 / 缩放
        if let rotateOrZoomImage = rotateOrZoomImage {
            singleFingerRotateAndZoomImageView = UIImageView()
                .cz
                .frame(x: 0, y: 0, width: padding * 2, height: padding * 2)
                .addSuperView(self)
                .center(x: contentView.frame.origin.x + contentView.frame.size.width, y: contentView.frame.origin.y + contentView.frame.size.height)
                .image(rotateOrZoomImage)
                .backgroundColor(.clear)
                .isUserInteractionEnabled(true)
                .contentMode(.scaleAspectFit)
                .autoresizingMask([.flexibleLeftMargin, .flexibleTopMargin])
                .build
            let singleFingerRotateAndZoomGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateOrZoomAction(_:)))
            singleFingerRotateAndZoomImageView?.addGestureRecognizer(singleFingerRotateAndZoomGesture)
            moveGesture.require(toFail: singleFingerRotateAndZoomGesture)
        }
        
        // 删除
        if let deleteImage = deleteImage {
            deleteImageView = UIImageView()
                .cz
                .frame(x: 0, y: 0, width: padding * 2, height: padding * 2)
                .addSuperView(self)
                .center(contentView.frame.origin)
                .image(deleteImage)
                .backgroundColor(.clear)
                .isUserInteractionEnabled(true)
                .contentMode(.scaleAspectFit)
                .autoresizingMask([.flexibleRightMargin, .flexibleBottomMargin])
                .build
            let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAction(_:)))
            deleteImageView?.addGestureRecognizer(deleteGesture)
            moveGesture.require(toFail: deleteGesture)
        }
        
        addTimer()
    }
    
    /// 单击唤醒事件
    @objc private func tapAction(_ recognizer: UITapGestureRecognizer) {
        guard gestureIsEnabled else { return }
        addTimer()
        delegate?.stickerDidTap(self)
    }
    
    /// 移动事件
    @objc private func moveAction(_ recognizer: UIPanGestureRecognizer) {
        guard gestureIsEnabled else { return }
        let translationLocation = recognizer.translation(in: superview)
        switch recognizer.state {
        case .began:
            setOperation(true)
            beginMovePoint = translationLocation
            beginMoveCenter = center
        case .changed:
            center = CGPoint(x: beginMoveCenter.x + (translationLocation.x - beginMovePoint.x), y: beginMoveCenter.y + (translationLocation.y - beginMovePoint.y))
            delegate?.stickerChangeOperation(self)
        case .ended:
            center = CGPoint(x: beginMoveCenter.x + (translationLocation.x - beginMovePoint.x), y: beginMoveCenter.y + (translationLocation.y - beginMovePoint.y))
            setOperation(false)
        default:
            break
        }
    }
    
    /// 两指捏合缩放事件
    @objc private func pinchAction(_ recognizer: UIPinchGestureRecognizer) {
        guard gestureIsEnabled else { return }
        switch recognizer.state {
        case .began:
            setOperation(true)
            beganRotateOrZoomBounds = bounds
        case .changed:
            bounds = calculateBounds(beganBounds: beganRotateOrZoomBounds, zoomScale: recognizer.scale)
            delegate?.stickerChangeOperation(self)
        case .ended:
            setOperation(false)
        default:
            break
        }
    }
    
    /// 两指旋转事件
    @objc private func rotationAction(_ recognizer: UIRotationGestureRecognizer) {
        guard gestureIsEnabled else { return }
        currentRotationRadian += recognizer.rotation
        recognizer.rotation = 0
        switch recognizer.state {
        case .began:
            setOperation(true)
        case .changed:
            transform = CGAffineTransform(rotationAngle: currentRotationRadian)
            delegate?.stickerChangeOperation(self)
        case .ended:
            setOperation(false)
        default:
            break
        }
    }
    
    /// 单指旋转 / 缩放事件
    @objc private func rotateOrZoomAction(_ recognizer: UIPanGestureRecognizer) {
        guard gestureIsEnabled else { return }
        let touchLocation = recognizer.location(in: superview)
        switch recognizer.state {
        case .began:
            setOperation(true)
            beganRotateOrZoomAngle = CGFloat(atan2f(Float(touchLocation.y - center.y), Float(touchLocation.x - center.x))) - atan2(transform.b, transform.a)
            beganRotateOrZoomBounds = bounds
            beganRotateOrZoomDistance = calculateDistance(point1: center, point2: touchLocation)
        case .changed:
            // 旋转
            let angle = atan2f(Float(touchLocation.y - center.y), Float(touchLocation.x - center.x))
            let angleDiff = Float(beganRotateOrZoomAngle) - angle
            currentRotationRadian = CGFloat(-angleDiff)
            transform = CGAffineTransform(rotationAngle: currentRotationRadian)
            // 缩放
            let scale = calculateDistance(point1: center, point2: touchLocation) / beganRotateOrZoomDistance
            let scaledBounds = calculateBounds(beganBounds: beganRotateOrZoomBounds, zoomScale: scale)
            bounds = scaledBounds
            delegate?.stickerChangeOperation(self)
        case .ended:
            setOperation(false)
        default:
            break
        }
    }
    
    /// 删除事件
    @objc private func deleteAction(_ recognizer: UITapGestureRecognizer) {
        removeTimer()
        removeFromSuperview()
    }
    
    /// 添加定时器
    private func addTimer() {
        removeTimer()
        contentView.layer.borderColor = outlineBorderColor.cgColor
        deleteImageView?.isHidden = false
        singleFingerRotateAndZoomImageView?.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 2, target: CZWeakProxy(target: self), selector: #selector(timerAction), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: .default)
    }
    
    /// 定时器事件
    @objc func timerAction() {
        contentView.layer.borderColor = UIColor.clear.cgColor
        deleteImageView?.isHidden = true
        singleFingerRotateAndZoomImageView?.isHidden = true
    }
    
    /// 移除定时器
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 设置操作状态
    private func setOperation(_ isOn: Bool) {
        if isOn, !isOperation {
            isOperation = true
            removeTimer()
            contentView.layer.borderColor = outlineBorderColor.cgColor
            deleteImageView?.isHidden = false
            singleFingerRotateAndZoomImageView?.isHidden = false
            superview?.bringSubviewToFront(self)
            delegate?.stickerBeginOperation(self)
        } else if !isOn, isOperation {
            isOperation = false
            addTimer()
            delegate?.stickerEndOperation(self)
        }
    }
    
    /// 重置状态
    func resetState() {
        isOperation = false
        removeTimer()
        timerAction()
    }
    
    /// 计算两点之间的距离
    private func calculateDistance(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let fx = point2.x - point1.x
        let fy = point2.y - point1.y
        return sqrt(fx * fx + fy * fy)
    }
    
    /// 通过起始大小和缩放比例，计算新的大小
    private func calculateBounds(beganBounds: CGRect, zoomScale: CGFloat) -> CGRect {
        // 计算最小缩放比例
        let minimumScale = min(minSize.width, minSize.height) / min(beganBounds.size.width, beganBounds.size.height)
        let scale = max(zoomScale, minimumScale)
        return CGRect(x: beganBounds.origin.x, y: beganBounds.origin.y, width: beganBounds.size.width * scale, height: beganBounds.size.height * scale)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeTimer()
    }
    
}

extension CZStickerView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


extension CZKit where Base: CZStickerView {
    
    @discardableResult
    func delegate(_ delegate: CZStickerViewDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func gestureIsEnabled(_ isEnabled: Bool) -> CZKit {
        base.gestureIsEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func outlineBorderColor(_ outlineBorderColor: UIColor) -> CZKit {
        base.outlineBorderColor = outlineBorderColor
        return self
    }
    
}
