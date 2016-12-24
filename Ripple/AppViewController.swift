//
//  AppViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/20/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit
import RippleKit

class AppViewController: RippleViewController {
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(nightThemeChangedNotificationId), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCircleColor), name: Notification.Name(circleColorChangedNotificationId), object: nil)
        updateTheme()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func updateTheme() {
        self.view.backgroundColor = UserDefaults.standard.bool(forKey: nightThemeKey) ? UIColor.rippleNight : UIColor.rippleGrey
    }
    func updateCircleColor() {
        let color = UserDefaults.standard.colorForKey(key: circleColorKey) ?? UIColor.rippleGreen
        self.circleView.layer.borderColor = color.cgColor
        self.dotView.backgroundColor = color
    }
}

