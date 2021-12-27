//
//  CZCountingLabel.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/9/10.
//  数值滚动Label

import UIKit

public class CZCountingLabel: UILabel {
    
    /// 动画时长
    private var animationDuration = 2.0
    
    /// 起始值
    private var startingValue: Float = 0
    
    /// 目的值
    private var destinationValue: Float = 0
    
    /// 进度
    private var progress: TimeInterval = 0
    
    /// 最后更新时间
    private var lastUpdateTime: TimeInterval = 0
    
    /// 总时间
    private var totalTime: TimeInterval = 0
    
    /// 定时器
    private var timer: CADisplayLink?
    
    /// 显示格式
    private var format: String = "%.1f"
    
    private var currentValue: Float {
        if progress >= totalTime { return destinationValue }
        return startingValue + Float(progress / totalTime) * (destinationValue - startingValue)
    }
    
    /// 添加计时器
    private func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(displayLinkAction(timer:)))
        timer?.add(to: .main, forMode: .common)
    }
    
    /// 移除定时器
    private func removeDisplayLink() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 定时器事件
    @objc private func displayLinkAction(timer: CADisplayLink) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdateTime
        lastUpdateTime = now
        if progress >= totalTime {
            removeDisplayLink()
            progress = totalTime
        }
        setTextValue(value: currentValue)
    }
    
    
    /// 更新文本
    /// - Parameters:
    ///   - value: 值
    ///   - format: 显示格式
    private func setTextValue(value: Float) {
        DispatchQueue.main.async { self.text = String(format: self.format, value) }
    }
    
    
    /// 计数
    /// - Parameters:
    ///   - from: 从多少开始
    ///   - to: 到多少结束
    ///   - format: 显示格式
    ///   - duration: 时长
    func count(from: Float, to: Float, format: String = "%.1f", duration: TimeInterval? = nil) {
        self.format = format
        startingValue = from
        destinationValue = to
        removeDisplayLink()
        if (duration == 0.0) { // 无动画
            setTextValue(value: to)
            return
        }
        progress = 0.0
        totalTime = duration ?? animationDuration
        lastUpdateTime = Date.timeIntervalSinceReferenceDate
        addDisplayLink()
    }
    
    /// 从当前值开始计数
    /// - Parameters:
    ///   - to: 到多少结束
    ///   - format: 显示格式
    ///   - duration: 时长
    func countFromCurrent(to: Float, format: String = "%.1f", duration: TimeInterval? = nil) {
        count(from: currentValue, to: to, format: format, duration: duration ?? nil)
    }
    
    deinit {
        removeDisplayLink()
    }
}
