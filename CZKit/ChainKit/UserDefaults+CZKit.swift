//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: UserDefaults {
    
    @discardableResult
    func removeObject(forKey defaultName: String) -> CZKit {
        base.removeObject(forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Any?, forKey defaultName: String) -> CZKit {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Bool, forKey defaultName: String) -> CZKit {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Int, forKey defaultName: String) -> CZKit {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Double, forKey defaultName: String) -> CZKit {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ value: Float, forKey defaultName: String) -> CZKit {
        base.set(value, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func set(_ url: URL?, forKey defaultName: String) -> CZKit {
        base.set(url, forKey: defaultName)
        return self
    }
    
    @discardableResult
    func synchronize() -> Bool {
        return base.synchronize()
    }
}
