//
//  UIScrollView+MJRefresh.swift
//  letaoshijie
//
//  Created by udream3 on 2020/12/22.
//
import Foundation
import UIKit
import MJRefresh

public extension UIScrollView {
    
    /// 请求成功更新刷新状态
    /// - Parameters:
    ///   - view: 上下刷新视图
    ///   - currentPage: 当前分页数
    ///   - currentTotalCount: 当前请求的到的列表数据总数
    ///   - pageSize: 一页总大小
    func cz_succeedUpdateRefreshing(_ currentPage: Int = 1, _ currentTotalCount: Int, _ pageSize: Int = 10) {
        if Thread.current.isMainThread {
            if mj_header?.isRefreshing == true { mj_header?.endRefreshing() }
            // 当页数为首页时 重置上拉没有更多数据状态
            if currentPage <= 1 { mj_footer?.resetNoMoreData() }
            if mj_footer?.isRefreshing == true {
                if currentTotalCount >= pageSize {
                    mj_footer?.endRefreshing()
                } else {
                    mj_footer?.endRefreshingWithNoMoreData()
                }
            }
        } else {
            DispatchQueue.main.async {
                if self.mj_header?.isRefreshing == true { self.mj_header?.endRefreshing() }
                // 当页数为首页时 重置上拉没有更多数据状态
                if currentPage <= 1 { self.mj_footer?.resetNoMoreData() }
                if self.mj_footer?.isRefreshing == true {
                    if currentTotalCount >= pageSize {
                        self.mj_footer?.endRefreshing()
                    } else {
                        self.mj_footer?.endRefreshingWithNoMoreData()
                    }
                }
            }
        }
    }
    
    /// 请求失败更新刷新状态
    func cz_failureUpdateRefreshing() {
        if Thread.current.isMainThread {
            if mj_header?.isRefreshing == true { mj_header?.endRefreshing() }
            if mj_footer?.isRefreshing == true { mj_footer?.endRefreshing() }
        } else {
            DispatchQueue.main.async {
                if self.mj_header?.isRefreshing == true { self.mj_header?.endRefreshing() }
                if self.mj_footer?.isRefreshing == true { self.mj_footer?.endRefreshing() }
            }
        }
    }
}
