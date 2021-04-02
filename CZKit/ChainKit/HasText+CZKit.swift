//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: CZKitHasText {
    
    @discardableResult
    func text(_ text: String?) -> CZKit {
        base.set(text: text)
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> CZKit {
        base.set(attributedText: attributedText)
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> CZKit {
        base.set(color: textColor)
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> CZKit {
        base.set(alignment: textAlignment)
        return self
    }
}
