//
//  CAShapeLayer+CZKit.swift
//  letaoshijie
//
//  Created by udream3 on 2021/4/7.
//

import Foundation

public extension CZKit where Base: CAShapeLayer {
    
    @discardableResult
    func fillColor(_ fillColor: CGColor?) -> CZKit {
        base.fillColor = fillColor
        return self
    }
    
    @discardableResult
    func path(_ path: CGPath?) -> CZKit {
        base.path = path
        return self
    }
    
    @discardableResult
    func strokeColor(_ strokeColor: CGColor?) -> CZKit {
        base.strokeColor = strokeColor
        return self
    }
    
    @discardableResult
    func lineWidth(_ lineWidth: CGFloat) -> CZKit {
        base.lineWidth = lineWidth
        return self
    }
    
    @discardableResult
    func strokeStart(_ strokeStart: CGFloat) -> CZKit {
        base.strokeStart = strokeStart
        return self
    }
    
    @discardableResult
    func strokeEnd(_ strokeEnd: CGFloat) -> CZKit {
        base.strokeEnd = strokeEnd
        return self
    }
    
}
