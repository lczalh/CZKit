//
//  CZViewExtension.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension UIView {
    
    /// 通过视图获取指定父控制器
    ///
    /// - Parameter seekViewController: 查找的父控制器类型
    /// - Returns: 父控制器
    @discardableResult
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
    @discardableResult
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
    @discardableResult
    func cz_subView<T: UIView>(seekSubView: T.Type) -> T? {
        return cz_selectSubView(currenView: self, superView: T.self)
    }
    
    @discardableResult
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
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func cz_addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    /// 向视图插入阴影和任意角落圆角
    /// - Parameters:
    ///   - shadowLayerName: 层名称
    ///   - shadowColor: 阴影颜色
    ///   - offSet: 阴影偏移
    ///   - opacity: 透明度
    ///   - shadowRadius: 角度
    ///   - cornerRadius: 角度
    ///   - corners: 角落
    ///   - fillColor: 填充颜色
    func cz_insertShadowAndRoundedCorners(shadowLayerName: String? = nil, shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius:
        CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        if layer.sublayers?.filter({ $0.name == shadowLayerName }).first == nil {
            let shadowLayer = CAShapeLayer()
            let size = CGSize(width: cornerRadius, height: cornerRadius)
            let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
            shadowLayer.path = cgPath //2
            shadowLayer.fillColor = fillColor.cgColor //3
            shadowLayer.shadowColor = shadowColor.cgColor //4
            shadowLayer.shadowPath = cgPath
            shadowLayer.shadowOffset = offSet //5
            shadowLayer.shadowOpacity = opacity
            shadowLayer.shadowRadius = shadowRadius
            shadowLayer.name = shadowLayerName
            shadowLayer.masksToBounds = false
            layer.masksToBounds = false
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    
//    var cz_cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//        }
//    }
//
//    var cz_borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    var cz_borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
//    
//    var cz_shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//    
//    var cz_shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//    
//    var cz_shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//    
//    var cz_shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
    
    
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
}
