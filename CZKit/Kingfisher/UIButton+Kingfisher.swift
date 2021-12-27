//
//  UIButton+Kingfisher.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/12/21.
//

import Foundation
import UIKit
import Kingfisher

public extension UIButton {
    
    /// 设置网络图片
    func cz_setImage(url: String?,
                     placeholder: UIImage?,
                     state: UIControl.State = .normal,
                     options: KingfisherOptionsInfo? = [.transition(.fade(0.8))]) {
        if let string = url, string.isEmpty == false, (string.hasPrefix("http://") == true || string.hasPrefix("https://") == true), let url = URL(string: string) {
            kf.setImage(with: ImageResource(downloadURL: url), for: state, placeholder: placeholder, options: options)
        } else {
            setImage(placeholder, for: state)
        }
    }
}
