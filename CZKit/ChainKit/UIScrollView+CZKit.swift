//
//  UIScrollView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UIScrollView {
    
    @discardableResult
    func delegate(_ delegate: UIScrollViewDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func contentOffset(_ contentOffset: CGPoint) -> CZKit {
        base.contentOffset = contentOffset
        return self
    }
    
    @discardableResult
    func contentOffset(x: CGFloat, y: CGFloat) -> CZKit {
        base.contentOffset = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func contentSize(_ contentSize: CGSize) -> CZKit {
        base.contentSize = contentSize
        return self
    }
    
    @discardableResult
    func contentSize(width: CGFloat, height: CGFloat) -> CZKit {
        base.contentSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func contentInset(_ contentInset: UIEdgeInsets) -> CZKit {
        base.contentInset = contentInset
        return self
    }
    
    @discardableResult
    func contentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func contentInsetAdjustmentBehavior(_ contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior) -> CZKit {
        base.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
        return self
    }
    
    @discardableResult
    func isDirectionalLockEnabled(_ isDirectionalLockEnabled: Bool) -> CZKit {
        base.isDirectionalLockEnabled = isDirectionalLockEnabled
        return self
    }
    
    @discardableResult
    func bounces(_ bounces: Bool) -> CZKit {
        base.bounces = bounces
        return self
    }
    
    @discardableResult
    func alwaysBounceVertical(_ alwaysBounceVertical: Bool) -> CZKit {
        base.alwaysBounceVertical = alwaysBounceVertical
        return self
    }
    
    @discardableResult
    func alwaysBounceHorizontal(_ alwaysBounceHorizontal: Bool) -> CZKit {
        base.alwaysBounceHorizontal = alwaysBounceHorizontal
        return self
    }
    
    @discardableResult
    func isPagingEnabled(_ isPagingEnabled: Bool) -> CZKit {
        base.isPagingEnabled = isPagingEnabled
        return self
    }
    
    @discardableResult
    func isScrollEnabled(_ isScrollEnabled: Bool) -> CZKit {
        base.isScrollEnabled = isScrollEnabled
        return self
    }
    
    @discardableResult
    func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> CZKit {
        base.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return self
    }
    
    @discardableResult
    func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> CZKit {
        base.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return self
    }
    
    @discardableResult
    func scrollIndicatorInsets(_ scrollIndicatorInsets: UIEdgeInsets) -> CZKit {
        base.scrollIndicatorInsets = scrollIndicatorInsets
        return self
    }
    
    @discardableResult
    func scrollIndicatorInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.scrollIndicatorInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
