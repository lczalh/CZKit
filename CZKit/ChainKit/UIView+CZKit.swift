//
//  UIView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIView {
    
    @discardableResult
    func tag(_ tag: Int) -> CZKit {
        base.tag = tag
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> CZKit {
        base.frame = frame
        return self
    }
    
    @discardableResult
    func frame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CZKit {
        base.frame = CGRect(x: x, y: y, width: width, height: height)
        return self
    }
    
    @discardableResult
    func bounds(_ bounds: CGRect) -> CZKit {
        base.bounds = bounds
        return self
    }
    
    @discardableResult
    func center(_ center: CGPoint) -> CZKit {
        base.center = center
        return self
    }
    
    @discardableResult
    func center(x: CGFloat, y: CGFloat) -> CZKit {
        base.center = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor) -> CZKit {
        base.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> CZKit {
        base.contentMode = contentMode
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> CZKit {
        base.clipsToBounds = clipsToBounds
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> CZKit {
        base.alpha = alpha
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool) -> CZKit {
        base.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func isOpaque(_ isOpaque: Bool) -> CZKit {
        base.isOpaque = isOpaque
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> CZKit {
        base.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor) -> CZKit {
        base.tintColor = tintColor
        return self
    }
    
    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> CZKit {
        base.layer.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> CZKit {
        base.layer.masksToBounds = masksToBounds
        return self
    }
    
    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> CZKit {
        base.layer.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func borderColor(_ borderColor: UIColor) -> CZKit {
        base.layer.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> CZKit {
        base.layer.shadowColor = shadowColor?.cgColor
        return self
    }
    
    @discardableResult
    func shadowOpacity(_ shadowOpacity: Float) -> CZKit {
        base.layer.shadowOpacity = shadowOpacity
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> CZKit {
        base.layer.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func shadowRadius(_ shadowRadius: CGFloat) -> CZKit {
        base.layer.shadowRadius = shadowRadius
        return self
    }
    
    @discardableResult
    func shadowPath(_ shadowPath: CGPath?) -> CZKit {
        base.layer.shadowPath = shadowPath
        return self
    }
    
    @discardableResult
    func addSubview(_ view: UIView) -> CZKit {
        base.addSubview(view)
        return self
    }
    
    @discardableResult
    func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) -> CZKit {
        base.addGestureRecognizer(gestureRecognizer)
        return self
    }
    
    @discardableResult
    func addConstraint(_ constraint: NSLayoutConstraint) -> CZKit {
        base.addConstraint(constraint)
        return self
    }
    
    @discardableResult
    func addConstraints(_ constraints: [NSLayoutConstraint]) -> CZKit {
        base.addConstraints(constraints)
        return self
    }
    
    @discardableResult
    func addSuperView(_ view: UIView) -> CZKit {
        view.addSubview(base)
        return self
    }
    
    @discardableResult
    func transform(_ transform: CGAffineTransform) -> CZKit {
        base.transform = transform
        return self
    }
    
    @discardableResult
    func addShadow(_ color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), _ radius: CGFloat = 3, _ offset: CGSize = .zero, _ opacity: Float = 0.5) -> CZKit {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowRadius = radius
        base.layer.shadowOpacity = opacity
        base.layer.masksToBounds = false
        return self
    }
    
    @discardableResult
    func addArrangedSuperView(_ stackView: UIStackView) -> CZKit {
        stackView.addArrangedSubview(base)
        return self
    }
    
    @discardableResult
    func autoresizingMask(_ autoresizingMask: UIView.AutoresizingMask) -> CZKit {
        base.autoresizingMask = autoresizingMask
        return self
    }
    
    
    /// 内容抗拉伸优先级 默认250
    @discardableResult
    func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> CZKit {
        base.setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    /// 内容抗压缩优先级 默认750
    @discardableResult
    func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> CZKit {
        base.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}


