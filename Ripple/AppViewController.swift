//
//  AppViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/20/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit
import RippleKit
import Crashlytics

class AppViewController: RippleViewController {
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(nightThemeChangedNotificationId), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCircleColor), name: Notification.Name(circleColorChangedNotificationId), object: nil)
        updateTheme()
        let circleColor = UserDefaults.ripple?.colorForKey(key: circleColorKey) ?? UIColor.rippleGreen
        Answers.logCustomEvent(withName: "Circle color", customAttributes: ["Color": circleColor.rippleGetColor()])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateTheme() {
        if let nightTheme = UserDefaults.ripple?.bool(forKey: nightThemeKey), nightTheme == true {
            self.view.backgroundColor = UIColor.rippleNight
            Answers.logCustomEvent(withName: "Theme color", customAttributes: ["Theme": "rippleNight"])
        } else {
            self.view.backgroundColor = UIColor.rippleGrey
            Answers.logCustomEvent(withName: "Theme color", customAttributes: ["Theme": "rippleGrey"])
        }
    }
    func updateCircleColor() {
        let color = UserDefaults.ripple?.colorForKey(key: circleColorKey) ?? UIColor.rippleGreen
        self.circleView.layer.borderColor = color.cgColor
        self.dotView.backgroundColor = color
    }
}

