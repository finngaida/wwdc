//
//  CategoryButton.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 18.04.15.
//  Copyright (c) 2015 Finn Gaida. All rights reserved.
//

import UIKit

enum FGApp {
    case SunUp
    case Brightness
    case FabTap
    case PlateCollect
    case YouthEast
    case Kolumbus
    case apprupt
}

class FGCategoryButton: UIControl {
    
    var container = UIView()
    var containerRect = CGRectZero
    var delegate = FGViewController()
    var appDelegate = FGStoryController()
    var isApp:Bool = false
    var app:FGApp = FGApp.SunUp
    var icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(rect: CGRect, title: NSString?, delegate: FGViewController) {
        
        super.init(frame: rect)
        
        self.frame = rect
        let shrinkFactor:CGFloat = 1.0
        self.delegate = delegate
        
        containerRect = CGRectMake(self.frame.width * ((1 - shrinkFactor)/2), self.frame.width * ((1 - shrinkFactor)/2), self.frame.width * shrinkFactor, self.frame.width * shrinkFactor)
        
        var darkmode = NSUserDefaults.standardUserDefaults().boolForKey("darkmode")
        container.frame = containerRect
        container.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        container.layer.masksToBounds = true
        container.layer.cornerRadius = rect.width/6
        container.autoresizesSubviews = true
        var blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        blurView.frame = CGRectMake(0, 0, container.frame.width, container.frame.height)
        container.addSubview(blurView)
        self.addSubview(container)
        
        var iconView = UIImageView(image: UIImage(named: "w\(title!.lowercaseString)"))
        iconView.frame = CGRectMake(container.frame.width * 0.2, container.frame.width * 0.2, container.frame.width * 0.6, container.frame.width * 0.6)
        container.addSubview(iconView)
        
        var titleLabel = UILabel(frame: CGRectMake(10, rect.height, rect.width - 20, rect.height*0.2))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = (darkmode) ? UIColor.whiteColor() : UIColor.blackColor()
        titleLabel.font = UIFont(name: "HelveticaNeue", size: rect.width/8)
        titleLabel.text = title as? String
        titleLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(titleLabel)
        
    }
    
    init(app: FGApp, frame: CGRect) {
        
        super.init(frame: frame)
        self.isApp = true
        self.app = app
        icon = UIImageView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        
        switch (app) {
        case .SunUp:
            icon.image = UIImage(named: "SunUp")
        case .Brightness:
            icon.image = UIImage(named: "Brightness")
        case .FabTap:
            icon.image = UIImage(named: "FabTap")
        case .PlateCollect:
            icon.image = UIImage(named: "PlateCollect")
        case .Kolumbus:
            icon.image = UIImage(named: "Kolumbus")
        case .YouthEast:
            icon.image = UIImage(named: "YouthEast")
        case .apprupt:
            icon.image = UIImage(named: "apprupt")
        }
        
        self.addSubview(icon)
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = self.frame.width/7
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        touchDown(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        touchUp(self)
    }
    
    func touchDown(sender: FGCategoryButton) {
        
        let shrinkFactor:CGFloat = 0.95
        
        // animate button to smaller state
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            
            let newFrame = CGRectMake(self.containerRect.width * ((1 - shrinkFactor) / 2), self.containerRect.height * ((1 - shrinkFactor) / 2), self.frame.width * shrinkFactor, self.frame.height * shrinkFactor)
            sender.container.frame = newFrame
            
            if (self.isApp) {
                var ico = sender.subviews[0] as! UIView
                ico.frame = CGRectMake(ico.frame.origin.x * shrinkFactor, ico.frame.origin.y * shrinkFactor, ico.frame.width * shrinkFactor, ico.frame.width * shrinkFactor)
                self.icon.frame = CGRectMake(self.icon.frame.origin.x + self.icon.frame.width * (1 - shrinkFactor), self.icon.frame.origin.y + self.icon.frame.height * (1 - shrinkFactor), self.icon.frame.width * shrinkFactor, self.icon.frame.width * shrinkFactor)
            } else {
                var ico = sender.subviews[0].subviews[1] as! UIView
                ico.frame = CGRectMake(ico.frame.origin.x * shrinkFactor, ico.frame.origin.y * shrinkFactor, ico.frame.width * shrinkFactor, ico.frame.width * shrinkFactor)
                self.icon.frame = CGRectMake(self.icon.frame.origin.x + self.icon.frame.width * (1 - shrinkFactor), self.icon.frame.origin.y + self.icon.frame.height * (1 - shrinkFactor), self.icon.frame.width * shrinkFactor, self.icon.frame.width * shrinkFactor)
            }
            
            
            }, completion: nil)
        
    }
    
    func touchUp(sender: FGCategoryButton) {
        
        /*let point = (touches.first as! UITouch).locationInView(self as UIView)
        if (CGRectContainsPoint(self.frame, point)) {
        */
            // add action
            if (self.isApp) {
                self.appDelegate.showApp(self.app)
            } else {
                self.delegate.showStory(self.tag)
            }
            
        //}
        
        // animate button to smaller state
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            
            let newFrame = CGRectMake(0, 0, self.containerRect.width, self.containerRect.height)
            sender.container.frame = newFrame
            
            if (self.isApp) {
                let shrinkFactor:CGFloat = 0.95
                var ico = sender.subviews[0] as! UIView
                ico.frame = CGRectMake(ico.frame.origin.x / shrinkFactor, ico.frame.origin.y / shrinkFactor, ico.frame.width / shrinkFactor, ico.frame.width / shrinkFactor)
                
                self.icon.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
            } else {
                let shrinkFactor:CGFloat = 0.95
                var ico = sender.subviews[0].subviews[1] as! UIView
                ico.frame = CGRectMake(ico.frame.origin.x / shrinkFactor, ico.frame.origin.y / shrinkFactor, ico.frame.width / shrinkFactor, ico.frame.width / shrinkFactor)
                
                self.icon.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
            }
            
            }, completion: nil)

    }

}
