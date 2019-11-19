//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public protocol CZCompatible {
    // 占位符  空间命名
    associatedtype CZCompatibleType
    
    var cz: CZCompatibleType { get }
}

public extension CZCompatible {
    
    var cz: CZ<Self> {
        return CZ(self)
    }
}

extension NSObject: CZCompatible {}
