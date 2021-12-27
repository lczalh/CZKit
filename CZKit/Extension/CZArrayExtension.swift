//
//  CZArrayExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2020/10/23.
//

import Foundation
import UIKit

public extension Array {
    
}

public extension Array where Element: NSCopying{
    var cz_copy: [Element]{
        return self.map {$0.copy(with: nil) as! Element}
    }
}

public extension Array where Element: NSMutableCopying {

    var cz_mutableCopy: [Element]{
        return self.map {$0.mutableCopy(with: nil) as! Element}
    }
}
