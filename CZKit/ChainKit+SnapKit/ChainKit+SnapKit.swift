//
//  ChainKit+SnapKit.swift
//  Example
//
//  Created by chaozheng on 2019/11/20.
//

import Foundation
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
}
