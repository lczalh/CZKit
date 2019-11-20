//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import UIKit
import Foundation

public struct CZKit<Base> {
    
    public let base: Base
    
    public var build: Base {
        return base
    }
    
    public init(_ base: Base) {
        self.base = base
    }
}

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
