//
//  DashedCircleView.swift
//  Ripple
//
//  Created by Keith Lee on 12/23/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit

class DashedCircleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var color: UIColor!
    var fill: Bool = false
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        shapeLayer.frame = CGRect(x: 0.0, y: 0.0, width: 125.0, height: 125.0)
        layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        layer.addSublayer(shapeLayer)
        if fill {
            shapeLayer.strokeColor = UIColor.clear.cgColor
            shapeLayer.fillColor = color?.cgColor
            let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
            fillColorAnimation.duration = 0.3;
            fillColorAnimation.fromValue = UIColor.clear.cgColor
            fillColorAnimation.toValue = color?.cgColor
            shapeLayer.add(fillColorAnimation, forKey: "fillColor")
        } else {
            shapeLayer.fillColor = nil
            shapeLayer.strokeColor = color?.cgColor ?? UIColor.black.cgColor
            let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
            fillColorAnimation.duration = 0.3;
            fillColorAnimation.fromValue = shapeLayer.fillColor
            fillColorAnimation.toValue = nil
            shapeLayer.add(fillColorAnimation, forKey: "fillColor")
        }
        
        let arcCenter = CGPoint(x: 62.5, y: 62.5)
        let radius = CGFloat(40.0)
        let startAngle = CGFloat(0.0)
        let endAngle = CGFloat(2*M_PI)
        let clockwise = false
        
        let openCirclePath = UIBezierPath(arcCenter: arcCenter,
                                          radius: radius,
                                          startAngle: startAngle,
                                          endAngle: endAngle,
                                          clockwise: clockwise)
        shapeLayer.lineDashPattern = [24]
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.lineWidth = 1.5
        shapeLayer.path = openCirclePath.cgPath
        
    }

}
