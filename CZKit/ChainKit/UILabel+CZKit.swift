//
//  UILabel+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UILabel {
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> CZKit {
        base.layer.shadowColor = shadowColor?.cgColor
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> CZKit {
        base.layer.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func shadowOffset(width: CGFloat, height: CGFloat) -> CZKit {
        base.layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> CZKit {
        base.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> CZKit {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> CZKit {
        base.lineBreakMode = lineBreakMode
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
