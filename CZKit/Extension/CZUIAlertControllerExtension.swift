//
//  CZAlertController.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/11/28.
//

import Foundation
import UIKit

public extension UIAlertController {
    
    /// 快速创建只带取消和确定的提示框
    class func cz_showAlertController(title: String?,
                                      message: String?,
                                      preferredStyle: UIAlertController.Style,
                                      viewController: UIViewController,
                                      confirmTitle: String?,
                                      confirmHandler: ((UIAlertAction) -> Void)?,
                                      cancelTitle: String?,
                                      cancelHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /// 快速创建只带确定的提示框
    class func cz_showAlertController(title: String?,
                                      message: String?,
                                      preferredStyle: UIAlertController.Style,
                                      viewController: UIViewController,
                                      confirmTitle: String?,
                                      confirmHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler)
        alertController.addAction(confirmAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
