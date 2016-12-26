//
//  SettingsViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/22/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit
import RippleKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var nightThemeLabel: UILabel!
    @IBOutlet weak var nightThemeSwitch: UISwitch!
    
    @IBOutlet weak var colorChooser: UIStackView!
    
    @IBOutlet weak var colorView1: DashedCircleView!
    @IBOutlet weak var colorView2: DashedCircleView!
    @IBOutlet weak var colorView3: DashedCircleView!
    @IBOutlet weak var colorView4: DashedCircleView!
    
    var colorViewArray: [DashedCircleView]!
    var colorViewDict = [Int : Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorViewArray = [colorView1, colorView2, colorView3, colorView4]
        colorViewDict = [
            UIColor.rippleGreen.hashValue : 0,
            UIColor.rippleRed.hashValue : 1,
            UIColor.rippleBlue.hashValue : 2,
            UIColor.rippleBeige.hashValue : 3
        ]
        colorViewArray.forEach({ $0.backgroundColor = UIColor.clear })
        
        if let color = UserDefaults.ripple?.colorForKey(key: circleColorKey) {
            guard let index = colorViewDict[color.hashValue], index < colorViewArray.count else {
                return
            }
            colorViewArray[index].fill = true
        } else {
            colorView1.fill = true
        }
        
        colorView1.color = UIColor.rippleGreen
        colorView2.color = UIColor.rippleRed
        colorView3.color = UIColor.rippleBlue
        colorView4.color = UIColor.rippleBeige
        
        if let nightTheme = UserDefaults.ripple?.bool(forKey: nightThemeKey), nightTheme == true {
            nightThemeSwitch.isOn = true
            view.backgroundColor = UIColor.rippleNight
            self.nightThemeLabel.textColor = UIColor.white
        } else {
            nightThemeSwitch.isOn = false
            view.backgroundColor = UIColor.rippleGrey
            self.nightThemeLabel.textColor = UIColor.black
        }
        
        let tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(fillCircle))
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(fillCircle))
        let tapRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(fillCircle))
        let tapRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(fillCircle))
        colorView1.addGestureRecognizer(tapRecognizer1)
        colorView2.addGestureRecognizer(tapRecognizer2)
        colorView3.addGestureRecognizer(tapRecognizer3)
        colorView4.addGestureRecognizer(tapRecognizer4)
    }
    
    func fillCircle(sender: UITapGestureRecognizer) {
        guard let colorView = sender.view as? DashedCircleView, !colorView.fill else {
           return
        }
        colorView.fill = !colorView.fill
        colorView.setNeedsDisplay()
        colorViewArray.forEach({
            if $0 != colorView {
                $0.fill = false
                $0.setNeedsDisplay()
            }
        })
        UserDefaults.ripple?.setColor(color: colorView.color, forKey: circleColorKey)
        NotificationCenter.default.post(name: Notification.Name(circleColorChangedNotificationId), object: nil)
    }
    
    @IBAction func toggleNight(_ sender: UISwitch) {
        UserDefaults.ripple?.set(sender.isOn, forKey: nightThemeKey)
        NotificationCenter.default.post(name: Notification.Name(nightThemeChangedNotificationId), object: nil)
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = sender.isOn ? UIColor.rippleNight : UIColor.rippleGrey
            self.nightThemeLabel.textColor = sender.isOn ? UIColor.white : UIColor.black
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
