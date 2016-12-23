//
//  SettingsViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/22/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit

let nightThemeKey = "nightTheme"
let nightThemeChangedNotificationId = "com.KeithLee.nightThemeChanged"

class SettingsViewController: UIViewController {

    @IBOutlet weak var nightThemeLabel: UILabel!
    @IBOutlet weak var nightThemeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: nightThemeKey) {
            nightThemeSwitch.isOn = true
            view.backgroundColor = UIColor.rippleNight
            self.nightThemeLabel.textColor = UIColor.white
        } else {
            nightThemeSwitch.isOn = false
            view.backgroundColor = UIColor.rippleGrey
            self.nightThemeLabel.textColor = UIColor.black
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleNight(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.isOn, forKey: nightThemeKey)
        NotificationCenter.default.post(name: Notification.Name(nightThemeChangedNotificationId), object: nil)
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = sender.isOn ? UIColor.rippleNight : UIColor.rippleGrey
            self.nightThemeLabel.textColor = sender.isOn ? UIColor.white : UIColor.black
        }
    }
}
