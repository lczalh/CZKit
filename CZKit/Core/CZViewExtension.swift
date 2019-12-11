//
//  CZViewExtension.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//

import Foundation

//抖动方向枚举
public enum CZShakeDirection: Int {
    case horizontal  //水平抖动
    case vertical  //垂直抖动
}

public extension UIView {
    
    /// 通过视图获取指定父控制器
    ///
    /// - Parameter seekViewController: 查找的父控制器类型
    /// - Returns: 父控制器
    @discardableResult
    func cz_superController<T: UIViewController>(seekViewController: T.Type) -> T? {
        var view: UIView = self.superview!
        while view.next!.isKind(of: T.self) != true {
            guard view.superview != nil else {
                return nil
            }
            view = view.superview!
        }
        return view.next as? T
    }
    
    /// 通过视图获取指定父视图
    ///
    /// - Parameter seekSuperView: 查找的父视图类型
    /// - Returns: 父视图
    @discardableResult
    func cz_superView<T: UIView>(seekSuperView: T.Type) -> T? {
        var view: UIView = self.superview!
        while view.isKind(of: T.self) != true {
            guard view.superview != nil else {
                return nil
            }
            view = view.superview!
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
}
