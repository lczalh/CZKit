//
//  UIPickerView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIPickerView {
    
    @discardableResult
    func dataSource(_ dataSource: UIPickerViewDataSource?) -> CZKit {
        base.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIPickerViewDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func showsSelectionIndicator(_ showsSelectionIndicator: Bool) -> CZKit {
        base.showsSelectionIndicator = showsSelectionIndicator
        return self
    }
}
