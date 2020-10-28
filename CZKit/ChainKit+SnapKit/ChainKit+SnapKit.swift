//
//  ChainKit+SnapKit.swift
//  Example
//
//  Created by yu mingming on 2019/11/20.
//  Copyright © 2019 chaozheng. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - snpkit
public extension CZKit where Base: UIView  {
    
    @discardableResult
    func makeConstraints(_ constraintMaker: (ConstraintMaker) -> Void) -> CZKit {
        base.snp.makeConstraints { (make) in
            constraintMaker(make)
        }
        return self
    }
    
    @discardableResult
    func remakeConstraints(_ constraintMaker: (ConstraintMaker) -> Void) -> CZKit {
        base.snp.remakeConstraints { (make) in
            constraintMaker(make)
        }
        return self
    }
    
    @discardableResult
    func updateConstraints(_ constraintMaker: (ConstraintMaker) -> Void) -> CZKit {
        base.snp.updateConstraints { (make) in
            constraintMaker(make)
        }
        return self
    }
    
    /// 内容拉伸优先级
    @discardableResult
    func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> CZKit {
        base.setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    /// /// 内容压缩优先级
    @discardableResult
    func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> CZKit {
        base.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}
