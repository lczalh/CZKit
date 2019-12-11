//
//  CZAlertController.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//

import Foundation

public extension UIAlertController {
    
    /// 快速创建只带取消和确定的提示框
    class func cz_ShowAlertController(_ title: String?,
                                             _ message: String?,
                                             _ preferredStyle: UIAlertController.Style,
                                             _ viewController: UIViewController!,
                                             _ confirmTitle: String?,
                                             _ confirmHandler: ((UIAlertAction) -> Void)?,
                                             _ cancelTitle: String?,
                                             _ cancelHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /// 快速创建只带确定的提示框
    class func cz_ShowAlertController(_ title: String?,
                                      _ message: String?,
                                      _ preferredStyle: UIAlertController.Style,
                                      _ viewController: UIViewController!,
                                      _ confirmTitle: String?,
                                      _ confirmHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler)
        alertController.addAction(confirmAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
