//
//  CZTableViewCellExtension.swift
//  letaoshijie
//
//  Created by chaozheng on 2020/12/24.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    /// 设置首尾单元格圆角 （必要时加入到主线程）
    /// - Parameters:
    ///   - tableView: tableView
    ///   - tailorView: 裁剪的视图
    ///   - indexPath: indexPath description
    ///   - radius: 角度
    ///   - isExistHeaderView: 是否存在分组头
    ///   - isExistFooterView: 是否存在分组尾
    func cz_setHeadAndTailRoundCorners(tableView: UITableView,
                                       tailorView: UIView,
                                       indexPath: IndexPath,
                                       radius: CGFloat = 8,
                                       isExistHeaderView: Bool = false,
                                       isExistFooterView: Bool = false) {
        //  let tableView = cz_superView(seekSuperView: UITableView.self)
        /// 获取当前分组行数
        let numberOfRow = tableView.numberOfRows(inSection: indexPath.section)
        if isExistHeaderView == false, isExistFooterView == false { // 不存在分组头 & 不存在分组尾
            /// 长度为1时 所有角为圆角，否则首单元格顶部圆角，尾部单元格底部圆角
            if numberOfRow == 1 {
                tailorView.cz_roundCorners(.allCorners, radius: radius)
            } else {
                if indexPath.row == 0 {
                    tailorView.cz_roundCorners([.topLeft, .topRight], radius: radius)
                } else if indexPath.row == numberOfRow - 1 {
                    tailorView.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
                } else {
                    tailorView.layer.mask = nil
                }
            }
        } else if isExistHeaderView, isExistFooterView == false { // 存在分组头，不存在分组尾 只切最后一个cell底部圆角
            if indexPath.row == numberOfRow - 1 {
                tailorView.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
            } else {
                tailorView.layer.mask = nil
            }
        } else if isExistHeaderView == false, isExistFooterView { // 不存在分组头，存在分组尾 只切第一个cell顶部圆角
            if indexPath.row == 0 {
                tailorView.cz_roundCorners([.topLeft, .topRight], radius: radius)
            } else {
                tailorView.layer.mask = nil
            }
        } else {
            tailorView.layer.mask = nil
        }
    }
}
