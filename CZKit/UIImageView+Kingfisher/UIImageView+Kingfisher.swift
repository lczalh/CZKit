//
//  File.swift
//  letaoshijie
//
//  Created by udream3 on 2021/1/29.
//
import Kingfisher

public extension UIImageView {
    
    /// 设置网络图片
    func cz_setImage(url: String?, placeholder: UIImage?, indicatorType: Kingfisher.IndicatorType = .activity, options: KingfisherOptionsInfo? = [.transition(.fade(0.8))]) {
        if  url?.isEmpty == false || url?.hasPrefix("http://") == true || url?.hasPrefix("https://") == true {
            kf.indicatorType = indicatorType
            kf.setImage(with: URL(string: url), placeholder: placeholder, options: options)
        } else {
            image = placeholder
        }
    }
}
