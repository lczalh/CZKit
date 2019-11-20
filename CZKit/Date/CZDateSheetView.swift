//
//  PopTimeSelectBoxView.swift
//  csomanage
//
//  Created by yu mingming on 2019/9/6.
//  Copyright © 2019 glgs. All rights reserved.
//

import UIKit

class CZDateSheetView: UIView {
    
    public var datePicker: UIDatePicker!
    
    /// 确定
    public var confirmButton: UIButton!
    
    /// 取消
    public var cancelbutton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        confirmButton = UIButton(type: .custom)
            .cz
            .addSuperView(self)
            .title(" 确定 ", for: .normal)
            .titleColor(cz_hexColor("#108EE9"), for: .normal)
            .font(cz_font(16))
            .build
        
        cancelbutton = UIButton(type: .custom)
            .cz
            .addSuperView(self)
            .title(" 取消 ", for: .normal)
            .titleColor(cz_hexColor("#999999"), for: .normal)
            .font(cz_font(16))
            .build
        
        //创建日期选择器
        datePicker = UIDatePicker()
            .cz
            .addSuperView(self)
            .build
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        confirmButton.frame = CGRect(x: cz_screenWidth - 70, y: 10, width: 60, height: 40)
        cancelbutton.frame = CGRect(x: 15, y: 10, width: 60, height: 40)
        datePicker.frame = CGRect(x: 0, y: confirmButton.frame.height + 10, width: cz_screenWidth, height: self.frame.size.height - confirmButton.frame.height + 10)
    }

}
