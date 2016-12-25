//
//  ViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/19/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit

public let nightThemeKey = "nightTheme"
public let circleColorKey = "circleColor"
public let nightThemeChangedNotificationId = "com.KeithLee.nightThemeChanged"
public let circleColorChangedNotificationId = "com.KeithLee.circleColorChanged"

open class RippleViewController: UIViewController {
    
    open var circleView = UIView(frame: CGRect.zero)
    open var dotView = UIView(frame: CGRect.zero)
    open var circleSize: CGFloat = 55
    open var dotSize: CGFloat = 6
    open var backgroundColor: UIColor?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor ?? UIColor.rippleGrey
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Needs to be in appear for widget bounds to be accurate
        configureView()
    }
    
    func configureView() {
        guard !self.view.subviews.contains(self.circleView) else {
            return
        }
        let color = UserDefaults.ripple?.colorForKey(key: circleColorKey) ?? UIColor.rippleGreen
        
        self.circleView.frame = CGRect(x: view.bounds.width/2 - circleSize/2, y: view.bounds.height/2 - circleSize/2, width: circleSize, height: circleSize)
        self.circleView.bounds = CGRect(x: 0, y: 0, width: circleSize, height: circleSize)
        self.circleView.layer.cornerRadius = circleSize/2
        self.circleView.layer.borderColor = color.cgColor
        self.circleView.layer.borderWidth = 1
        addCenterConstraints(centerView: self.circleView)
        
        self.dotView.frame = CGRect(x: view.bounds.width/2 - dotSize/2, y: view.bounds.height/2 - dotSize/2, width: dotSize, height: dotSize)
        self.dotView.layer.cornerRadius = dotSize/2
        self.dotView.backgroundColor = color
        self.dotView.alpha = 0.7
        self.dotView.isHidden = true
        addCenterConstraints(centerView: self.dotView)
        start()
    }
    
    func addCenterConstraints(centerView: UIView) {
        self.view.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        let centerXContraint = NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerYContraint = NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let widthContraint = NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: centerView.bounds.width)
        let heightConstraint = NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: centerView.bounds.width)
        
        NSLayoutConstraint.activate([centerXContraint, centerYContraint, widthContraint, heightConstraint])
    }
    
    func start() {
        UIView.animate(withDuration: 4, delay: 0, options: [], animations: {
            self.circleView.transform = self.circleView.transform.scaledBy(x: 5, y: 5)
        }, completion: { _ in
            self.dotView.isHidden = false
            self.shrinkCircle()
        })
    }
    
    func shrinkCircle() {
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideDotView), userInfo: nil, repeats: false)
        UIView.animate(withDuration: 5, delay: 1.5, options: [], animations: {
            self.circleView.transform = self.circleView.transform.scaledBy(x: 1/5, y: 1/5)
        }, completion: { _ in
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.start), userInfo: nil, repeats: false)
        })
    }
    
    func hideDotView() {
        self.dotView.isHidden = true
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

