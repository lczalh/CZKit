//
//  CZArithmeticManage.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/5/7.
//

import Foundation

public struct CZArithmeticManage {
    
    
    /// 将一维数组，分割为二维数组
    /// - Parameters:
    ///   - array: 一维数组
    ///   - eachNumber: 每几个分割为一组
    /// - Returns: 分割后的二维数组
    public static func oneDimensionalArraySplit<T>(array: [T], eachNumber: Int) -> [[T]] {
        // 求余
        let remainder = array.count % eachNumber
        // 求商
        let consult = array.count / eachNumber
        // 计算分割数
        let partitionNumber = consult
        // 存储分割后的数据
        var resultArray: [[T]] = []
        // 分割存储
        for i in 0..<partitionNumber {
            let firstIndex = i * eachNumber
            let subList = Array(array[firstIndex...(firstIndex + eachNumber - 1)])
            resultArray.append(subList)
        }
        // 追加上余下的元素
        if remainder != 0 { resultArray.append(array.suffix(remainder)) }
        return resultArray
    }
    
}
