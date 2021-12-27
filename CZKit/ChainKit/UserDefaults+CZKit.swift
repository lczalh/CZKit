//
//  UserDefaults+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UserDefaults {
    
    @discardableResult
    func removeObject(forKey: String) -> CZKit {
        base.removeObject(forKey: forKey)
        return self
    }
    
    @discardableResult
    func set(_ value: Any?, forKey: String) -> CZKit {
        base.set(value, forKey: forKey)
        return self
    }
    
    @discardableResult
    func set(_ value: Bool, forKey: String) -> CZKit {
        base.set(value, forKey: forKey)
        return self
    }
    
    @discardableResult
    func set(_ value: Int, forKey: String) -> CZKit {
        base.set(value, forKey: forKey)
        return self
    }
    
    @discardableResult
    func set(_ value: Double, forKey: String) -> CZKit {
        base.set(value, forKey: forKey)
        return self
    }
    
    @discardableResult
    func set(_ value: Float, forKey: String) -> CZKit {
        base.set(value, forKey: forKey)
        return self
    }
    
    @discardableResult
    func set(_ url: URL?, forKey: String) -> CZKit {
        base.set(url, forKey: forKey)
        return self
    }
}
