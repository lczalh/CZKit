//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: UINavigationBar {
    
    @discardableResult
    func barStyle(_ barStyle: UIBarStyle) -> CZKit {
        base.barStyle = barStyle
        return self
    }
    
    @discardableResult
    func isTranslucent(_ isTranslucent: Bool) -> CZKit {
        base.isTranslucent = isTranslucent
        return self
    }
    
    @discardableResult
    func barTintColor(_ barTintColor: UIColor?) -> CZKit {
        base.barTintColor = barTintColor
        return self
    }
    
    @discardableResult
    func backgroundImage(_ backgroundImage: UIImage?, for barPosition: UIBarPosition = .any, barMetrics: UIBarMetrics = .default) -> CZKit {
        base.setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        return self
    }
    
    @discardableResult
    func shadowImage(_ shadowImage: UIImage?) -> CZKit {
        base.shadowImage = shadowImage
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ titleTextAttributes: [NSAttributedString.Key : Any]?) -> CZKit {
        base.titleTextAttributes = titleTextAttributes
        return self
    }
    
    @discardableResult
    func prefersLargeTitles(_ prefersLargeTitles: Bool) -> CZKit {
        if #available(iOS 11.0, *) {
            base.prefersLargeTitles = prefersLargeTitles
        }
        return self
    }
    
    @discardableResult
    func largeTitleTextAttributes(_ largeTitleTextAttributes: [NSAttributedString.Key : Any]?) -> CZKit {
        if #available(iOS 11.0, *) {
            base.largeTitleTextAttributes = largeTitleTextAttributes
        }
        return self
    }
}
