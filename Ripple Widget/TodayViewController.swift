//
//  TodayViewController.swift
//  Ripple Widget
//
//  Created by Keith Lee on 12/19/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit
import NotificationCenter
import RippleKit

class TodayViewController: RippleViewController, NCWidgetProviding {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.circleSize = 20
        self.dotSize = 4
        self.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
