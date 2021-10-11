//
//  CZArrayExtension.swift
//  csomanage
//
//  Created by yu mingming on 2020/10/23.
//  Copyright © 2020 glgs. All rights reserved.
//
import Foundation
import UIKit

public extension Array {
    
}

public extension Array where Element: NSCopying{
    var copy: [Element]{
        return self.map {$0.copy(with: nil) as! Element}
    }
}

public extension Array where Element: NSMutableCopying {

    var mutableCopy: [Element]{
        return self.map {$0.mutableCopy(with: nil) as! Element}
    }
}
