//
//  CZMarginTableViewCell.swift
//  UdreamPlus
//
//  Created by udream3 on 2021/6/16.
//  Copyright © 2021 Zaki. All rights reserved.
//

import UIKit
import SnapKit

class CZMarginTableViewCell: UITableViewCell {
    
    /// 边距视图
    var marginView: UIView!
    
    /// 设置边缘距离
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            marginView.snp.updateConstraints { make in
                make.edges.equalToSuperview().inset(edgeInsets)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        marginView = UIView()
            .cz
            .addSuperView(contentView)
            .makeConstraints({ make in
                make.edges.equalToSuperview()
            })
            .backgroundColor(.white)
            .build
    }
    
    /// 设置首尾单元格圆角 （必要时加入到主线程）
    /// - Parameters:
    ///   - indexPath: indexPath description
    ///   - radius: 角度
    ///   - isExistHeaderView: 是否存在分组头
    ///   - isExistFooterView: 是否存在分组尾
    func setHeadAndTailRoundCorners(indexPath: IndexPath, radius: CGFloat = 8, isExistHeaderView: Bool = false, isExistFooterView: Bool = false) {
        let tableView = cz_superView(seekSuperView: UITableView.self)
        /// 获取当前分组行数
        let numberOfRow = tableView?.numberOfRows(inSection: indexPath.section) ?? 0
        if isExistHeaderView == false, isExistFooterView == false { // 不存在分组头 & 不存在分组尾
            /// 长度为1时 所有角为圆角，否则首单元格顶部圆角，尾部单元格底部圆角
            if numberOfRow == 1 {
                marginView.cz_roundCorners(.allCorners, radius: radius)
            } else {
                if indexPath.row == 0 {
                    marginView.cz_roundCorners([.topLeft, .topRight], radius: radius)
                } else if indexPath.row == numberOfRow - 1 {
                    marginView.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
                } else {
                    marginView.layer.mask = nil
                }
            }
        } else if isExistHeaderView, isExistFooterView == false { // 存在分组头，不存在分组尾 只切最后一个cell底部圆角
            if indexPath.row == numberOfRow - 1 {
                marginView.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
            } else {
                marginView.layer.mask = nil
            }
        } else if isExistHeaderView == false, isExistFooterView { // 不存在分组头，存在分组尾 只切第一个cell顶部圆角
            if indexPath.row == 0 {
                marginView.cz_roundCorners([.topLeft, .topRight], radius: radius)
            } else {
                marginView.layer.mask = nil
            }
        } else {
            marginView.layer.mask = nil
        }
        
    }
    
    /// 设置所有单元格圆角 （必要时加入到主线程）
    /// - Parameter radius: 角度
    func setAllRoundCorners(radius: CGFloat = 8) {
        marginView.cz_roundCorners(.allCorners, radius: radius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
