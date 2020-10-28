//
//  CZLabel.swift
//  Random
//
//  Created by yu mingming on 2019/12/3.
//  Copyright © 2019 刘超正. All rights reserved.
//

import UIKit

public class CZLabel: UILabel {
    
    enum CZVerticalAlignment {
        case top
        case middle
        case bottom
    }
    
    /// 设置垂直对齐方式 默认顶部对齐
    var cz_verticalAlignment : CZVerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// 是否需要长按复制的功能，默认为 false
    var cz_canPerformCopyAction: Bool = false {
        didSet {
            if self.cz_canPerformCopyAction == true && self.longPressGestureRecognizer == nil {
                self.isUserInteractionEnabled = true
                longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognizerAction))
                self.addGestureRecognizer(longPressGestureRecognizer!)
            } else if self.cz_canPerformCopyAction == false && self.longPressGestureRecognizer != nil {
                self.removeGestureRecognizer(longPressGestureRecognizer!)
                longPressGestureRecognizer = nil
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    /// 点击复制的回调
    var cz_didCopyBlock: ((_ label: CZLabel, _ value: String) -> Void)?
    
    /// 是否需要点击的功能，默认为 false
    var cz_canPerformTapAction: Bool = false {
        didSet {
            if self.cz_canPerformTapAction == true && self.tapGestureRecognizer == nil {
                self.isUserInteractionEnabled = true
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
                self.addGestureRecognizer(tapGestureRecognizer!)
            } else if self.cz_canPerformTapAction == false && self.tapGestureRecognizer != nil {
                self.removeGestureRecognizer(tapGestureRecognizer!)
                tapGestureRecognizer = nil
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    /// 点击的回调
    var cz_didTapBlock: ((_ label: CZLabel) -> Void)?
    
    /// 长按手势
    private var longPressGestureRecognizer: UILongPressGestureRecognizer?
    
    /// 点击手势
    private var tapGestureRecognizer: UITapGestureRecognizer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() { }
    
    // MARK: - 长按手势响应
    @objc private func longPressGestureRecognizerAction(recognizer: UILongPressGestureRecognizer) {
        guard self.cz_canPerformCopyAction else { return }
        guard recognizer.state == .began else { return }
        self.becomeFirstResponder()
        let menuController = UIMenuController.shared
        let copyMenuItem = UIMenuItem(title: "复制", action: #selector(copyString))
        menuController.menuItems = [copyMenuItem]
        menuController.setTargetRect(self.frame, in: self.superview!)
        menuController.setMenuVisible(true, animated: true)
    }
    
    @objc private func copyString() {
        if self.cz_canPerformCopyAction {
            let pasteboard = UIPasteboard.general
            guard let text = self.text else { return }
            pasteboard.string = text
            guard (cz_didCopyBlock != nil) else { return }
            cz_didCopyBlock!(self, text)
        }
    }
    
    public override var canBecomeFirstResponder: Bool {
        get {
            return self.cz_canPerformCopyAction
        }
    }
    
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copyString) {
            return true
        }
        return false
    }
    
    // MARK: - 点击手势响应
    @objc private func tapGestureRecognizerAction(recognizer: UITapGestureRecognizer) {
        guard self.cz_canPerformTapAction  else { return }
        guard (self.cz_didTapBlock != nil)  else { return }
        cz_didTapBlock!(self)
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)

        if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
            switch cz_verticalAlignment {
            case .top:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        } else {
            switch cz_verticalAlignment {
            case .top:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        }
    }

    override public func drawText(in rect: CGRect) {
        let rect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: rect)
    }
}
