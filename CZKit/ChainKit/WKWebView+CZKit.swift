//
//  WKWebView+CZKit.swift
//  letaoshijie
//
//  Created by 刘超正 on 2021/6/29.
//

import Foundation
import WebKit

public extension CZKit where Base: WKWebView {
    
    /// 导航代理
    @discardableResult
    func navigationDelegate(_ navigationDelegate: WKNavigationDelegate?) -> CZKit {
        base.navigationDelegate = navigationDelegate
        return self
    }
    
    /// 用户交互代理
    @discardableResult
    func uiDelegate(_ uiDelegate: WKUIDelegate?) -> CZKit {
        base.uiDelegate = uiDelegate
        return self
    }
    
    @discardableResult
    func customUserAgent(_ customUserAgent: String?) -> CZKit {
        base.customUserAgent = customUserAgent
        return self
    }
    
}
