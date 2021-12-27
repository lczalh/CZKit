//
//  UIBarButtonItem+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIBarButtonItem {
    
    @discardableResult
    func width(_ width: CGFloat) -> CZKit {
        base.width = width
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor?) -> CZKit {
        base.tintColor = tintColor
        return self
    }
}
