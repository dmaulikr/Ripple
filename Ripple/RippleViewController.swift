//
//  ViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/19/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit

open class RippleViewController: UIViewController {

    var circleView = UIView(frame: CGRect.zero)
    var dotView = UIView(frame: CGRect.zero)
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
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = backgroundColor ?? UIColor.rippleGrey
        circleView.frame = CGRect(x: view.bounds.width/2 - circleSize/2, y: view.bounds.height/2 - circleSize/2, width: circleSize, height: circleSize)
        circleView.layer.cornerRadius = circleSize/2
        circleView.layer.borderColor = UIColor.rippleGreen.cgColor
        circleView.layer.borderWidth = 1
        
        dotView.frame = CGRect(x: view.bounds.width/2 - dotSize/2, y: view.bounds.height/2 - dotSize/2, width: dotSize, height: dotSize)
        dotView.layer.cornerRadius = dotSize/2
        dotView.backgroundColor = UIColor.rippleGreen
        dotView.alpha = 0.7
        view.addSubview(circleView)
        start()
    }
    
    func start() {
        UIView.animate(withDuration: 5, delay: 0, options: [], animations: {
            self.circleView.transform = self.circleView.transform.scaledBy(x: 5, y: 5)
        }, completion: { _ in
            self.view.addSubview(self.dotView)
            self.shrinkCircle()
        })
    }
    
    func shrinkCircle() {
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(removeDotView), userInfo: nil, repeats: false)
        UIView.animate(withDuration: 5, delay: 1.5, options: [], animations: {
            self.circleView.transform = self.circleView.transform.scaledBy(x: 1/5, y: 1/5)
        }, completion: { _ in
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.start), userInfo: nil, repeats: false)
        })
    }
    
    func removeDotView() {
        self.dotView.removeFromSuperview()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

