//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import UIKit

public extension CZKit where Base: UIControl {
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> CZKit {
        base.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func isSelected(_ isSelected: Bool) -> CZKit {
        base.isSelected = isSelected
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> CZKit {
        base.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> CZKit {
        base.addTarget(target, action: action, for: controlEvents)
        return self
    }
}
