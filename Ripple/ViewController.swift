//
//  ViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/19/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var circleView = UIView(frame: CGRect.zero)
    var dotView = UIView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rippleGrey
        configureView()
   }
    
    func configureView() {
        let size: CGFloat = 60
        circleView.frame = CGRect(x: view.bounds.width/2 - size/2, y: view.bounds.height/2 - size/2, width: size, height: size)
        circleView.layer.cornerRadius = size/2
        circleView.layer.borderColor = UIColor.rippleGreen.cgColor
        circleView.layer.borderWidth = 1
        
        let dotSize: CGFloat = 4
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

