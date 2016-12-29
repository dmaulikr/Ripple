//
//  CGColorExtensions.swift
//  Ripple
//
//  Created by Keith Lee on 12/28/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import Foundation

extension CGColor {
    var coreImageColor: CIColor {
        return CIColor(cgColor: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
    
    public func rippleGetColor() -> String {
        switch Float(self.components.red) {
        case Float(68)/Float(255):
            return "rippleNight"
        case Float(245)/Float(255):
            return "rippleGrey"
        case Float(107)/Float(255):
            return "rippleGreen"
        case Float(240)/Float(255):
            return "rippleRed"
        case Float(97)/Float(255):
            return "rippleBlue"
        case Float(254)/Float(255):
            return "rippleBeige"
        default:
            return ""
        }
    }
}
