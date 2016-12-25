//
//  UserDefaultsExtensions.swift
//  Ripple
//
//  Created by Keith Lee on 12/23/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit
import Foundation

extension UserDefaults {
    
    public func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    public func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
    
    public static let ripple = UserDefaults(suiteName: "group.com.KeithLee.ripple")
    
}
