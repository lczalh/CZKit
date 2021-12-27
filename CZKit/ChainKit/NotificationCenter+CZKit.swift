//
//  NotificationCenter+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: NotificationCenter {
    
    @discardableResult
    func addObserver(_ observer: Any,
                     selector: Selector,
                     name: NSNotification.Name?,
                     object: Any? = nil) -> CZKit {
        base.addObserver(observer, selector: selector, name: name, object: object)
        return self
    }
    
    @discardableResult
    func post(_ notification: Notification) -> CZKit {
        base.post(notification)
        return self
    }
    
    @discardableResult
    func post(_ name: NSNotification.Name,
              object: Any? = nil,
              userInfo: [AnyHashable : Any]? = nil) -> CZKit {
        base.post(name: name, object: object, userInfo: userInfo)
        return self
    }
    
    @discardableResult
    func removeObserver(_ observer: Any,
                        name: NSNotification.Name?,
                        object: Any?) -> CZKit {
        base.removeObserver(observer, name: name, object: object)
        return self
    }
}
