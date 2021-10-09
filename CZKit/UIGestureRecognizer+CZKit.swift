//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension CZKit where Base: UIGestureRecognizer {
    
    @discardableResult
    func addTarget(_ target: Any, action: Selector) -> CZKit {
        base.addTarget(target, action: action)
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIGestureRecognizerDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> CZKit {
        base.isEnabled = isEnabled
        return self
    }
}

public extension CZKit where Base: UITapGestureRecognizer {
    
    @discardableResult
    func numberOfTapsRequired(_ numberOfTapsRequired: Int) -> CZKit {
        base.numberOfTapsRequired = numberOfTapsRequired
        return self
    }
    
    @discardableResult
    func numberOfTouchesRequired(_ numberOfTouchesRequired: Int) -> CZKit {
        base.numberOfTouchesRequired = numberOfTouchesRequired
        return self
    }
}

public extension CZKit where Base: UIPanGestureRecognizer {
    
    @discardableResult
    func minimumNumberOfTouches(_ minimumNumberOfTouches: Int) -> CZKit {
        base.minimumNumberOfTouches = minimumNumberOfTouches
        return self
    }
    
    @discardableResult
    func maximumNumberOfTouches(_ maximumNumberOfTouches: Int) -> CZKit {
        base.maximumNumberOfTouches = maximumNumberOfTouches
        return self
    }
}

public extension CZKit where Base: UISwipeGestureRecognizer {
    
    @discardableResult
    func numberOfTouchesRequired(_ numberOfTouchesRequired: Int) -> CZKit {
        base.numberOfTouchesRequired = numberOfTouchesRequired
        return self
    }
    
    @discardableResult
    func direction(_ direction: UISwipeGestureRecognizer.Direction) -> CZKit {
        base.direction = direction
        return self
    }
}

public extension CZKit where Base: UIPinchGestureRecognizer {
    
    @discardableResult
    func scale(_ scale: CGFloat) -> CZKit {
        base.scale = scale
        return self
    }
}

public extension CZKit where Base: UILongPressGestureRecognizer {
    
    @discardableResult
    func numberOfTapsRequired(_ numberOfTapsRequired: Int) -> CZKit {
        base.numberOfTapsRequired = numberOfTapsRequired
        return self
    }
    
    @discardableResult
    func numberOfTouchesRequired(_ numberOfTouchesRequired: Int) -> CZKit {
        base.numberOfTouchesRequired = numberOfTouchesRequired
        return self
    }
    
    @discardableResult
    func minimumPressDuration(_ minimumPressDuration: CFTimeInterval) -> CZKit {
        base.minimumPressDuration = minimumPressDuration
        return self
    }
    
    @discardableResult
    func allowableMovement(_ allowableMovement: CGFloat) -> CZKit {
        base.allowableMovement = allowableMovement
        return self
    }
}

public extension CZKit where Base: UIRotationGestureRecognizer {
    
    @discardableResult
    func rotation(_ rotation: CGFloat) -> CZKit {
        base.rotation = rotation
        return self
    }
}
