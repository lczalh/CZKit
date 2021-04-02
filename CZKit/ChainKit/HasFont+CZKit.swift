//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: CZKitHasFont {
    
    @discardableResult
    func font(_ font: UIFont) -> CZKit {
        base.set(font: font)
        return self
    }
    
    @discardableResult
    func systemFont(ofSize fontSize: CGFloat) -> CZKit {
        base.set(font: UIFont.systemFont(ofSize: fontSize))
        return self
    }
    
    @discardableResult
    func boldSystemFont(ofSize fontSize: CGFloat) -> CZKit {
        base.set(font: UIFont.boldSystemFont(ofSize: fontSize))
        return self
    }
    
    @discardableResult
    func systemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> CZKit {
        base.set(font: UIFont.systemFont(ofSize: fontSize, weight: weight))
        return self
    }
}
