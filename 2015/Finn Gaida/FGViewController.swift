//
//  ViewController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 17.04.15.
//  Copyright (c) 2015 Finn Gaida. All rights reserved.
//

import UIKit
import StoreKit

class FGViewController: UIViewController, UIScrollViewDelegate, SKStoreProductViewControllerDelegate {
    
    let titles = ["Events", "Apps", "Education", "Interests"]
    let bgs = ["Flower.jpg", "Calliandra.jpg", "Fir.jpg", "Spider.jpg", "Sunset.jpg"]
    let scrollView = UIScrollView()
    var animatingStory:Bool = false
    var showingStories:Int = 0
    var bg:SCImagePanViewController = SCImagePanViewController(motionManager: CMMotionManager())
    
    // for animating the button
    var buttonFrameCache = CGRectZero
    
    override func viewDidLoad() {
        
        // setup launch animation
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "darkmode")
        var darkmode = NSUserDefaults.standardUserDefaults().boolForKey("darkmode")
        
        // set constants
        let profilePicWidth:CGFloat = 45
        let nameLabelWidth:CGFloat = self.view.frame.width-200
        let titleLabelWidth:CGFloat = self.view.frame.width-100
        
        // scrollview setup
        self.scrollView.backgroundColor = UIColor.clearColor()

        // add motion sentitive slider in bg
        bg.view.frame = self.view.frame
        bg.view.tag = 0
        self.addChildViewController(bg)
        self.view.addSubview(bg.view)
        NSRunLoop.currentRunLoop().addTimer(NSTimer(timeInterval: 10.0, target: self, selector: "updateBG", userInfo: nil, repeats: true), forMode: NSRunLoopCommonModes)
        updateBG()

        
        /*/ start animation
        var profilePic = UIImageView(image: UIImage(named: "profile"))
        profilePic.frame = CGRectMake(self.view.frame.midX-profilePicWidth/2, self.view.frame.midX-profilePicWidth/2, profilePicWidth, profilePicWidth)
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePicWidth/2
        profilePic.layer.borderWidth = profilePicWidth/10
        profilePic.layer.borderColor = (darkmode) ? UIColor.blackColor().CGColor : UIColor.whiteColor().CGColor
        //self.view.addSubview(profilePic)
        
        var name = UILabel(frame: CGRectMake(self.view.frame.midX-nameLabelWidth/2, profilePic.frame.origin.y + profilePic.frame.height + 50, nameLabelWidth, 50))
        name.backgroundColor = UIColor.clearColor()
        name.textColor = (darkmode) ? UIColor(white: 0.9, alpha: 1) : UIColor(white: 0.1, alpha: 1)
        name.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        name.text = "Finn Gaida"
        //self.view.addSubview(name)
        
        var title = UILabel(frame: CGRectMake(self.view.frame.midX-titleLabelWidth/2, name.frame.origin.y + name.frame.height + 50, titleLabelWidth, 10))
        title.backgroundColor = UIColor.clearColor()
        title.textColor = (darkmode) ? UIColor(white: 0.9, alpha: 1) : UIColor(white: 0.1, alpha: 1)
        title.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        title.numberOfLines = 0
        title.text = "WWDC 2015 Scholarship Application"
        self.view.addSubview(title)     */
        
        //scrollView.frame = CGRectMake(self.view.frame.midX, self.view.frame.midY, 0, 0)
        //scrollView.frame = CGRectMake(0, 20, self.view.frame.width, self.view.frame.height)
        //scrollView.contentSize = CGSizeMake(scrollView.frame.width, scrollView.frame.height+1)
        //self.view.addSubview(scrollView)
        
        // testing
        
        // statusbar dark BG
        var statusBarBG = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 80))
        statusBarBG.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        var blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        blurView.frame = CGRectMake(0, 0, statusBarBG.frame.width, statusBarBG.frame.height)
        statusBarBG.addSubview(blurView)
        self.view.addSubview(statusBarBG)
        
        let fga = UILabel(frame: CGRectOffset(statusBarBG.frame, 15, 10))
        fga.backgroundColor = UIColor.clearColor()
        fga.textColor = UIColor.whiteColor()
        fga.textAlignment = NSTextAlignment.Center
        fga.font = UIFont(name: "HelveticaNeue-Light", size: 40)
        fga.text = "Finn        Gaida"
        statusBarBG.addSubview(fga)
        
        let logo = UIImageView(frame: CGRectMake(statusBarBG.frame.width/2-30, 22, 60, 60))
        logo.layer.masksToBounds = true
        logo.layer.cornerRadius = logo.frame.width/2
        logo.layer.borderWidth = 2.0
        logo.layer.borderColor = UIColor.whiteColor().CGColor
        logo.image = UIImage(named: "logo.jpg")
        statusBarBG.addSubview(logo)
        
        // adding the tiles
        let padding:CGFloat = 25
        let buttonWidth:CGFloat = (self.view.frame.width - padding * 4) / 2
        let buttonHeight:CGFloat = buttonWidth
        
        for i in 0...titles.count-1 {
        
            let x:CGFloat = ((i-1) % 2 != 0) ? padding : padding * 3 + buttonWidth
            let y = CGFloat(padding) * (CGFloat(Int((Float(i) + 0.5)/2.0)) * 2 + 1) + CGFloat(buttonWidth) * CGFloat(Int((Float(i) + 0.5)/2.0))
            
            var button = FGCategoryButton(rect: CGRectMake(x, y + 80, buttonWidth, buttonHeight), title: titles[i], delegate: self)
            button.tag = i
            self.view.addSubview(button)
    
            
        }
        
        // show Tutorial on start
        showStory(4)
        
    }
    
    func updateBG() {
        
        if (bg.view.tag < bgs.count) {
            bg.configureWithImage(UIImage(named: bgs[bg.view.tag]))
            bg.view.tag++
        } else {
            bg.view.tag = 0
            bg.configureWithImage(UIImage(named: bgs[bg.view.tag]))
        }
        
    }
    
    func showStory(identifier: Int) {
        
        var story = FGStoryController() // do sth with the id
        self.view.addSubview(story.view)
        self.addChildViewController(story)
        story.showStory(identifier)
        
    }
    
    func showApp(app: FGApp) {
        
        // get id
        var appID:NSString
        switch (app) {
        case .SunUp:
            appID = "648312177"
        case .Brightness:
            appID = "784533845"
        case .FabTap:
            appID = "861902190"
        case .YouthEast:
            appID = "830968649"
        case .apprupt:
            appID = "649762949"
        default: appID = "31415926"
        }
        
        
        // go to appstore
        let appstore = SKStoreProductViewController()
        appstore.delegate = self
        appstore.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:appID], completionBlock: { (result, error) -> Void in
            
            if ((error) != nil) {
                
                println("error showing appstore with \(app)")
                
            } else {
                
                self.presentViewController(appstore, animated: true, completion: { () -> Void in
                    
                })
                
            }
            
            println("AppStore result is \(result)")
            
        })
        
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

