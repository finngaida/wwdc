//
//  FGSunUpWidget.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 24.04.15.
//  Copyright (c) 2015 Finn Gaida. All rights reserved.
//

import UIKit

class FGSunUpWidget: UIView {
    
    var circle = UIButton()
    var darkMode:Bool = false
    var time = UILabel()
    var indicator = UIView()
    var delegate = FGStoryController()
    
    override init(frame: CGRect) {
        
        circle = UIButton(frame: CGRectMake((frame.width - frame.height * 0.75) / 2, (frame.height - frame.height * 0.75) / 2, frame.height * 0.75, frame.height * 0.75))
        circle.layer.masksToBounds = true
        circle.layer.cornerRadius = circle.frame.width/2
        circle.backgroundColor = UIColor(red: (208.0/255.0), green:(86.0/255.0), blue:(106.0/255.0), alpha: 1.0)
        
        time = UILabel(frame: CGRectMake(0, 0, circle.frame.width, circle.frame.height))
        time.backgroundColor = UIColor.clearColor()
        time.textColor = UIColor.whiteColor()
        time.textAlignment = NSTextAlignment.Center
        time.font = UIFont(name: "HelveticaNeue-Light", size: 40)
        time.text = "06:00"
        circle.addSubview(time)
        
        indicator = UIView(frame: CGRectMake(0, 0, circle.frame.width, circle.frame.height))
        indicator.backgroundColor = UIColor.clearColor()
        indicator.alpha = 0
        let dot = UIView(frame: CGRectMake(indicator.frame.width/2-5, 0, 10, 10))
        dot.layer.masksToBounds = true
        dot.layer.cornerRadius = dot.frame.width/2
        dot.backgroundColor = UIColor.whiteColor()
        indicator.addSubview(dot)
        circle.addSubview(indicator)
        
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red: (86.0/255.0), green:(208.0/255.0), blue:(188.0/255.0), alpha: 1.0)
        circle.addTarget(self, action: "setDarkMode", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(circle)
  
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        indicator.alpha = 1
        self.delegate.scrollView.scrollEnabled = false
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let point = (touches.first as! UITouch).locationInView(self as UIView)
        
        var angle:CGFloat
        let mid = CGPointMake(self.frame.width/2, self.frame.height/2)
        let calc = FGStuffCalculator()
        
        if (point.x < mid.x && point.y < mid.y) {
            angle = calc.angleForTriangleInScreenQuarter(FGScreenQuarter.TopLeft, toPoint: point, inView: self)
        } else if (point.x > mid.x && point.y < mid.y) {
            angle = calc.angleForTriangleInScreenQuarter(FGScreenQuarter.TopRight, toPoint: point, inView: self)
        }
        else if (point.x < mid.x && point.y > mid.y-1) {
            angle = calc.angleForTriangleInScreenQuarter(FGScreenQuarter.BottomLeft, toPoint: point, inView: self)
        }
        else /*if (point.x > self.mid.x && point.y > self.mid.y)*/ {
            angle = calc.angleForTriangleInScreenQuarter(FGScreenQuarter.BottomRight, toPoint: point, inView: self)
        }
        
        indicator.transform = CGAffineTransformMakeRotation(FGStuffCalculator.degreesToRadians(angle))
        
        
        var hours = NSString(format: "%.f", FGStuffCalculator.unroundedFloatWithoutDecimalPlace(angle/360*12))
        var minutes = NSString(format: "%.f", FGStuffCalculator.minutesAtDegree(angle, h24: false))
        
        
        if (hours.length < 2) {hours = "0".stringByAppendingString(hours as String)}
        if (minutes.length < 2) {minutes = "0".stringByAppendingString(minutes as String)}
        
        time.text = "\(hours):\(minutes)"
        
    }
    
    func setDarkMode() {
        
        if (darkMode) {
            
            UIView.animateWithDuration(0.75, animations: { () -> Void in
                
                self.circle.backgroundColor = UIColor(red: (208.0/255.0), green:(86.0/255.0), blue:(106.0/255.0), alpha: 1.0)
                self.backgroundColor = UIColor(red: (86.0/255.0), green:(208.0/255.0), blue:(188.0/255.0), alpha: 1.0)
                
            })
            
            darkMode = !darkMode
            
        } else {
            
            UIView.animateWithDuration(0.75, animations: { () -> Void in
                
                self.circle.backgroundColor = UIColor.blackColor()
                self.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.2, alpha: 1.0)
                
            })
            
            darkMode = !darkMode
            
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        indicator.alpha = 0
        self.delegate.scrollView.scrollEnabled = true
    }
    
}
