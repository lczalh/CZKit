//
//  UIResponder+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIResponder {
    
    @discardableResult
    func becomeFirstResponder() -> CZKit {
        base.becomeFirstResponder()
        return self
    }
    
    @discardableResult
    func resignFirstResponder() -> CZKit {
        base.resignFirstResponder()
        return self
    }
}
