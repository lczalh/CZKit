//
//  CZTextFieldExtension.swift
//  XinmeiMerchant
//
//  Created by chaozheng on 2020/11/19.
//
import Foundation
import UIKit

public extension UITextField {
    
    struct CZTextFieldKey {
        static let maxLenghtKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "maxLenghtKey".hashValue)
        static let regularKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "regularKey".hashValue)
        static let textEditingChangedKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "textEditingChangedKey".hashValue)
        static let oldTextValueKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "oldTextValueKey".hashValue)
        static let regularMatchingFailureKey : UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "regularMatchingFailureKey".hashValue)
    }
    
    /// 限制输入框长度 默认 nil：不限制
    var cz_maxLenght: Int? {
        get {
            return objc_getAssociatedObject(self, CZTextFieldKey.maxLenghtKey) as? Int
        }
        set {
            objc_setAssociatedObject(self, CZTextFieldKey.maxLenghtKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            addTarget(self, action: #selector(cz_textEditingChanged), for: .editingChanged)
        }
    }
    
    /// 正则条件 nil：不限制
    var cz_regular: CZRegularEnum? {
        get {
            return objc_getAssociatedObject(self, CZTextFieldKey.regularKey) as? CZRegularEnum
        }
        set {
            objc_setAssociatedObject(self, CZTextFieldKey.regularKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            addTarget(self, action: #selector(cz_textEditingChanged), for: .editingChanged)
        }
    }
    
    /// textField 值改变回调
    var cz_textEditingChangedBlock: ((UITextField) -> Void)? {
        get {
            return objc_getAssociatedObject(self, CZTextFieldKey.textEditingChangedKey) as? ((UITextField) -> Void)
        }
        set {
            objc_setAssociatedObject(self, CZTextFieldKey.textEditingChangedKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            addTarget(self, action: #selector(cz_textEditingChanged), for: .editingChanged)
        }
    }
    
    /// 记录旧的TextValue值
    private var cz_oldTextValue: String? {
        get {
            return objc_getAssociatedObject(self, CZTextFieldKey.oldTextValueKey) as? String
        }
        set {
            objc_setAssociatedObject(self, CZTextFieldKey.oldTextValueKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    /// 正则匹配失败回调 例如匹配失败需要做些提示 闭包返回值 用于匹配失败需替换指定的值，返回nil则默认为前一次输入的值
    var cz_regularMatchingFailureBlock: ((String) -> String?)? {
        get {
            return objc_getAssociatedObject(self, CZTextFieldKey.regularMatchingFailureKey) as? ((String) -> String?)
        }
        set {
            objc_setAssociatedObject(self, CZTextFieldKey.regularMatchingFailureKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    /// 值改变事件
    @objc private func cz_textEditingChanged(textField: UITextField) {
        guard var value = textField.text, textField.markedTextRange == nil else { return }
        let cursorPostion = offset(from: endOfDocument, to: selectedTextRange!.end)
        if let regular = cz_regular {
            guard let regex = try? NSRegularExpression(pattern: regular.value, options: []) else { return }
            let resultCount = regex.numberOfMatches(in: value, options: [], range: NSRange(location: 0, length: value.count))
            if resultCount == 0 {
                if cz_regularMatchingFailureBlock == nil {
                    value = cz_oldTextValue ?? ""
                } else {
                    value = cz_regularMatchingFailureBlock?(value) ?? cz_oldTextValue ?? ""
                }
            }
        }
        if let maxLenght = cz_maxLenght { value = String(value.prefix(maxLenght)) }
        textField.text = value
        cz_oldTextValue = value
        let targetPostion = position(from: endOfDocument, offset: cursorPostion)!
        selectedTextRange = textRange(from: targetPostion, to: targetPostion)
        if cz_textEditingChangedBlock != nil { cz_textEditingChangedBlock!(textField) }
    }
    
}

public extension CZKit where Base: UITextField {
    
    /// 正则条件 nil：不限制
    @discardableResult
    func regular(_ regular: CZRegularEnum) -> CZKit {
        base.cz_regular = regular
        return self
    }
    
    /// 限制输入框长度 默认 nil：不限制
    @discardableResult
    func maxLenght(_ maxLenght: Int?) -> CZKit {
        base.cz_maxLenght = maxLenght
        return self
    }
    
    /// textField 值改变回调
    @discardableResult
    func textEditingChangedBlock(_ textEditingChangedBlock: ((UITextField) -> Void)?) -> CZKit {
        base.cz_textEditingChangedBlock = textEditingChangedBlock
        return self
    }
    
    /// 正则匹配失败回调 例如匹配失败需要做些提示 闭包返回值 用于匹配失败需替换指定的值，返回nil则默认为前一次输入的值
    @discardableResult
    func regularMatchingFailureBlock(_ regularMatchingFailureBlock: ((String) -> String?)?) -> CZKit {
        base.cz_regularMatchingFailureBlock = regularMatchingFailureBlock
        return self
    }
}
