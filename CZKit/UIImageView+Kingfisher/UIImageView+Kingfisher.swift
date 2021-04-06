//
//  File.swift
//  letaoshijie
//
//  Created by udream3 on 2021/1/29.
//
import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
    
    /// 设置网络图片
    func cz_setImage(url: String?, placeholder: UIImage?, indicatorType: Kingfisher.IndicatorType = .none, options: KingfisherOptionsInfo? = [.transition(.fade(0.8))]) {
        if  url?.isEmpty == false || url?.hasPrefix("http://") == true || url?.hasPrefix("https://") == true, let url = URL(string: url) {
            kf.indicatorType = indicatorType
            kf.setImage(with: url, placeholder: placeholder, options: options)
        } else {
            image = placeholder
        }
    }
}
