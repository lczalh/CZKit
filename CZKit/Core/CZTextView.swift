//
//  CZTextView.swift
//  UdreamPlus
//
//  Created by udream3 on 2021/3/31.
//  Copyright © 2021 chaozheng. All rights reserved.
//
import Foundation
import UIKit

class CZTextView: UIView {
    
    var text: String? {
        didSet {
            textView.text = text
            updateTextStyle()
        }
    }
    
    /// 字体
    var font: UIFont = .systemFont(ofSize: 14) {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 行间距
    var lineSpacing: CGFloat = 5 {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 文本颜色
    var textColor: UIColor = .black {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 占位文本颜色
    var placeholderTextColor: UIColor = .cz_hexColor("#333333", 0.6) {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 占位文本
    var placeholderText: String? = "请输入..." {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 内边距
    var padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            textView.snp.updateConstraints { (make) in
                make.left.equalToSuperview().offset(padding.left)
                make.right.equalToSuperview().offset(-padding.right)
                make.top.equalToSuperview().offset(padding.top)
            }
            limitedNumberLabel.snp.updateConstraints { (make) in
                make.bottom.equalToSuperview().offset(-padding.bottom)
            }
        }
    }
    
    /// 最大长度
    var maxLenght: Int? {
        didSet {
            if let maxLenght = maxLenght {
                limitedNumberLabel.isHidden = false
                limitedNumberLabel.text = "\(textView.text.count) / \(maxLenght)"
                limitedNumberLabel.snp.updateConstraints { (make) in
                    make.top.equalTo(textView.snp.bottom).offset(5)
                }
            } else {
                limitedNumberLabel.isHidden = true
                limitedNumberLabel.text = nil
                limitedNumberLabel.snp.updateConstraints { (make) in
                    make.top.equalTo(textView.snp.bottom).offset(0)
                }
            }
            updateTextStyle()
        }
    }
    
    /// 限制数颜色
    var limitedNumberTextColor: UIColor = .black {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 限制数字体
    var limitedNumberFont: UIFont = .systemFont(ofSize: 14) {
        didSet {
            updateTextStyle()
        }
    }
    
    /// 值改变回调
    var textViewDidChangeBlock: ((_ textView: UITextView) -> Void)?
    
    /// 多行文本
    private var textView: UITextView!
    
    /// 占位标签
    private var placeholderLabel: UILabel!
    
    /// 限制数标签
    private var limitedNumberLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        textView = UITextView()
            .cz
            .addSuperView(self)
            .makeConstraints({ (make) in
                make.left.equalToSuperview().offset(padding.left)
                make.right.equalToSuperview().offset(-padding.right)
                make.top.equalToSuperview().offset(padding.top)
            })
            .delegate(self)
            .font(font)
            .textColor(textColor)
            .build
        
        placeholderLabel = UILabel()
            .cz
            .addSuperView(textView)
            .makeConstraints({ (make) in
                make.left.equalToSuperview().offset(5)
                make.top.equalToSuperview().offset(8)
                make.right.equalToSuperview().offset(-5)
            })
            .font(font)
            .text(placeholderText)
            .textColor(placeholderTextColor)
            .build
        
        limitedNumberLabel = UILabel()
            .cz
            .addSuperView(self)
            .makeConstraints({ (make) in
                make.top.equalTo(textView.snp.bottom)
                make.right.equalTo(textView.snp.right)
                make.bottom.equalToSuperview().offset(-padding.bottom)
            })
            .textColor(limitedNumberTextColor)
            .font(limitedNumberFont)
            .build
    }
    
    private func updateTextStyle() {
        placeholderLabel.isHidden = textView.text.count > 0
        guard textView.markedTextRange == nil else { return }
        if let maxLenght = maxLenght {
            let currentNumber = textView.text.count
            if currentNumber > maxLenght {
                let cursorPostion = textView.offset(from: textView.endOfDocument, to: textView.selectedTextRange!.end)
                // 如果长度超过限制则直接截断
                textView.text = String(textView.text.prefix(maxLenght))
                // 让光标停留在正确位置
                let targetPostion = textView.position(from: textView.endOfDocument, offset: cursorPostion)!
                textView.selectedTextRange = textView.textRange(from: targetPostion, to: targetPostion)
            }
            limitedNumberLabel.text = "\(textView.text.count) / \(maxLenght.string)"
        }
        // placeholderLabel
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderTextColor
        placeholderLabel.text = placeholderText
        // limitedNumberLabel
        limitedNumberLabel.textColor = limitedNumberTextColor
        limitedNumberLabel.font = limitedNumberFont
        // textView
        let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        mutableStr.addAttributes([NSAttributedString.Key.font: font,
                                  NSAttributedString.Key.paragraphStyle: paraph,
                                  NSAttributedString.Key.foregroundColor: textColor],
                                 range: NSMakeRange(0,mutableStr.length))
        textView.attributedText = mutableStr
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CZTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateTextStyle()
        if textViewDidChangeBlock != nil {
            textViewDidChangeBlock!(textView)
        }
    }
}


extension CZKit where Base: CZTextView {
    
    @discardableResult
    func font(_ font: UIFont) -> CZKit {
        base.font = font
        return self
    }
    
    @discardableResult
    func lineSpacing(_ lineSpacing: CGFloat) -> CZKit {
        base.lineSpacing = lineSpacing
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> CZKit {
        base.textColor = textColor
        return self
    }
    
    @discardableResult
    func placeholderTextColor(_ placeholderTextColor: UIColor) -> CZKit {
        base.placeholderTextColor = placeholderTextColor
        return self
    }
    
    @discardableResult
    func placeholderText(_ placeholderText: String) -> CZKit {
        base.placeholderText = placeholderText
        return self
    }
    
    @discardableResult
    func padding(_ padding: UIEdgeInsets) -> CZKit {
        base.padding = padding
        return self
    }
    
    @discardableResult
    func maxLenght(_ maxLenght: Int) -> CZKit {
        base.maxLenght = maxLenght
        return self
    }
    
    @discardableResult
    func limitedNumberTextColor(_ limitedNumberTextColor: UIColor) -> CZKit {
        base.limitedNumberTextColor = limitedNumberTextColor
        return self
    }
    
    @discardableResult
    func limitedNumberFont(_ limitedNumberFont: UIFont) -> CZKit {
        base.limitedNumberFont = limitedNumberFont
        return self
    }
    
    @discardableResult
    func textViewDidChangeBlock(_ textViewDidChangeBlock: ((_ textView: UITextView) -> Void)?) -> CZKit {
        base.textViewDidChangeBlock = textViewDidChangeBlock
        return self
    }
}
