//
//  CZUIControlExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/3/30.
//

import Foundation
import UIKit

public extension UIControl {
    struct CZUIControl {
        static let cz_actionKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "cz_actionKey".hashValue)
    }
    
    /// 添加按钮事件
    func cz_addTarget(actionBlock: (() -> Void)?, for controlEvents: UIControl.Event) {
        objc_setAssociatedObject(self, CZUIControl.cz_actionKey, actionBlock, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        addTarget(self, action: #selector(cz_action), for: controlEvents)
    }
    
    @objc private func cz_action() {
        let block = objc_getAssociatedObject(self, CZUIControl.cz_actionKey) as? (() -> Void)
        block?()
    }
}
