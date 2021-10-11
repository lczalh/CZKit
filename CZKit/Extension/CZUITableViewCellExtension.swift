//
//  CZTableViewCellExtension.swift
//  letaoshijie
//
//  Created by udream3 on 2020/12/24.
//
import Foundation
import UIKit

public extension UITableViewCell {
    
    /// 设置首尾单元格圆角 （必要时加入到主线程）
    /// - Parameters:
    ///   - indexPath: indexPath description
    ///   - radius: 角度
    ///   - isExistHeaderView: 是否存在分组头
    ///   - isExistFooterView: 是否存在分组尾
    func cz_setHeadAndTailRoundCorners(indexPath: IndexPath, radius: CGFloat = 8, isExistHeaderView: Bool = false, isExistFooterView: Bool = false) {
        let tableView = cz_superView(seekSuperView: UITableView.self)
        /// 获取当前分组行数
        let numberOfRow = tableView?.numberOfRows(inSection: indexPath.section) ?? 0
        if isExistHeaderView == false, isExistFooterView == false { // 不存在分组头 & 不存在分组尾
            /// 长度为1时 所有角为圆角，否则首单元格顶部圆角，尾部单元格底部圆角
            if numberOfRow == 1 {
                self.cz_roundCorners(.allCorners, radius: radius)
                contentView.cz_roundCorners(.allCorners, radius: radius)
            } else {
                if indexPath.row == 0 {
                    self.cz_roundCorners([.topLeft, .topRight], radius: radius)
                    contentView.cz_roundCorners([.topLeft, .topRight], radius: radius)
                } else if indexPath.row == numberOfRow - 1 {
                    self.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
                    contentView.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
                } else {
                    self.layer.mask = nil
                    contentView.layer.mask = nil
                }
            }
        } else if isExistHeaderView, isExistFooterView == false { // 存在分组头，不存在分组尾 只切最后一个cell底部圆角
            if indexPath.row == numberOfRow - 1 {
                self.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
                contentView.cz_roundCorners([.bottomLeft, .bottomRight], radius: radius)
            } else {
                self.layer.mask = nil
                contentView.layer.mask = nil
            }
        } else if isExistHeaderView == false, isExistFooterView { // 不存在分组头，存在分组尾 只切第一个cell顶部圆角
            if indexPath.row == 0 {
                self.cz_roundCorners([.topLeft, .topRight], radius: radius)
                contentView.cz_roundCorners([.topLeft, .topRight], radius: radius)
            } else {
                self.layer.mask = nil
                contentView.layer.mask = nil
            }
        } else {
            self.layer.mask = nil
            contentView.layer.mask = nil
        }
        
    }
    
    /// 设置所有单元格圆角 （必要时加入到主线程）
    /// - Parameter radius: 角度
    func cz_setAllRoundCorners(radius: CGFloat = 8) {
        self.cz_roundCorners(.allCorners, radius: radius)
        contentView.cz_roundCorners(.allCorners, radius: radius)
    }
}
