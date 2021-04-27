//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension CZKit where Base: UILabel {
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> CZKit {
        base.layer.shadowColor = shadowColor?.cgColor
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> CZKit {
        base.layer.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func shadowOffset(width: CGFloat, height: CGFloat) -> CZKit {
        base.layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> CZKit {
        base.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> CZKit {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> CZKit {
        base.lineBreakMode = lineBreakMode
        return self
    }
}
