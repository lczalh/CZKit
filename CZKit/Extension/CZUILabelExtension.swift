//
//  CZLabelExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/11/28.
//

import Foundation
import UIKit

public extension UILabel {
    
    /// 判断文本标签的内容是否被截断
    var cz_isTruncated: Bool {
        superview?.layoutIfNeeded()
        guard let labelText = text, labelText.isEmpty == false, numberOfLines != 0 else { return false }
        //计算理论上显示所有文字需要的尺寸
        let labelTextSize = labelText.boundingRect(with: CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font as Any], context: nil)
        //计算理论上需要的行数
        let labelTextLines = Int(ceil(CGFloat(labelTextSize.height) / font.lineHeight))
        return labelTextLines > numberOfLines
    }
    
}
