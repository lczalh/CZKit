//
//  CZMarginCollectionViewCell.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/8/30.
//

import UIKit
import SnapKit

public class CZBaseCollectionViewCell: UICollectionViewCell {
    
    /// 设置边缘距离
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(edgeInsets)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView
            .cz
            .remakeConstraints({ make in
                make.edges.equalToSuperview()
            })
            .backgroundColor(.white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
