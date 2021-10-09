//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension CZKit where Base: UIActivityIndicatorView {
    
    @discardableResult
    func activityIndicatorViewStyle(_ activityIndicatorViewStyle: UIActivityIndicatorView.Style) -> CZKit {
        #if swift(>=4.2)
        base.style = activityIndicatorViewStyle
        #else
        base.activityIndicatorViewStyle = activityIndicatorViewStyle
        #endif
        return self
    }
    
    @discardableResult
    func hidesWhenStopped(_ hidesWhenStopped: Bool) -> CZKit {
        base.hidesWhenStopped = hidesWhenStopped
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor?) -> CZKit {
        base.color = color
        return self
    }
}
