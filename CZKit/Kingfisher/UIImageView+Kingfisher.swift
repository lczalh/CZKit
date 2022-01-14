//
//  UIImageView+Kingfisher.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/12/21.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
    
    /// 设置网络图片
    func cz_setImage(string: String?,
                     placeholder: UIImage?,
                     indicatorType: Kingfisher.IndicatorType = .activity,
                     options: KingfisherOptionsInfo? = [.transition(.fade(0.8))],
                     progressBlock: DownloadProgressBlock? = nil,
                     completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        if let string = string, string.isEmpty == false, string.hasPrefix("http://") == true || string.hasPrefix("https://") == true, let url = URL(string: string) {
            kf.indicatorType = indicatorType
            kf.setImage(with: url, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
        } else {
            image = placeholder
        }
    }
    
    /// 设置网络图片
    func cz_setImage(url: URL?,
                     placeholder: UIImage?,
                     indicatorType: Kingfisher.IndicatorType = .activity,
                     options: KingfisherOptionsInfo? = [.transition(.fade(0.8))],
                     progressBlock: DownloadProgressBlock? = nil,
                     completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        if let url = url {
            kf.indicatorType = indicatorType
            kf.setImage(with: url, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
        } else {
            image = placeholder
        }
    }
}


