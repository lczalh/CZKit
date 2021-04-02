//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: UIProgressView {
    
    @discardableResult
    func progress(_ progress: Float) -> CZKit {
        base.progress = progress
        return self
    }
    
    @discardableResult
    func progressViewStyle(_ progressViewStyle: UIProgressView.Style) -> CZKit {
        base.progressViewStyle = progressViewStyle
        return self
    }
    
    @discardableResult
    func progressTintColor(_ progressTintColor: UIColor?) -> CZKit {
        base.progressTintColor = progressTintColor
        return self
    }
    
    @discardableResult
    func trackTintColor(_ trackTintColor: UIColor?) -> CZKit {
        base.trackTintColor = trackTintColor
        return self
    }
    
    @discardableResult
    func progressImage(_ progressImage: UIImage?) -> CZKit {
        base.progressImage = progressImage
        return self
    }
    
    @discardableResult
    func trackImage(_ trackImage: UIImage?) -> CZKit {
        base.trackImage = trackImage
        return self
    }
}
