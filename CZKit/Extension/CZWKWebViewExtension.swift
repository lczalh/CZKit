//
//  CZWKWebViewExtension.swift
//  letaoshijie
//
//  Created by udream3 on 2021/2/24.
//
import Foundation
import UIKit
import WebKit

public extension WKWebView {
    
    /// RegisterSchem
    func cz_wkRegisterScheme() {
        let selector =  Selector(("registerSchemeForCustomProtocol:"))
        let vc = value(forKey: "browsingContextController") as AnyObject
        let cls = type(of: vc) as AnyObject
        _ = cls.perform(selector, with: "http")
        _ = cls.perform(selector, with: "https")
    }
}
