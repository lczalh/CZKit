//
//  UISegmentedControl+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UISegmentedControl {
    
    @discardableResult
    func title(_ title: String?, forSegmentAt: Int) -> CZKit {
        base.setTitle(title, forSegmentAt: forSegmentAt)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, forSegmentAt: Int) -> CZKit {
        base.setImage(image, forSegmentAt: forSegmentAt)
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat, forSegmentAt: Int) -> CZKit {
        base.setWidth(width, forSegmentAt: forSegmentAt)
        return self
    }
    
    @discardableResult
    func contentOffset(_ offset: CGSize, forSegmentAt: Int) -> CZKit {
        base.setContentOffset(offset, forSegmentAt: forSegmentAt)
        return self
    }
    
    @discardableResult
    func enabled(_ enabled: Bool, forSegmentAt: Int) -> CZKit {
        base.setEnabled(enabled, forSegmentAt: forSegmentAt)
        return self
    }
    
    @discardableResult
    func selectedSegmentIndex(_ selectedSegmentIndex: Int) -> CZKit {
        base.selectedSegmentIndex = selectedSegmentIndex
        return self
    }
    
    @discardableResult
    func backgroundImage(_ backgroundImage: UIImage?, for state: UIControl.State..., barMetrics: UIBarMetrics) -> CZKit {
        state.forEach { base.setBackgroundImage(backgroundImage, for: $0, barMetrics: barMetrics) }
        return self
    }
    
    @discardableResult
    func dividerImage(_ dividerImage: UIImage?,
                      forLeftSegmentState: UIControl.State,
                      rightSegmentState: UIControl.State,
                      barMetrics: UIBarMetrics) -> CZKit {
        base.setDividerImage(dividerImage, forLeftSegmentState: forLeftSegmentState, rightSegmentState: rightSegmentState, barMetrics: barMetrics)
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ attributes: [NSAttributedString.Key : Any]?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setTitleTextAttributes(attributes, for: $0) }
        return self
    }
    
    @discardableResult
    func contentPositionAdjustment(_ adjustment: UIOffset,
                                   forSegmentType: UISegmentedControl.Segment,
                                   barMetrics: UIBarMetrics) -> CZKit {
        base.setContentPositionAdjustment(adjustment, forSegmentType: forSegmentType, barMetrics: barMetrics)
        return self
    }
}
