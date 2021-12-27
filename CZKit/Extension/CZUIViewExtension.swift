//
//  CZViewExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/11/28.
//

import Foundation
import UIKit

public extension UIView {
    
    struct CZViewKey {
        static let tapViewKey: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "tapViewKey".hashValue)
    }
    
    /// 通过视图获取指定父控制器
    ///
    /// - Parameter seekViewController: 查找的父控制器类型
    /// - Returns: 父控制器
    func cz_superController<T: UIViewController>(seekViewController: T.Type) -> T? {
        var view: UIView? = self.superview
        while view?.next?.isKind(of: T.self) != true {
            guard view?.superview != nil else {
                return nil
            }
            view = view?.superview
        }
        return view?.next as? T
    }
    
    /// 通过视图获取指定父视图
    ///
    /// - Parameter seekSuperView: 查找的父视图类型
    /// - Returns: 父视图
    func cz_superView<T: UIView>(seekSuperView: T.Type) -> T? {
        var view: UIView? = self.superview
        while view?.isKind(of: T.self) != true {
            guard view?.superview != nil else {
                return nil
            }
            view = view?.superview
        }
        return view as? T
    }
    
    /// 通过当前视图获取指定子视图
    ///
    /// - Parameter subView: 查找的子视图类型
    /// - Returns: 子视图
    func cz_subView<T: UIView>(seekSubView: T.Type) -> T? {
        return cz_selectSubView(currenView: self, superView: T.self)
    }
    
    private func cz_selectSubView<T: UIView>(currenView: UIView, superView: T.Type) -> T? {
        // 遍历子视图
        for view in currenView.subviews {
            if view.isKind(of: T.self) == true {
                return view as? T
            } else {
                // 递归查询
                let v = cz_selectSubView(currenView: view, superView: T.self)
                if v != nil {
                    return v
                }
            }
        }
        return nil
    }
    
    /// 将当前视图转为UIImage
    func cz_asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// 设置一些或所有视图的角度半径。
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func cz_roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    /// 添加阴影到视图
    ///
    /// - Parameters:
    ///   - shadowColor: shadow color (default is #137992).
    ///   - shadowRadius: shadow radius (default is 3).
    ///   - shadowOffset: shadow offset (default is .zero).
    ///   - shadowOpacity: shadow opacity (default is 0.5).
    func cz_addShadow(shadowColor: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),
                      shadowRadius: CGFloat = 3,
                      shadowOffset: CGSize = .zero,
                      shadowOpacity: Float = 0.5) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
    }
    
    /// 向视图插入阴影和任意角落圆角 （自动布局时需要在主线程调用)
    /// - Parameters:
    ///   - shadowLayerName: 层名称 避免重复插入
    ///   - shadowColor: 阴影颜色
    ///   - shadowOffset: 阴影偏移
    ///   - shadowOpacity: 透明度
    ///   - vagueRadius: 模糊半径
    ///   - corners: 角落
    ///   - radius: 角度
    func cz_setShadowAndRoundCorner(shadowLayerName: String,
                                    shadowColor: UIColor,
                                    shadowOffset: CGSize,
                                    shadowOpacity: Float,
                                    vagueRadius: CGFloat,
                                    corners: UIRectCorner,
                                    radius: CGFloat) {
        guard let superview = superview else { return }
        superview.layoutIfNeeded()
        guard superview.layer.sublayers?.filter({ $0.name == shadowLayerName }).first == nil else { return }
        let layout = CALayer()
            .cz
            .frame(frame)
            .cornerRadius(radius)
            .masksToBounds(false)
            .shadowColor(shadowColor)
            .shadowOffset(shadowOffset)
            .shadowOpacity(1)
            .shadowRadius(vagueRadius)
            .backgroundColor(UIColor.white)
            .name(shadowLayerName)
            .build
        cz_roundCorners(corners, radius: radius)
        superview.layer.insertSublayer(layout, below: layer)
    }
    
    /// 实现以下弯曲的UIView
    /// - Parameter desiredCurve: desiredCurve description
    func cz_addBottomRoundedEdge(desiredCurve: CGFloat) {
        let offset: CGFloat = self.frame.width / desiredCurve
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
    
    /// 获取当前视图所在目标视图的位置
    /// - targetView: 目标视图对象 默认window
    /// - Returns: 位置大小
    func cz_placeRect(targetView: UIView? = CZApplicationManage.lastWindow()) -> CGRect? {
        return superview?.convert(frame, to: targetView)
    }
    
    /// 给视图添加点击手势并回调
    /// - Parameter handler: 点击后回调
    func cz_tapBlock(handler : @escaping () -> Void) {
        objc_setAssociatedObject(self, CZViewKey.tapViewKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        isUserInteractionEnabled = true
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(cz_tapAction))
        tapGest.numberOfTapsRequired = 1
        tapGest.numberOfTouchesRequired = 1
        addGestureRecognizer(tapGest)
    }
    @objc private func cz_tapAction() {
        let handler = objc_getAssociatedObject(self, CZViewKey.tapViewKey) as? () -> Void
        handler?()
    }
}
