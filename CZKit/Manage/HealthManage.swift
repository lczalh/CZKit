//
//  HealthManage.swift
//  letaoshijie
//
//  Created by udream3 on 2021/12/31.
//

import Foundation
import HealthKit

struct CZHealthManage {
    
    static let healthStore: HKHealthStore = HKHealthStore()
    
    /// 请求健康权限
    static func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void) {
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead, completion: completion)
    }
    
    static func execute(sampleType: HKSampleType, predicate: NSPredicate?, limit: Int, sortDescriptors: [NSSortDescriptor]?, resultsHandler: @escaping (HKSampleQuery, [HKSample]?, Error?) -> Void) {
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: sortDescriptors, resultsHandler: resultsHandler)
        healthStore.execute(sampleQuery)
    }
}
