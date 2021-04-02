//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZKit where Base: UIDatePicker {
    
    @discardableResult
    func datePickerMode(_ datePickerMode: UIDatePicker.Mode) -> CZKit {
        base.datePickerMode = datePickerMode
        return self
    }
    
    @discardableResult
    func locale(_ locale: Locale?) -> CZKit {
        base.locale = locale
        return self
    }
    
    @discardableResult
    func calendar(_ calendar: Calendar) -> CZKit {
        base.calendar = calendar
        return self
    }
    
    @discardableResult
    func timeZone(_ timeZone: TimeZone?) -> CZKit {
        base.timeZone = timeZone
        return self
    }
    
    @discardableResult
    func date(_ date: Date) -> CZKit {
        base.date = date
        return self
    }
    
    @discardableResult
    func minimumDate(_ minimumDate: Date?) -> CZKit {
        base.minimumDate = minimumDate
        return self
    }
    
    @discardableResult
    func maximumDate(_ maximumDate: Date?) -> CZKit {
        base.maximumDate = maximumDate
        return self
    }
    
    @discardableResult
    func countDownDuration(_ countDownDuration: TimeInterval) -> CZKit {
        base.countDownDuration = countDownDuration
        return self
    }
    
    @discardableResult
    func minuteInterval(_ minuteInterval: Int) -> CZKit {
        base.minuteInterval = minuteInterval
        return self
    }
}
