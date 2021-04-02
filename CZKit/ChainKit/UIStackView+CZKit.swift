//
//  UIStackView+CZKit.swift
//  XinmeiMerchant
//
//  Created by udream3 on 2020/11/25.
//  Copyright © 2020 Udream. All rights reserved.
//
import Foundation
import UIKit

public extension CZKit where Base: UIStackView {
    
    @discardableResult
    func spacing(_ spacing: CGFloat) -> CZKit {
        base.spacing = spacing
        return self
    }
    
    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> CZKit {
        base.distribution = distribution
        return self
    }
    
    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> CZKit {
        base.axis = axis
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> CZKit {
        base.alignment = alignment
        return self
    }
    
    @discardableResult
    func addArrangedSubview(_ addArrangedSubview: UIView) -> CZKit {
        base.addArrangedSubview(addArrangedSubview)
        return self
    }
    
    @discardableResult
    func addArrangedSubviews(_ addArrangedSubviews: [UIView]) -> CZKit {
        for view in addArrangedSubviews { base.addArrangedSubview(view) }
        return self
    }
    
    @discardableResult
    func removeArrangedSubview(_ removeArrangedSubview: UIView) -> CZKit {
        base.removeArrangedSubview(removeArrangedSubview)
        return self
    }
    
    @discardableResult
    func insertArrangedSubview(_ view: UIView, _ stackIndex: Int) -> CZKit {
        base.insertArrangedSubview(view, at: stackIndex)
        return self
    }
    
    @discardableResult
    func isBaselineRelativeArrangement(_ isBaselineRelativeArrangement: Bool) -> CZKit {
        base.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        return self
    }
    
    @discardableResult
    func isLayoutMarginsRelativeArrangement(_ isLayoutMarginsRelativeArrangement: Bool) -> CZKit {
        base.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }
    
    @discardableResult
    @available(iOS 11.0, *)
    func setCustomSpacing(_ spacing: CGFloat, _ arrangedSubview: UIView) -> CZKit {
        base.setCustomSpacing(spacing, after: arrangedSubview)
        return self
    }
    
    @discardableResult
    @available(iOS 11.0, *)
    func customSpacing(_ arrangedSubview: UIView) -> CZKit {
        base.customSpacing(after: arrangedSubview)
        return self
    }
    
    
    
}
