//
//  UITextField+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UITextField {
    
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?) -> CZKit {
        base.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> CZKit {
        base.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(string: String, foregroundColor: UIColor, font: UIFont) -> CZKit {
        base.attributedPlaceholder = NSMutableAttributedString.init(string: string, attributes: [NSAttributedString.Key.foregroundColor : foregroundColor, NSAttributedString.Key.font: font])
        return self
    }
    
    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> CZKit {
        base.borderStyle = borderStyle
        return self
    }
    
    @discardableResult
    func defaultTextAttributes(_ defaultTextAttributes: [String: Any]) -> CZKit {
        #if swift(>=4.2)
        base.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(defaultTextAttributes)
        #else
        base.defaultTextAttributes = defaultTextAttributes
        #endif
        return self
    }
    
    @discardableResult
    func clearsOnBeginEditing(_ clearsOnBeginEditing: Bool) -> CZKit {
        base.clearsOnBeginEditing = clearsOnBeginEditing
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> CZKit {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    func minimumFontSize(_ minimumFontSize: CGFloat) -> CZKit {
        base.minimumFontSize = minimumFontSize
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> CZKit {
        base.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }
    
    @discardableResult
    func typingAttributes(_ typingAttributes: [String: Any]?) -> CZKit {
        #if swift(>=4.2)
        base.typingAttributes = convertToOptionalNSAttributedStringKeyDictionary(typingAttributes)
        #else
        base.typingAttributes = typingAttributes
        #endif
        return self
    }
    
    @discardableResult
    func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> CZKit {
        base.clearButtonMode = clearButtonMode
        return self
    }
    
    @discardableResult
    func leftView(_ leftView: UIView?) -> CZKit {
        base.leftView = leftView
        return self
    }
    
    @discardableResult
    func leftViewMode(_ leftViewMode: UITextField.ViewMode) -> CZKit {
        base.leftViewMode = leftViewMode
        return self
    }
    
    @discardableResult
    func rightView(_ rightView: UIView?) -> CZKit {
        base.rightView = rightView
        return self
    }
    
    @discardableResult
    func rightViewMode(_ rightViewMode: UITextField.ViewMode) -> CZKit {
        base.rightViewMode = rightViewMode
        return self
    }
    
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> CZKit {
        base.keyboardType = keyboardType
        return self
    }
    
    @discardableResult
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> CZKit {
        base.returnKeyType = returnKeyType
        return self
    }
    
    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> CZKit {
        base.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    @discardableResult
    func textContentType(_ textContentType: UITextContentType) -> CZKit {
        if #available(iOS 10.0, *) {
            base.textContentType = textContentType
        }
        return self
    }
    
    /// 首字母是否大写
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> CZKit {
        base.autocapitalizationType = autocapitalizationType
        return self
    }
    
    /// 是否自动纠错
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> CZKit {
        base.autocorrectionType = autocorrectionType
        return self
    }
    
    @discardableResult
    func text(_ text: String?) -> CZKit {
        base.text = text
        return self
    }
    
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString?) -> CZKit {
        base.attributedText = attributedText
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> CZKit {
        base.textColor = color
        return self
    }
    
    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> CZKit {
        base.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> CZKit {
        base.font = font
        return self
    }
    
    @discardableResult
    func systemFont(ofSize: CGFloat) -> CZKit {
        base.font = .systemFont(ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func boldSystemFont(ofSize: CGFloat) -> CZKit {
        base.font = .boldSystemFont(ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func systemFont(ofSize: CGFloat, weight: UIFont.Weight) -> CZKit {
        base.font = .systemFont(ofSize: ofSize, weight: weight)
        return self
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any])
    -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in
        (NSAttributedString.Key(rawValue: key), value)
    })
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in
        (NSAttributedString.Key(rawValue: key), value)
    })
}
