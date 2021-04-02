//
//  CZNotificationManage.swift
//  UdreamPlus
//
//  Created by udream3 on 2021/3/30.
//  Copyright © 2021 chaozheng. All rights reserved.
//

import UIKit

public struct CZNotificationManage {
    
    /// 添加通知
    public static func addNotification(name: NSNotification.Name?, object: Any? = nil, queue: OperationQueue = OperationQueue.main, using: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: using)
    }
    
    /// 添加通知
    public static func addNotification(observer: Any, selector: Selector, name: NSNotification.Name?, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    /// 发送通知
    public static func postNotification(name: NSNotification.Name, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    /// 删除指定通知
    public static func removeNotification(observer: Any, name: NSNotification.Name?, object: Any? = nil) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
    }
    
    /// 删除所有通知
    public static func removeAllNotification(observer: Any) {
        NotificationCenter.default.removeObserver(self)
    }
}
