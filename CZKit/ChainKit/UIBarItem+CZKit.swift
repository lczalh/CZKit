//
//  UIBarItem+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIBarItem {
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> CZKit {
        base.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ titleTextAttributes: [NSAttributedString.Key: Any]?,
                             for state: UIControl.State...) -> CZKit {
        state.forEach { base.setTitleTextAttributes(titleTextAttributes, for: $0) }
        return self
    }
}
