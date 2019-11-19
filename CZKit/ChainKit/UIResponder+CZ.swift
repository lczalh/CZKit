//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZ where Base: UIResponder {
    
    @discardableResult
    func becomeFirstResponder() -> CZ {
        base.becomeFirstResponder()
        return self
    }
    
    @discardableResult
    func resignFirstResponder() -> CZ {
        base.resignFirstResponder()
        return self
    }
}
