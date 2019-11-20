//
//  PopTimeSelectBoxViewController.swift
//  csomanage
//
//  Created by yu mingming on 2019/9/6.
//  Copyright © 2019 glgs. All rights reserved.
//

import UIKit
import SwifterSwift

public class CZDateSheetController: UIViewController {
    
    private var czDateSheetView: CZDateSheetView = CZDateSheetView()
    
    /// 展示的时间模式
    var datePickerMode: UIDatePicker.Mode? {
        didSet {
            czDateSheetView.datePicker.datePickerMode = datePickerMode!
        }
    }
    
    /// 设置最小可选日期
    var minimumDate: Date? {
        didSet {
            czDateSheetView.datePicker.minimumDate = minimumDate
        }
    }
    
    /// 设置最大可选日期
    var maximumDate: Date? {
        didSet {
            czDateSheetView.datePicker.maximumDate = maximumDate
        }
    }
    
    /// 设置日期选择器区域语言， 默认为中文
    var locale: Locale? = Locale(identifier: "zh_CN") {
        didSet {
            czDateSheetView.datePicker.locale = locale
        }
    }
    
    /// 动画时长
    var animateDuration: TimeInterval = 0.3
    
    /// 日期视图高度
    var dateSheetViewHeight: CGFloat = 260.0
    
    /// 返回选中的时间
    var returnSelectDate: ((_ date: Date) -> Void)?
    
    /// 选中的时间
    private var selectDate: Date = Date()
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.czDateSheetView.frame.origin = CGPoint(x: 0, y: cz_screenHeight)
        UIView.animate(withDuration: self.animateDuration, delay: 0, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, transparency: 0.5)
            self.czDateSheetView.frame.origin = CGPoint(x: 0, y: cz_screenHeight - self.dateSheetViewHeight)
        }, completion: nil)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(czDateSheetView)
        czDateSheetView.confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        czDateSheetView.cancelbutton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        czDateSheetView.datePicker.addTarget(self, action: #selector(dateValueChangedAction), for: .valueChanged)

       
    }
    
    // MARK: - 确定事件
    @objc func confirmAction(sender: UIButton) {
        if self.returnSelectDate != nil {
            self.returnSelectDate?(self.selectDate)
        }
        self.dismissAnimated()
    }
    
    // MARK: - 取消事件
    @objc func cancelAction(sender: UIButton) {
        self.dismissAnimated()
    }
    
    // MARK: - 日期改变事件
    @objc func dateValueChangedAction(datePicker : UIDatePicker) {
        self.selectDate = datePicker.date
    }
    
    override public func viewDidLayoutSubviews() {
        self.czDateSheetView.frame = CGRect(x: 0, y: cz_screenHeight - self.dateSheetViewHeight, width: cz_screenWidth, height: self.dateSheetViewHeight)
    }
    
    private func dismissAnimated() {
        UIView.animate(withDuration: self.animateDuration, delay: 0, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, transparency: 0)
            self.czDateSheetView.frame.origin = CGPoint(x: 0, y: cz_screenHeight)
        }, completion: { (state) in
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
    
    
    /// 显示CZDateSheetController
    /// - Parameter controller: 当前所在的控制器
    /// - Parameter datePickerMode: 日期模式 默认 年月日
    /// - Parameter minimumDate: 最小可选日期 默认 nil
    /// - Parameter maximumDate: 最大可选日期 默认 nil
    /// - Parameter animateDuration: 动画时长 默认0.3秒
    /// - Parameter dateSheetViewHeight: 日期视图的高度 默认260
    /// - Parameter locale: 语言 默认中文
    /// - Parameter value: 选择的时间
    class func show(_ controller: UIViewController,
                    _ datePickerMode: UIDatePicker.Mode = .date,
                    _ minimumDate: Date? = nil,
                    _ maximumDate: Date? = nil,
                    _ animateDuration: TimeInterval = 0.3,
                    _ dateSheetViewHeight: CGFloat = 260,
                    _ locale: Locale? = Locale(identifier: "zh_CN"),
                    _ value: @escaping ((_ date: Date) -> Void)) {
        let vc = CZDateSheetController()
        vc.modalPresentationStyle = .overFullScreen
        vc.datePickerMode = datePickerMode
        vc.minimumDate = minimumDate
        vc.maximumDate = maximumDate
        vc.animateDuration = animateDuration
        vc.dateSheetViewHeight = dateSheetViewHeight
        vc.locale = locale
        vc.returnSelectDate = { value($0) }
        controller.present(vc, animated: false, completion: nil)
    }
}
