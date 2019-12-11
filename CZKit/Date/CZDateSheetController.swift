//
//  PopTimeSelectBoxViewController.swift
//  csomanage
//
//  Created by yu mingming on 2019/9/6.
//  Copyright © 2019 glgs. All rights reserved.
//

import UIKit

public class CZDateSheetController: UIViewController {
    
    private lazy var czDateSheetView: CZDateSheetView = {
        return CZDateSheetView()
    }()
    
    /// 展示的时间模式
    var cz_datePickerMode: UIDatePicker.Mode? {
        didSet {
            czDateSheetView.datePicker.datePickerMode = cz_datePickerMode!
        }
    }
    
    /// 设置最小可选日期
    var cz_minimumDate: Date? {
        didSet {
            czDateSheetView.datePicker.minimumDate = cz_minimumDate
        }
    }
    
    /// 设置最大可选日期
    var cz_maximumDate: Date? {
        didSet {
            czDateSheetView.datePicker.maximumDate = cz_maximumDate
        }
    }
    
    /// 设置日期选择器区域语言， 默认为中文
    var cz_locale: Locale? = Locale(identifier: "zh_CN") {
        didSet {
            czDateSheetView.datePicker.locale = cz_locale
        }
    }
    
    /// 动画时长
    var cz_animateDuration: TimeInterval = 0.3
    
    /// 日期视图高度
    var cz_dateSheetViewHeight: CGFloat = 260.0
    
    /// 返回选中的时间回调
    var cz_selectDateBlock: ((_ date: Date) -> Void)?
    
    /// 修改确定按钮标题文字
    var cz_confirmTitleString: String? {
        didSet {
            czDateSheetView.confirmButton.setTitle(cz_confirmTitleString, for: .normal)
        }
    }
    
    /// 修改确定按钮标题文字颜色
    var cz_confirmTitleColor: UIColor? {
        didSet {
            czDateSheetView.confirmButton.setTitleColor(cz_confirmTitleColor, for: .normal)
        }
    }
    
    /// 设置确定按钮标题字体大小
    var cz_confirmTitleFont: UIFont? {
        didSet {
            czDateSheetView.confirmButton.titleLabel?.font = cz_confirmTitleFont
        }
    }
    
    /// 设置取消按钮标题字体大小
    var cz_cancelTitleFont: UIFont? {
        didSet {
            czDateSheetView.cancelbutton.titleLabel?.font = cz_cancelTitleFont
        }
    }
    
    /// 修改取消按钮标题文字
    var cz_cancelTitleString: String? {
        didSet {
            czDateSheetView.cancelbutton.setTitle(cz_cancelTitleString, for: .normal)
        }
    }
    
    /// 修改取消按钮标题文字颜色
    var cz_cancelTitleColor: UIColor? {
        didSet {
            czDateSheetView.cancelbutton.setTitleColor(cz_cancelTitleColor, for: .normal)
        }
    }
    
    /// 修改分割线背景颜色
    var cz_dividerBackgroundColor: UIColor? {
        didSet {
            czDateSheetView.dividerView.backgroundColor = cz_dividerBackgroundColor
        }
    }
    
    /// 选中的时间
    private var selectDate: Date = Date()
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.czDateSheetView.frame.origin = CGPoint(x: 0, y: CZCommon.cz_screenHeight)
        UIView.animate(withDuration: self.cz_animateDuration, delay: 0, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor.cz_rgbColor(0, 0, 0, 0.5)
            self.czDateSheetView.frame.origin = CGPoint(x: 0, y: CZCommon.cz_screenHeight - self.cz_dateSheetViewHeight)
        }, completion: nil)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 100
        view.addSubview(czDateSheetView)
        czDateSheetView.confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        czDateSheetView.cancelbutton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        czDateSheetView.datePicker.addTarget(self, action: #selector(dateValueChangedAction), for: .valueChanged)

       
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touche in touches {
            if touche.view?.tag == 100 {
                dismissAnimated()
            }
        }
    }
    
    // MARK: - 确定事件
    @objc private func confirmAction(sender: UIButton) {
        if self.cz_selectDateBlock != nil {
            self.cz_selectDateBlock?(self.selectDate)
        }
        self.dismissAnimated()
    }
    
    // MARK: - 取消事件
    @objc private func cancelAction(sender: UIButton) {
        self.dismissAnimated()
    }
    
    // MARK: - 日期改变事件
    @objc private func dateValueChangedAction(datePicker : UIDatePicker) {
        self.selectDate = datePicker.date
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.czDateSheetView.frame = CGRect(x: 0, y: CZCommon.cz_screenHeight - self.cz_dateSheetViewHeight, width: CZCommon.cz_screenWidth, height: self.cz_dateSheetViewHeight)
    }
    
    private func dismissAnimated() {
        UIView.animate(withDuration: self.cz_animateDuration, delay: 0, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor.cz_rgbColor(0, 0, 0, 0)
            self.czDateSheetView.frame.origin = CGPoint(x: 0, y: CZCommon.cz_screenHeight)
        }, completion: { (state) in
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
    
    public override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .overFullScreen
        }
        set{}
    }
    
    
    /// 快速显示CZDateSheetController
    /// - Parameter controller: 当前所在的控制器
    /// - Parameter datePickerMode: 日期模式 默认 年月日
    /// - Parameter minimumDate: 最小可选日期 默认 nil
    /// - Parameter maximumDate: 最大可选日期 默认 nil
    /// - Parameter animateDuration: 动画时长 默认0.3秒
    /// - Parameter dateSheetViewHeight: 日期视图的高度 默认260
    /// - Parameter locale: 语言 默认中文
    /// - Parameter value: 选择的时间
    class func cz_show(_ controller: UIViewController,
                       datePickerMode: UIDatePicker.Mode = .date,
                       confirmTitleString: String? = "确定1",
                       confirmTitleColor: UIColor? = UIColor.cz_hexColor("#108EE9"),
                       confirmTitleFont: UIFont? = UIFont.cz_systemFont(16),
                       cancelTitleFont: UIFont? = UIFont.cz_systemFont(16),
                       cancelTitleString: String? = "取消",
                       cancelTitleColor: UIColor? = UIColor.cz_hexColor("#999999"),
                       dividerBackgroundColor: UIColor? = UIColor.cz_rgbColor(238, 238, 238),
                       minimumDate: Date? = nil,
                       maximumDate: Date? = nil,
                       animateDuration: TimeInterval = 0.3,
                       dateSheetViewHeight: CGFloat = 260,
                       locale: Locale? = Locale(identifier: "zh_CN"),
                       _ value: @escaping ((_ date: Date) -> Void)) {
        let vc = CZDateSheetController()
        vc.cz_datePickerMode = datePickerMode
        vc.cz_confirmTitleString = confirmTitleString
        vc.cz_confirmTitleColor = confirmTitleColor
        vc.cz_confirmTitleFont = confirmTitleFont
        vc.cz_cancelTitleFont = cancelTitleFont
        vc.cz_cancelTitleString = cancelTitleString
        vc.cz_cancelTitleColor = cancelTitleColor
        vc.cz_dividerBackgroundColor = dividerBackgroundColor
        vc.cz_minimumDate = minimumDate
        vc.cz_maximumDate = maximumDate
        vc.cz_animateDuration = animateDuration
        vc.cz_dateSheetViewHeight = dateSheetViewHeight
        vc.cz_locale = locale
        vc.cz_selectDateBlock = { value($0) }
        controller.present(vc, animated: false, completion: nil)
    }
}
