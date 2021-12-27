//
//  CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

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
extension String: CZKitCompatible {}
