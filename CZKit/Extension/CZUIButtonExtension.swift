//
//  CZButtonExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/11/28.
//

import Foundation
import UIKit

public extension UIButton {
    
    /// 设置文字和图片的位置
    ///
    /// - Parameters:
    ///   - image: 图片对象
    ///   - title: 文字
    ///   - titlePosition: 文字在图片的哪一边
    ///   - additionalSpacing: 间距
    ///   - state: 按钮状态
    func cz_titleImageDirection(image: UIImage?,
                                title: String,
                                titlePosition: UIView.ContentMode,
                                additionalSpacing: CGFloat,
                                state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(image, for: state)
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        positionLabelRespectToImage(imageSize: image?.size ?? CGSize(width: 0, height: 0), title: title, position: titlePosition, spacing: additionalSpacing)
    }
    private func positionLabelRespectToImage(imageSize: CGSize, title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing*2),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            self.contentEdgeInsets = UIEdgeInsets(top: (titleSize.height + spacing), left: -(min(titleSize.width, imageSize.width)/2), bottom: 0, right: -(min(titleSize.width, imageSize.width)/2))
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing*2),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: -(min(titleSize.width, imageSize.width)/2), bottom: (titleSize.height + spacing), right: -(min(titleSize.width, imageSize.width)/2))
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing*2))
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing*2)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    /// 设置按钮背景颜色
    /// - Parameters:
    ///   - color: color description
    ///   - state: state description
    func cz_setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(color.cz_drawImage(), for: state)
    }
    
    /// 开启获取验证码计时器
    func cz_startGetCodeTimer(totalTime: Int = 59, state: UIControl.State = .normal) {
        var remainTime = totalTime
        var timer: Timer?
        setTitle("重新获取(\(remainTime)s)", for: state)
        isEnabled = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] (time) in
            if remainTime == 1 {
                timer?.invalidate()
                timer = nil
                self?.setTitle("获取验证码", for: state)
                remainTime = 60
                self?.isEnabled = true
            } else {
                remainTime -= 1
                self?.setTitle("重新获取(\(remainTime)s)", for: state)
                self?.isEnabled = false
            }
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
}

public extension CZKit where Base: UIButton {
    
    /// 设置文字和图片的位置
    @discardableResult
    func titleImageDirection(image: UIImage?, title: String, titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State) -> CZKit {
        base.cz_titleImageDirection(image: image, title: title, titlePosition: titlePosition, additionalSpacing: additionalSpacing, state: state)
        return self
    }
}
