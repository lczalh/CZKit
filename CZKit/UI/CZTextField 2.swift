//
//  CZTextField.swift
//  Random
//
//  Created by yu mingming on 2019/11/28.
//  Copyright © 2019 刘超正. All rights reserved.
//

import UIKit

public class CZTextField: UITextField {
    
    /// 过滤字符串正则
    enum CZFilterStringRegular: String {
        case chinese = "[^\\u4E00-\\u9FA5]"
        case english = "[^A-Za-z]"
        case number = "[^0-9]"
        case chineseAndEnglish = "[^A-Za-z\\u4E00-\\u9FA5]"
        case englishAndNumber = "[^A-Za-z0-9]"
        case englishAndNumberAndUnderline = "[^A-Za-z0-9_]"
    }
    
    /// 正则过滤规则
    var cz_filterStringRegular: String?
    
    /// 字符串最大长度
    var cz_textMaxCount: Int?
    
    /// 占位符颜色
    var cz_placeholderColor: UIColor = UIColor.cz_rgbColor(196, 200, 208) {
        didSet {
            guard (self.placeholder != nil) else {
                self.updateAttributedPlaceholderIfNeeded()
                return
            }
        }
    }
    
    /// 返回输入的值
    var cz_returnText: ((_ value: String) -> Void)?
    
    public override var placeholder: String? {
        didSet {
            self.updateAttributedPlaceholderIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.textFieldChanged),
                                               name:NSNotification.Name(rawValue:"UITextFieldTextDidChangeNotification"),
                                               object: self)
    }
    
    private func updateAttributedPlaceholderIfNeeded() {
        self.attributedPlaceholder = NSMutableAttributedString.init(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : cz_placeholderColor])
    }
    
    // MARK: - textField内容改变通知响应
    @objc private func textFieldChanged(notification: Notification) {
        //非markedText才继续往下处理
        guard let _: UITextRange = self.markedTextRange else{
            //当前光标的位置（后面会对其做修改）
            let cursorPostion = self.offset(from: self.endOfDocument,
                                            to: self.selectedTextRange!.end)
            var str = self.text
            if cz_filterStringRegular != nil {
                //替换后的字符串（过滤调非中文字符）
                str = str!.cz_regularReplacement(pattern: cz_filterStringRegular!, with: "")
            }
            if cz_textMaxCount != nil {
                //如果长度超过限制则直接截断
                if str!.count > cz_textMaxCount! {
                    str = String(str!.prefix(cz_textMaxCount!))
                }
            }
            self.text = str
            //让光标停留在正确位置
            let targetPostion = self.position(from: self.endOfDocument,
                                              offset: cursorPostion)!
            self.selectedTextRange = self.textRange(from: targetPostion,
                                                    to: targetPostion)
            
            if self.cz_returnText != nil {
                self.cz_returnText!(self.text!)
            }
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name:NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
                                                  object: self)
    }
}


