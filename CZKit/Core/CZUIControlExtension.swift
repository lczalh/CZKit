//
//  CZUIControlExtension.swift
//  UdreamPlus
//
//  Created by udream3 on 2021/3/30.
//  Copyright © 2021 chaozheng. All rights reserved.
//

import Foundation

public extension UIControl {
    struct CZUIControl {
        static let cz_actionKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "cz_actionKey".hashValue)
    }
    
    /// 存储事件回调
    private var cz_actionBlock: ((UIButton) -> Void)? {
        get {
            return objc_getAssociatedObject(self, CZUIControl.cz_actionKey) as? ((UIButton) -> Void)
        }
        set {
            objc_setAssociatedObject(self, CZUIControl.cz_actionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    /// 添加按钮事件
    func cz_addTarget(actionBlock: ((UIButton) -> Void)?, for controlEvents: UIControl.Event) {
        cz_actionBlock = actionBlock
        addTarget(self, action: #selector(cz_action(sender:)), for: controlEvents)
    }
    
    @objc private func cz_action(sender: UIButton) {
        if cz_actionBlock != nil {
            cz_actionBlock!(sender)
        }
    }
}

public extension CZKit where Base: UIControl {
    
    /// 添加按钮事件
    @discardableResult
    func addTarget(_ actionBlock: ((UIButton) -> Void)?, for controlEvents: UIControl.Event) -> CZKit {
        base.cz_addTarget(actionBlock: actionBlock, for: controlEvents)
        return self
    }
    
}
