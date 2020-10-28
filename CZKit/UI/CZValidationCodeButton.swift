//
//  CZValidationCodeButton.swift
//  Random
//
//  Created by yu mingming on 2020/4/7.
//  Copyright © 2020 刘超正. All rights reserved.
//  后台使用时需要在 “AppDelegate” 中定义
//  1.属性 /// 后台任务标识 var backgroundTask: UIBackgroundTaskIdentifier = .invalid
//  2.在applicationDidEnterBackground(_ application: UIApplication)方法中实现
/*  //注册后台任务
    self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
        () -> Void in
        //如果没有调用endBackgroundTask，时间耗尽时应用程序将被终止
        application.endBackgroundTask(self.backgroundTask)
        self.backgroundTask = UIBackgroundTaskIdentifier.invalid
    })
*/
//  3.在applicationDidBecomeActive(_ application: UIApplication)方法中实现
/*
    application.endBackgroundTask(backgroundTask)
    backgroundTask = UIBackgroundTaskIdentifier.invalid
 */

import UIKit

public class CZValidationCodeButton: UIButton {
    
    private var timer: Timer?
    
    /// 倒计时总秒数
    var totalTime: Int = 60 {
        didSet {
            remainTime = totalTime
        }
    }
    
    /// 剩余时间
    private var remainTime : Int = 0
    
    /// 点击的回调
    var tapBlock: ((_ sender: UIButton) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    
    private func initialize() {
        addTarget(self, action: #selector(getCode), for: .touchUpInside)
        
    }
    
    @objc func getCode(sender: UIButton) {
        if tapBlock != nil  {
            tapBlock?(sender)
        }
        startTimer()
    }
    
    @objc func timerAction() {
        if remainTime == 0 {
            setTitle("获取验证码", for: .normal)
            removeTimer()
            remainTime = totalTime
            isEnabled = true
        } else {
            remainTime -= 1
            setTitle("\(remainTime)s", for: .normal)
            isEnabled = false
        }
    }
    
    /// 开启计时器
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    /// 删除计时器
    func removeTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    deinit {
        removeTimer()
    }
}

