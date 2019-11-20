//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import UIKit

public protocol CZKitCompatible {
    // 占位符  空间命名
    associatedtype CZKitCompatibleType
    
    var cz: CZKitCompatibleType { get }
}

public extension CZKitCompatible {
    
    var cz: CZKit<Self> {
        return CZKit(self)
    }
}

extension NSObject: CZKitCompatible {}
