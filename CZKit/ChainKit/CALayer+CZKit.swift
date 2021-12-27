//
//  CALayer+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/4/7.
//

import Foundation

public extension CZKit where Base: CALayer {
    
    @discardableResult
    func addSuperLayer(_ layer: CALayer) -> CZKit {
        layer.addSublayer(base)
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> CZKit {
        base.frame = frame
        return self
    }
    
    @discardableResult
    func frame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CZKit {
        base.frame = CGRect(x: x, y: y, width: width, height: height)
        return self
    }
    
    @discardableResult
    func bounds(_ bounds: CGRect) -> CZKit {
        base.bounds = bounds
        return self
    }
    
    @discardableResult
    func shadowPath(_ shadowPath: CGPath?) -> CZKit {
        base.shadowPath = shadowPath
        return self
    }
    
    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> CZKit {
        base.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> CZKit {
        base.masksToBounds = masksToBounds
        return self
    }
    
    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> CZKit {
        base.borderWidth = borderWidth
        return self
    }
    
    @discardableResult
    func borderColor(_ borderColor: UIColor) -> CZKit {
        base.borderColor = borderColor.cgColor
        return self
    }
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> CZKit {
        base.shadowColor = shadowColor?.cgColor
        return self
    }
    
    @discardableResult
    func shadowOpacity(_ shadowOpacity: Float) -> CZKit {
        base.shadowOpacity = shadowOpacity
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> CZKit {
        base.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func shadowRadius(_ shadowRadius: CGFloat) -> CZKit {
        base.shadowRadius = shadowRadius
        return self
    }
    
    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor) -> CZKit {
        base.backgroundColor = backgroundColor.cgColor
        return self
    }
    
    @discardableResult
    func name(_ name: String?) -> CZKit {
        base.name = name
        return self
    }
    
}
