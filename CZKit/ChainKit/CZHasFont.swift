//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public protocol CZKitHasFont {
    
    func set(font: UIFont)
}

extension UILabel: CZKitHasFont {
    
    public func set(font: UIFont) {
        self.font = font
    }
}

extension UIButton: CZKitHasFont {
    
    public func set(font: UIFont) {
        self.titleLabel?.font = font
    }
}

extension UITextField: CZKitHasFont {
    
    public func set(font: UIFont) {
        self.font = font
    }
}

extension UITextView: CZKitHasFont {
    
    public func set(font: UIFont) {
        self.font = font
    }
}
