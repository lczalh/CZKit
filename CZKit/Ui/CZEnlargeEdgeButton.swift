//
//  CZEnlargeEdgeButton.swift
//  UdreamPlus
//
//  Created by udream3 on 2021/9/2.
//  Copyright © 2021 Zaki. All rights reserved.
//  扩大点击范围按钮

import UIKit

public class CZEnlargeEdgeButton: UIButton {
    
    /// 设置扩大区域
    var enlargeEdgeInsets: UIEdgeInsets = .zero
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if alpha == 0 || isHidden == true || enlargeEdgeInsets == .zero {
            return super.point(inside: point, with: event)
        }
        let rect = CGRect(x: bounds.origin.x - enlargeEdgeInsets.left, y: bounds.origin.y - enlargeEdgeInsets.top, width: bounds.width + (enlargeEdgeInsets.left + enlargeEdgeInsets.right), height: bounds.height + (enlargeEdgeInsets.top + enlargeEdgeInsets.bottom))
        return rect.contains(point)
    }
    
}

public extension CZKit where Base: CZEnlargeEdgeButton {
    
    /// 设置扩大区域
    @discardableResult
    func enlargeEdgeInsets(_ edgeInsets: UIEdgeInsets) -> CZKit {
        base.enlargeEdgeInsets = edgeInsets
        return self
    }
    
    /// 设置扩大区域
    @discardableResult
    func enlargeEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.enlargeEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
