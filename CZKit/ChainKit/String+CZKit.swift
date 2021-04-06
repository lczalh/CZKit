//
//  String+CZKit.swift
//  letaoshijie
//
//  Created by udream3 on 2021/4/6.
//

import Foundation
import UIKit

public extension CZKit where Base == String {
    
    @discardableResult
    func asAttributedString() -> CZKit<NSMutableAttributedString> {
        return NSMutableAttributedString(string: base).cz
    }
}
