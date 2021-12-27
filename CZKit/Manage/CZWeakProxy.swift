//
//  CZWeakProxy.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/10/29.
//

import Foundation

public class CZWeakProxy: NSObject {

    private weak var target: NSObjectProtocol?
    
    init(target: NSObjectProtocol) {
        self.target = target
        super.init()
    }
    
    class func proxy(withTarget target: NSObjectProtocol) -> CZWeakProxy {
        return CZWeakProxy.init(target: target)
    }
    
    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
    
    public override func responds(to aSelector: Selector!) -> Bool {
        return target?.responds(to: aSelector) ?? false
    }
    
}
