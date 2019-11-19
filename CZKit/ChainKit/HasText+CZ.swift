//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZ where Base: CZHasText {
    
    @discardableResult
    func text(_ text: String?) -> CZ {
        base.set(text: text)
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> CZ {
        base.set(attributedText: attributedText)
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> CZ {
        base.set(color: textColor)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> CZ {
        base.set(alignment: textAlignment)
        return self
    }
}
