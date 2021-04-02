//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public protocol CZKitHasText {
    
    func set(text: String?)
    
    func set(attributedText: NSAttributedString?)
    
    func set(color: UIColor)
    
    func set(alignment: NSTextAlignment)
}

extension UILabel: CZKitHasText {
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    public func set(color: UIColor) {
        self.textColor = color
    }
    
    public func set(alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}

extension UITextField: CZKitHasText {
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    public func set(color: UIColor) {
        self.textColor = color
    }
    
    public func set(alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}

extension UITextView: CZKitHasText {
    
    public func set(text: String?) {
        self.text = text
    }
    
    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }
    
    public func set(color: UIColor) {
        self.textColor = color
    }
    
    public func set(alignment: NSTextAlignment) {
        self.textAlignment = alignment
    }
}
