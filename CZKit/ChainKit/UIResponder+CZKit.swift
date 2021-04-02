//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

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
