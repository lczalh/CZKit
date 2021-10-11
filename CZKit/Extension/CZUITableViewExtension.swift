//
//  CZTableViewExtension.swift
//  letaoshijie
//
//  Created by udream3 on 2020/12/24.
//
import Foundation
import UIKit

public extension UITableView {
    
    /// 根据自动版式约束将页眉的大小调整为适当的大小
    func cz_sizeHeaderToFit() {
        if let headerView = tableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame
            tableHeaderView = headerView
        }
    }
    
    /// 根据自动版式约束将页脚的大小调整为适当的大小
    func cz_sizeFooterToFit() {
        if let footerView = tableFooterView {
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()
            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = footerView.frame
            frame.size.height = height
            footerView.frame = frame
            tableFooterView = footerView
        }
    }
}
