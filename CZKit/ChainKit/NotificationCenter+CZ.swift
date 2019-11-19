//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZ where Base: NotificationCenter {
    
    @discardableResult
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any? = nil) -> CZ {
        base.addObserver(observer, selector: aSelector, name: aName, object: anObject)
        return self
    }
    
    @discardableResult
    func post(_ notification: Notification) -> CZ {
        base.post(notification)
        return self
    }
    
    @discardableResult
    func post(name aName: NSNotification.Name,
              object anObject: Any? = nil,
              userInfo aUserInfo: [AnyHashable : Any]? = nil) -> CZ {
        base.post(name: aName, object: anObject, userInfo: aUserInfo)
        return self
    }
    
    @discardableResult
    func removeObserver(_ observer: Any,
                        name aName: NSNotification.Name?,
                        object anObject: Any?) -> CZ {
        base.removeObserver(observer, name: aName, object: anObject)
        return self
    }
}
