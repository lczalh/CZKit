//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public protocol CZHasFont {
    
    func set(font: UIFont)
}

extension UILabel: CZHasFont {
    
    public func set(font: UIFont) {
        self.font = font
    }
}

extension UIButton: CZHasFont {
    
    public func set(font: UIFont) {
        self.titleLabel?.font = font
    }
}

extension UITextField: CZHasFont {
    
    public func set(font: UIFont) {
        self.font = font
    }
}

extension UITextView: CZHasFont {
    
    public func set(font: UIFont) {
        self.font = font
    }
}
