//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
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
