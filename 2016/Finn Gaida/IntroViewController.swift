//
//  IntroViewController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 25.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import AVFoundation

class IntroViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    var delegate: MasterViewController?
    var textLabel:UILabel?
    var speaking:Bool = false
    let synthesizer = AVSpeechSynthesizer()
    let text = "To my WWDC 2016 scholarship application. I chose to build a portfolio app, giving you an overview of my work and my history.\n\nWhen you enter the app you'll be prompted with a vertical timeline, all of the entries are Live Photos that you can also peek and pop using 3D Touch. (Not on a 6s? Long press on older devices to peek anyways!)\n\nIn the top left you'll find the option to add my digital business card to your wallet and in the top right you'll find a button to show my location on a map and how far I'd travel to attend this year's WWDC.\n\nNow enough of the words, let's dive right in!"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        let black = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 40))
        black.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.view.addSubview(black)
        
        let img = UIImageView(frame: self.view.frame)
        img.image = UIImage(named: "bg")
        self.view.addSubview(img)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        blur.frame = self.view.frame
        self.view.addSubview(blur)
        
        let title = UILabel(frame: CGRectMake(20, 35, self.view.frame.width - 40, 50))
        title.textAlignment = .Center
        title.font = UIFont.systemFontOfSize(40)
        title.text = "Welcome!"
        self.view.addSubview(title)
        
        let speak = UIButton(frame: CGRectMake(self.view.frame.width - 60, 40, 50, 50))
        speak.setImage(UIImage(named: "speaker"), forState: .Normal)
        speak.addTarget(self, action: #selector(IntroViewController.speak), forControlEvents: .TouchUpInside)
        self.view.addSubview(speak)
        
        textLabel = UILabel(frame: CGRectMake(30, title.frame.origin.y + title.frame.height + 15, self.view.frame.width - 60, self.view.frame.height - (title.frame.origin.y + title.frame.height) - 120))
        textLabel?.textAlignment = .Left
        textLabel?.numberOfLines = 0
        textLabel?.font = UIFont.systemFontOfSize(18)
        textLabel?.text = text
        self.view.addSubview(textLabel!)
        
        let loadingTitle = UILabel(frame: CGRectMake(50, self.view.frame.height - 80, self.view.frame.width - 100, 80))
        loadingTitle.textAlignment = .Center
        loadingTitle.font = UIFont.systemFontOfSize(15)
        loadingTitle.textColor = .blackColor()
        loadingTitle.text = "Loading content..."
        self.view.addSubview(loadingTitle)
        
        let vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blur.effect as! UIBlurEffect))
        vibrancy.frame = CGRectMake(50, self.view.frame.height - 80, self.view.frame.width - 100, 80)
        self.view.addSubview(vibrancy)
        
        let go = UIButton(frame: CGRectMake(0, 200, vibrancy.frame.width, 50))
        go.layer.masksToBounds = true
        go.layer.cornerRadius = go.frame.height / 2
        go.backgroundColor = .whiteColor()
        go.addTarget(self, action: #selector(IntroViewController.go), forControlEvents: .TouchUpInside)
        vibrancy.contentView.addSubview(go)
        
        let buttonTitle = UILabel(frame: CGRectMake(50, self.view.frame.height + 100, self.view.frame.width - 100, 50))
        buttonTitle.textAlignment = .Center
        buttonTitle.font = UIFont.systemFontOfSize(30)
        buttonTitle.textColor = .whiteColor()
        buttonTitle.text = "Lets go!"
        self.view.addSubview(buttonTitle)
        
        NSNotificationCenter.defaultCenter().addObserverForName("saved", object: nil, queue: NSOperationQueue.currentQueue()) { (n) in
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                loadingTitle.alpha = 0
                go.frame = CGRectMake(0, 0, vibrancy.frame.width, 50)
                buttonTitle.frame = CGRectMake(20, self.view.frame.height - 80, self.view.frame.width - 40, 50)
            }, completion: nil)
        }
    }
    
    func speak() {
        if !speaking {
            speaking = true
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.53
            synthesizer.delegate = self
            synthesizer.speakUtterance(utterance)
        } else {
            synthesizer.stopSpeakingAtBoundary(.Word)
            textLabel?.text = text
            speaking = false
        }
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: characterRange)
        textLabel?.attributedText = mutableAttributedString
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        textLabel?.attributedText = NSAttributedString(string: utterance.speechString)
        speaking = false
    }
    
    func go() {
        self.delegate?.scrollView.subviews.forEach { $0.removeFromSuperview() }
        self.delegate?.layoutViews()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
