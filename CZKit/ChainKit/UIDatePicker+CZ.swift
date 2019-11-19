//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//

public extension CZ where Base: UIDatePicker {
    
    @discardableResult
    func datePickerMode(_ datePickerMode: UIDatePicker.Mode) -> CZ {
        base.datePickerMode = datePickerMode
        return self
    }
    
    @discardableResult
    func locale(_ locale: Locale?) -> CZ {
        base.locale = locale
        return self
    }
    
    @discardableResult
    func calendar(_ calendar: Calendar) -> CZ {
        base.calendar = calendar
        return self
    }
    
    @discardableResult
    func timeZone(_ timeZone: TimeZone?) -> CZ {
        base.timeZone = timeZone
        return self
    }
    
    @discardableResult
    func date(_ date: Date) -> CZ {
        base.date = date
        return self
    }
    
    @discardableResult
    func minimumDate(_ minimumDate: Date?) -> CZ {
        base.minimumDate = minimumDate
        return self
    }
    
    @discardableResult
    func maximumDate(_ maximumDate: Date?) -> CZ {
        base.maximumDate = maximumDate
        return self
    }
    
    @discardableResult
    func countDownDuration(_ countDownDuration: TimeInterval) -> CZ {
        base.countDownDuration = countDownDuration
        return self
    }
    
    @discardableResult
    func minuteInterval(_ minuteInterval: Int) -> CZ {
        base.minuteInterval = minuteInterval
        return self
    }
}
