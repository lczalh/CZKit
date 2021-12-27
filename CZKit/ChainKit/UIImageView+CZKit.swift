//
//  UIImageView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIImageView {
    
    @discardableResult
    func image(_ image: UIImage?) -> CZKit {
        base.image = image
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> CZKit {
        base.isHighlighted = isHighlighted
        return self
    }
}
