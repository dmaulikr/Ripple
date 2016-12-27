//
//  HealthManager.swift
//  Ripple
//
//  Created by Keith Lee on 12/26/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import Foundation
import HealthKit

open class HealthManager {
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    public init() {
        
    }
    
    public func authorizeHealthKit(callback: ((_ success: Bool, _ error: Error?) -> Void)?) {
        if #available(iOS 10.0, *), HKHealthStore.isHealthDataAvailable() {
            let hkTypes = Set([HKObjectType.categoryType(forIdentifier: .mindfulSession)!])
            
            healthKitStore.requestAuthorization(toShare: hkTypes, read: nil, completion: { (success, error) in
                if let callback = callback {
                    callback(success, error)
                }
            })
        }
    }
    
    public func saveMeditation(startDate:Date) {
        if #available(iOS 10.0, *), HKHealthStore.isHealthDataAvailable() {
            let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
            let mindfulSample = HKCategorySample(type: mindfulType, value: 0, start: startDate, end: Date())
            healthKitStore.save(mindfulSample) { success, error in
                //Empty
            }
        }
    }
}
