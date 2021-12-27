//
//  UIStepper+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIStepper {
    
    @discardableResult
    func isContinuous(_ isContinuous: Bool) -> CZKit {
        base.isContinuous = isContinuous
        return self
    }
    
    @discardableResult
    func autorepeat(_ autorepeat: Bool) -> CZKit {
        base.autorepeat = autorepeat
        return self
    }
    
    @discardableResult
    func wraps(_ wraps: Bool) -> CZKit {
        base.wraps = wraps
        return self
    }
    
    @discardableResult
    func value(_ value: Double) -> CZKit {
        base.value = value
        return self
    }
    
    @discardableResult
    func minimumValue(_ minimumValue: Double) -> CZKit {
        base.minimumValue = minimumValue
        return self
    }
    
    @discardableResult
    func maximumValue(_ maximumValue: Double) -> CZKit {
        base.maximumValue = maximumValue
        return self
    }
    
    @discardableResult
    func stepValue(_ stepValue: Double) -> CZKit {
        base.stepValue = stepValue
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIControl.State...) -> CZKit {
        state.forEach { base.setBackgroundImage(image, for: $0) }
        return self
    }
    
    @discardableResult
    func dividerImage(_ image: UIImage?,
                      forLeftSegmentState: UIControl.State,
                      rightSegmentState: UIControl.State) -> CZKit {
        base.setDividerImage(image, forLeftSegmentState: forLeftSegmentState, rightSegmentState: rightSegmentState)
        return self
    }
    
    @discardableResult
    func incrementImage(_ image: UIImage?, for state: UIControl.State) -> CZKit {
        base.setIncrementImage(image, for: state)
        return self
    }
    
    @discardableResult
    func decrementImage(_ image: UIImage?, for state: UIControl.State) -> CZKit {
        base.setDecrementImage(image, for: state)
        return self
    }
}
