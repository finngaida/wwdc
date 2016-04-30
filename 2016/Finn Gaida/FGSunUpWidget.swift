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
    var parent: UIScrollView?
    
    init(frame: CGRect, scroll: UIScrollView?) {
        
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
        
        self.parent = scroll
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red: (86.0/255.0), green:(208.0/255.0), blue:(188.0/255.0), alpha: 1.0)
        circle.addTarget(self, action: #selector(FGSunUpWidget.setDarkMode), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(circle)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        indicator.alpha = 1
        self.parent?.scrollEnabled = false
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let point = touches.first!.locationInView(self as UIView)
        
        var angle:Float
        let mid = CGPointMake(self.frame.width/2, self.frame.height/2)
        let calc = FGStuffCalculator()
        
        if (point.x < mid.x && point.y < mid.y) {
            angle = calc.angleForTriangleInScreenQuarter(.TopLeft, toPoint: point, inView: self)
        } else if (point.x > mid.x && point.y < mid.y) {
            angle = calc.angleForTriangleInScreenQuarter(.TopRight, toPoint: point, inView: self)
        }
        else if (point.x < mid.x && point.y > mid.y-1) {
            angle = calc.angleForTriangleInScreenQuarter(.BottomLeft, toPoint: point, inView: self)
        }
        else /*if (point.x > self.mid.x && point.y > self.mid.y)*/ {
            angle = calc.angleForTriangleInScreenQuarter(.BottomRight, toPoint: point, inView: self)
        }
        
        indicator.transform = CGAffineTransformMakeRotation(CGFloat(angle * Float(M_PI) / 180))
        
        var hours = "\(Int(floor(angle/360*12)))"
        var minutes = "\(Int(calc.minutesAtDegree(angle, h24: false)))"
        
        
        if (hours.characters.count < 2) {hours = "0" + hours}
        if (minutes.characters.count < 2) {minutes = "0" + minutes}
        
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
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        indicator.alpha = 0
        self.parent?.scrollEnabled = true
    }
    
}

enum FGScreenQuarter:NSInteger {
    case TopLeft, TopRight, BottomRight, BottomLeft
}

class FGStuffCalculator: NSObject {
    
    func angleForTriangleInScreenQuarter(screenQuarter: FGScreenQuarter, toPoint p: CGPoint, inView: UIView) -> Float {
        
        let m:CGPoint = CGPointMake(inView.frame.size.width/2, inView.frame.size.height/2)
        
        switch (screenQuarter) {
        case .TopLeft:
            
            let oppositeLeg = Float(m.y - p.y)
            let adjacentLeg = Float(m.x - p.x)
            
            let angleRadians = atanf(oppositeLeg / adjacentLeg)
            let angle = (angleRadians / Float(M_PI)) * 180
            
            return angle + 270 // Weil es das vierte Viertel ist.
            
        case .TopRight:
            
            let oppositeLeg = Float(m.y - p.y)
            let adjacentLeg = Float(p.x - m.x)
            
            
            let angleRadians = atanf(oppositeLeg/adjacentLeg)
            let angle = (angleRadians/Float(M_PI))*180
            
            return 90 - angle
            
        case .BottomLeft:
            
            let oppositeLeg = Float(p.y - m.y)
            let adjacentLeg = Float(m.x - p.x)
            
            
            let angleRadians = atanf(oppositeLeg/adjacentLeg)
            let angle = (angleRadians/Float(M_PI))*180
            
            return 90 - angle + 180 // Weil es das dritte Viertel ist.
            
        case .BottomRight:
            
            let oppositeLeg = Float(p.y - m.y)
            let adjacentLeg = Float(p.x - m.x)
            
            
            let angleRadians = atanf(oppositeLeg/adjacentLeg)
            let angle = (angleRadians/Float(M_PI))*180
            
            return angle + 90 // Weil es der zweite Viertel ist.
            
        }
        
    }
    
    func minutesAtDegree(degree:Float, h24:Bool) -> Float {
        if (h24) {
            if (degree/15 < 1) {return (degree - 0  * 15)/15 * 60;}
            else if (degree/15 < 2)  {return (degree -  1  * 15)/15 * 60;}
            else if (degree/15 < 3)  {return (degree -  2  * 15)/15 * 60;}
            else if (degree/15 < 4)  {return (degree -  3  * 15)/15 * 60;}
            else if (degree/15 < 5)  {return (degree -  4  * 15)/15 * 60;}
            else if (degree/15 < 6)  {return (degree -  5  * 15)/15 * 60;}
            else if (degree/15 < 7)  {return (degree -  6  * 15)/15 * 60;}
            else if (degree/15 < 8)  {return (degree -  7  * 15)/15 * 60;}
            else if (degree/15 < 9)  {return (degree -  8  * 15)/15 * 60;}
            else if (degree/15 < 10) {return (degree -  9  * 15)/15 * 60;}
            else if (degree/15 < 11) {return (degree - 10  * 15)/15 * 60;}
            else if (degree/15 < 12) {return (degree - 11  * 15)/15 * 60;}
            else if (degree/15 < 13) {return (degree - 12  * 15)/15 * 60;}
            else if (degree/15 < 14) {return (degree - 13  * 15)/15 * 60;}
            else if (degree/15 < 15) {return (degree - 14  * 15)/15 * 60;}
            else if (degree/15 < 16) {return (degree - 15  * 15)/15 * 60;}
            else if (degree/15 < 17) {return (degree - 16  * 15)/15 * 60;}
            else if (degree/15 < 18) {return (degree - 17  * 15)/15 * 60;}
            else if (degree/15 < 19) {return (degree - 18  * 15)/15 * 60;}
            else if (degree/15 < 20) {return (degree - 19  * 15)/15 * 60;}
            else if (degree/15 < 21) {return (degree - 20  * 15)/15 * 60;}
            else if (degree/15 < 22) {return (degree - 21  * 15)/15 * 60;}
            else if (degree/15 < 23) {return (degree - 22  * 15)/15 * 60;}
            else if (degree/15 < 24) {return (degree - 23  * 15)/15 * 60;}
                
            else {return 0;}
        } else {
            if (degree/30 < 1) {return (degree - 0  * 30)/30 * 60;}
            else if (degree/30 < 2)  {return (degree -  1  * 30)/30 * 60;}
            else if (degree/30 < 3)  {return (degree -  2  * 30)/30 * 60;}
            else if (degree/30 < 4)  {return (degree -  3  * 30)/30 * 60;}
            else if (degree/30 < 5)  {return (degree -  4  * 30)/30 * 60;}
            else if (degree/30 < 6)  {return (degree -  5  * 30)/30 * 60;}
            else if (degree/30 < 7)  {return (degree -  6  * 30)/30 * 60;}
            else if (degree/30 < 8)  {return (degree -  7  * 30)/30 * 60;}
            else if (degree/30 < 9)  {return (degree -  8  * 30)/30 * 60;}
            else if (degree/30 < 10) {return (degree -  9  * 30)/30 * 60;}
            else if (degree/30 < 11) {return (degree - 10  * 30)/30 * 60;}
            else if (degree/30 < 12) {return (degree - 11  * 30)/30 * 60;}
                
            else {return 0;}
        }
    }
    
}
