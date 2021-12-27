//
//  UISlider+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UISlider {
    
    @discardableResult
    func value(_ value: Float) -> CZKit {
        base.value = value
        return self
    }
    
    @discardableResult
    func minimumValue(_ minimumValue: Float) -> CZKit {
        base.minimumValue = minimumValue
        return self
    }
    
    @discardableResult
    func maximumValue(_ maximumValue: Float) -> CZKit {
        base.maximumValue = maximumValue
        return self
    }
    
    @discardableResult
    func minimumValueImage(_ minimumValueImage: UIImage?) -> CZKit {
        base.minimumValueImage = minimumValueImage
        return self
    }
    
    @discardableResult
    func maximumValueImage(_ maximumValueImage: UIImage?) -> CZKit {
        base.maximumValueImage = maximumValueImage
        return self
    }
    
    @discardableResult
    func isContinuous(_ isContinuous: Bool) -> CZKit {
        base.isContinuous = isContinuous
        return self
    }
    
    @discardableResult
    func minimumTrackTintColor(_ minimumTrackTintColor: UIColor?) -> CZKit {
        base.minimumTrackTintColor = minimumTrackTintColor
        return self
    }
    
    @discardableResult
    func maximumTrackTintColor(_ maximumTrackTintColor: UIColor?) -> CZKit {
        base.maximumTrackTintColor = maximumTrackTintColor
        return self
    }
    
    @discardableResult
    func thumbTintColor(_ thumbTintColor: UIColor?) -> CZKit {
        base.thumbTintColor = thumbTintColor
        return self
    }
}
