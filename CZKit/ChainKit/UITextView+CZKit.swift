//
//  UITextView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UITextView {
    
    @discardableResult
    func delegate(_ delegate: UITextViewDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func isEditable(_ isEditable: Bool) -> CZKit {
        base.isEditable = isEditable
        return self
    }
    
    @discardableResult
    func isSelectable(_ isSelectable: Bool) -> CZKit {
        base.isSelectable = isSelectable
        return self
    }
    
    @discardableResult
    func textContainerInset(_ textContainerInset: UIEdgeInsets) -> CZKit {
        base.textContainerInset = textContainerInset
        return self
    }
    
    @discardableResult
    func dataDetectorTypes(_ dataDetectorTypes: UIDataDetectorTypes) -> CZKit {
        base.dataDetectorTypes = dataDetectorTypes
        return self
    }
    
    @discardableResult
    func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> CZKit {
        base.allowsEditingTextAttributes = allowsEditingTextAttributes
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
