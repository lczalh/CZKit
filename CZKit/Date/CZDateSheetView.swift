//
//  PopTimeSelectBoxView.swift
//  csomanage
//
//  Created by yu mingming on 2019/9/6.
//  Copyright © 2019 glgs. All rights reserved.
//

import UIKit

public class CZDateSheetView: UIView {
    
    /// 时间选择器
    var datePicker: UIDatePicker!
    
    /// 确定
    var confirmButton: UIButton!
    
    /// 取消
    var cancelbutton: UIButton!
    
    /// 分割线
    var dividerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        confirmButton = UIButton(type: .custom)
            .cz
            .addSuperView(self)
            .title("确定", for: .normal)
            .titleColor(UIColor.cz_hexColor("#108EE9"), for: .normal)
            .font(UIFont.cz_systemFont(16))
            .build
        
        cancelbutton = UIButton(type: .custom)
            .cz
            .addSuperView(self)
            .title("取消", for: .normal)
            .titleColor(UIColor.cz_hexColor("#999999"), for: .normal)
            .font(UIFont.cz_systemFont(16))
            .build
        
        datePicker = UIDatePicker()
            .cz
            .addSuperView(self)
            .build
        
        dividerView = UIView()
            .cz
            .addSuperView(self)
            .backgroundColor(UIColor.cz_rgbColor(238, 238, 238))
            .build
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        confirmButton.frame = CGRect(x: CZCommon.cz_screenWidth - 60, y: 5, width: 50, height: 40)
        cancelbutton.frame = CGRect(x: 10, y: 5, width: 50, height: 40)
        dividerView.frame = CGRect(x: 0, y: confirmButton.frame.size.height + 5, width: CZCommon.cz_screenWidth, height: 1)
        datePicker.frame = CGRect(x: 0, y: confirmButton.frame.size.height + 10 + dividerView.frame.size.height, width: CZCommon.cz_screenWidth, height: self.frame.size.height - confirmButton.frame.size.height - 10 - dividerView.frame.size.height)
    }

}
