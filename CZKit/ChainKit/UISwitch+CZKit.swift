//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: UISwitch {
    
    @discardableResult
    func onTintColor(_ onTintColor: UIColor?) -> CZKit {
        base.onTintColor = onTintColor
        return self
    }
    
    @discardableResult
    func thumbTintColor(_ thumbTintColor: UIColor?) -> CZKit {
        base.thumbTintColor = thumbTintColor
        return self
    }
    
    @discardableResult
    func onImage(_ onImage: UIImage?) -> CZKit {
        base.onImage = onImage
        return self
    }
    
    @discardableResult
    func offImage(_ offImage: UIImage?) -> CZKit {
        base.offImage = offImage
        return self
    }
    
    @discardableResult
    func isOn(_ isOn: Bool) -> CZKit {
        base.isOn = isOn
        return self
    }
}
