//
//  UIScrollView+MJRefresh.swift
//  letaoshijie
//
//  Created by chaozheng on 2020/12/22.
//

import Foundation
import UIKit
import MJRefresh

public extension UIScrollView {
    
    /// 请求成功更新刷新状态
    /// - Parameters:
    ///   - requestTotalCount: 当前请求的到的列表数据总数
    ///   - pageSize: 一页总大小
    func cz_succeedUpdateRefreshing(requestTotalCount: Int, pageSize: Int = 10) {
        if mj_header?.isRefreshing == true {
            mj_header?.endRefreshing()
            if requestTotalCount >= pageSize {
                // 重置上拉没有更多数据状态
                mj_footer?.resetNoMoreData()
            } else {
                mj_footer?.endRefreshingWithNoMoreData()
            }
        }
        if mj_footer?.isRefreshing == true {
            if requestTotalCount >= pageSize {
                mj_footer?.endRefreshing()
            } else {
                mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
    /// 请求失败更新刷新状态
    func cz_failureUpdateRefreshing() {
        if mj_header?.isRefreshing == true { mj_header?.endRefreshing() }
        if mj_footer?.isRefreshing == true { mj_footer?.endRefreshing() }
    }
}
