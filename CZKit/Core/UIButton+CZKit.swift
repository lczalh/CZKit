//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension CZKit where Base: UIButton {
    
    @discardableResult
    func title(_ title: String?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setTitle(title, for: $0) }
        return self
    }
    
    @discardableResult
    func titleColor(_ color: UIColor?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setTitleColor(color, for: $0) }
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setImage(image, for: $0) }
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setBackgroundImage(image, for: $0) }
        return self
    }
    
    @discardableResult
    func attributedTitle(_ attributedTitle: NSAttributedString?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setAttributedTitle(attributedTitle, for: $0) }
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ edgeInsets: UIEdgeInsets) -> CZKit {
        base.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ edgeInsets: UIEdgeInsets) -> CZKit {
        base.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func adjustsImageWhenHighlighted(_ isAdjustsImageWhenHighlighted: Bool) -> CZKit {
        base.adjustsImageWhenHighlighted = isAdjustsImageWhenHighlighted
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> CZKit {
        base.titleLabel?.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> CZKit {
        base.titleLabel?.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> CZKit {
        base.titleLabel?.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func contentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> CZKit {
        base.contentEdgeInsets = contentEdgeInsets
        return self
    }
}
