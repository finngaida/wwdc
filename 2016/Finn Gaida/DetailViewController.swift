//
//  DetailViewController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 21.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var index:Int = 0
    var label:UILabel!
    var speaking:Bool = false
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.tintColor = .whiteColor()
        
        let speaker = UIBarButtonItem(image: UIImage(named: "speaker"), style: .Plain, target: self, action: #selector(DetailViewController.speak))
        self.navigationItem.rightBarButtonItem = speaker
        
        // bg
        self.bg.frame = self.view.frame
        let img = UIImageView(frame: self.bg.frame)
        img.image = UIImage(named: "bg")
        self.bg.addSubview(img)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        blur.frame = self.bg.frame
        self.bg.addSubview(blur)
        
        let text = hardTexts[index]
        let font = UIFont.systemFontOfSize(17)
        let margin:CGFloat = 20
        
        let size = (text as NSString).boundingRectWithSize(CGSizeMake(self.scrollView.frame.width - margin * 3, CGFloat.max), options: [NSStringDrawingOptions.UsesLineFragmentOrigin], attributes: [NSFontAttributeName:font], context: nil)
        
        label = UILabel(frame: CGRectMake(margin, margin, self.view.frame.width - (margin * 2), ceil(size.height) * 1.5))
        label.numberOfLines = 0
        label.textAlignment = .Justified
        label.text = text
        self.scrollView.addSubview(label)
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width, label.frame.origin.y + label.frame.height + margin * 2)
        
        if index == 0  {
            let widget = KeyboardWidget(frame: CGRectMake(margin, label.frame.height + margin * 2, self.view.frame.width - margin * 2, self.view.frame.width * 0.8), vc: self)
            self.scrollView.addSubview(widget)
            
            let store = AppStoreWidget(frame: CGRectMake(margin, widget.frame.origin.y + widget.frame.height + margin, self.view.frame.width - margin * 2, 100), index: 0)
            self.scrollView.addSubview(store)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, store.frame.origin.y + store.frame.height + margin * 2)
        }
        
        if index == 1 {
            let widget = AppBoxWidget(frame: CGRectMake(margin, label.frame.height + margin * 2, self.view.frame.width - margin * 2, self.view.frame.width / 2))
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 2 {
            let widget = WWDCWidget(frame: CGRectMake(margin, label.frame.height + margin * 2, self.view.frame.width - margin * 2, self.view.frame.width / 2))
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 3 {
            let widget = AppStoreWidget(frame: CGRectMake(margin, label.frame.origin.y + label.frame.height + margin, self.view.frame.width - margin * 2, 100), index: 1)
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 4 {
            let widget = ImageWidget(frame: CGRectMake(margin, label.frame.origin.y + label.frame.height + margin, self.view.frame.width - margin * 2, 100), images: ["report1.png", "report2.png"], parent: self)
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 5 {
            let widget1 = AppStoreWidget(frame: CGRectMake(margin, label.frame.origin.y + label.frame.height + margin, self.view.frame.width - margin * 2, 100), index: 2)
            let widget = AppStoreWidget(frame: CGRectMake(margin, widget1.frame.origin.y + widget1.frame.height + margin, self.view.frame.width - margin * 2, 100), index: 3)
            self.scrollView.addSubview(widget1)
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 6 {
            let widget = FGSunUpWidget(frame: CGRectMake(margin, label.frame.height + margin * 2, self.view.frame.width - margin * 2, self.view.frame.width / 2), scroll: self.scrollView)
            self.scrollView.addSubview(widget)
            
            let store = AppStoreWidget(frame: CGRectMake(margin, widget.frame.origin.y + widget.frame.height + margin, self.view.frame.width - margin * 2, 100), index: 4)
            self.scrollView.addSubview(store)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, store.frame.origin.y + store.frame.height + margin * 2)
        }
        
        if index == 7 {
            let widget1 = SafariWidget(frame: CGRectMake(margin, label.frame.origin.y + label.frame.height + margin, self.view.frame.width - margin * 2, 100), url: NSURL(string: "https://github.com/finngaida/PlateCollect")!, vc: self)
            let widget = SafariWidget(frame: CGRectMake(margin, widget1.frame.origin.y + widget1.frame.height + margin, self.view.frame.width - margin * 2, 100), url: NSURL(string: "https://github.com/stocc/Kolumbus-iOS")!, vc: self)
            self.scrollView.addSubview(widget1)
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 9 {
            let widget = SafariWidget(frame: CGRectMake(margin, label.frame.origin.y + label.frame.height + margin, self.view.frame.width - margin * 2, 100), url: NSURL(string: "https://www.youtube.com/watch?v=oTthr9u4AE0")!, vc: self)
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
        
        if index == 10 {
            let widget = ImageWidget(frame: CGRectMake(margin, label.frame.origin.y + label.frame.height + margin, self.view.frame.width - margin * 2, 100), images: ["pic1.jpg", "pic2.jpg", "pic3.jpg", "pic4.jpg"], parent: self)
            self.scrollView.addSubview(widget)
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.width, widget.frame.origin.y + widget.frame.height + margin * 2)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if speaking {
            speak()
        }
    }
    
    func speak() {
        if !speaking {
            speaking = true
            let utterance = AVSpeechUtterance(string: hardTexts[self.index])
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.delegate = self
            synthesizer.speakUtterance(utterance)
        } else {
            synthesizer.stopSpeakingAtBoundary(.Word)
            label.text = hardTexts[index]
            speaking = false
        }
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: characterRange)
        label.attributedText = mutableAttributedString
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        label.attributedText = NSAttributedString(string: utterance.speechString)
        speaking = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

let hardTexts:[String] =
        /* Keyboard */
    ["I found a post on reddit where someone requested a keyboard that would enable him to swap out keys for other letters and as I didn't have any project at the time I tried to complete that request, partly to check out keyboard extensions.\nAt the bottom of this text there is a demo of the keyboard in action. That is the default layout, but if you press the button below you'll see that the keys can be changed fairly easily.\n\nWorking on this app was interesting, because I learnt a lot about keyboard extensions, how they work and especially how they communicate with the containing app. Additionally I created my first custom UICollectionView layout that's used in production, so that's another positive takeaway.\n\nThe app was approved hours ago at the time of me writing this text, so below you find a widget to the app on the AppStore:",
        /* First Client */
    "In November of 2015 I founded my own company called \"Finn Gaida Apps\". This might sound like a big deal, but basically it's just a necessary step by the german government, if you want to be a freelancer.\nThe following month I got contacted by my first customer and started working on the first client app.\nAs school is getting more and more involving I couldn't work much as a freelancer recently, but I would definitely make use of all the great people at WWDC to continue working as a freelancer.\n\nAttached you find a small demo of what I built for the app, it's the background for a survey sheet.",
        /* WWDC 2015 */
    "When I was busy building the portfolio app last year I didn't even dream of how awesome WWDC would be. I have never met so many clever people in such a short time in one location.\nSimply the feeling of meeting people that I can talk to about coding is the best in the world.\nWhen I had to return home again it was like I was an alien, everybody looked at me strangely when I was reporting some of the new features iOS 9 introduced.\nThe time I spent in the labs, speaking to Apple employees about Swift 2.0 and other new features got me more involved in Swift programming and meeting many other iOS developers at the after parties was like a springboard (pun totally intended 😉) to summer internships.\n\nI would do everything to get to visit San Francisco during WWDC once again and this scholarship is one of the best opportunities, so I spent hundreds of hours building this app and the apps mentioned in this app to achieve this goal.\n\nBelow is a widget of one of the features from my app last year, tilt your device to pan this picture I took on holiday.",
        /* Opera */
    "My school requests all students to do an internship every three years, and so for my second one I set out to find a company where I could put my coding skills to work.\nI found the Hamburg-based advertising company \"apprupt\" that has recently been acquired by Opera Mediaworks.\nWhen interning there for a total of 5 weeks my tasks included overhauling their showroom app for the new iOS 7 design and later on implementing a feature to favorite and download chosen campaigns.\n\nWhen working at Opera I learned a lot about working in teams, using git and the workflow of QA. My code since then is more readable and my commits are sorted by features.\nI also learned a lot about the caching mechanisms of UIWebView and how to spoof JavaScript websites into thinking content would be available remotely, but actually loading local assets.\n\nHere you can find the app I worked on in the AppStore:",
        /* School */
    "The very day I'm writing this text I have written the second of a total 5 exams in my Abitur - the german equivalent to graduation. So by now I have spent 13 years in school and 3 of those with a focus on sciences.\n\nWhen school is over I'm looking to study Computer Science in University, but I'd also love to intern at some tech companies in Silicon Valley.\n\nThese are my latest reports.",
        /* Side projects */
    "Since I put my first app on the AppStore I couldn't stop starting new projects that would either be fun to create, really help at something or both!\n\nI have also looked into several other programming fields, such as web development, backend development, Android app development, coding on Raspberry Pi and several others, but I've always found my way back to iOS.\nMaybe it's because where I started, but I guess part of that is also, that Xcode is a really polished app and that the technologies iOS and more recently watchOS, tvOS and macOS (?) have to offer are easy to implement yet functional.\n\nEven though I might drift off into more low-level stuff in college I will probably always come back to the point where someone I know randomly comes at me, completely enthusiastic about an app idea they had and trying to convince me of implementing their designs.\n\nBelow you can find two of my side projects on the AppStore, one utility app for iOS <7 and one simple game.",
        /* SunUp */
    "SunUp is my first app on the AppStore and probably also the one I spent the most time on. It's an alarm app, aiming to minimize the time spent in the app while maintaining an awesome design.\n\nAs it was my first app, I learned a lot of things while programming it, for example working with notifications, creating custom UIViews and UIControls, playing sounds through AVFoundation and managing in-app purchases.\n\nMore recently I also implemented UIKit dynamics, responsive notifications and an watchOS app.\nThis is basically my playground for trying out awesome new technologies and putting them to work in a creative way.\nOne example of that is the SSH hook in the app where I once set up my Raspberry Pi, so that once my alarm went off in the morning, SunUp sent a notice to my mini-computer, which would in turn switch my room light that I hooked up on and off, making me wake up rapidly.\n\nI added a widget to explore the SunUp interface, just drag around the center to set a time, then tap the middle to activate \"Night Mode\". You can also find SunUp on the AppStore below.",
        /* Hackathons */
    "Since I completed the work on my first app I couldn't stop coding. There was one thing I was missing though, which is people I could talk to about the stuff I made and that would understand the problems I tried to solve in the process.\n\nSo I went online and found a thing such as hackathons. At the time I had no idea what that was, but I signed up anyways for the next one in Berlin.\nWhen the hackathon started (in 2013) I had already made two friends that I'm still in regular contact with now and we built an app called \"PlateCollect\" that would enable users to find so-called \"Stolpersteine\", small golden plates embedded into the ground in front of the residences of people killed in the holocaust, all over Berlin.\n\nAs a result out team got invited to several other events, amongst which was the ICT in Vilnius.\n\nSince that first hackathon I went to four others and had loads of fun while meeting other hackers.\n\nI linked two of the projects I built at hackathons here:",
        /* First App */
    "As soon as my MacBook came in the mail, I took it out of the box, did the setup and downloaded Xcode.\nI heard a lot of great stuff about in online beforehand and wanted to try it out and as soon as my first app (simply a blank screen printing \"Hello World!\" to the Console) I was hooked.\n\nTrying to find out more about how apps and iOS itself works I taught myself Objective-C from online classes, like the one from Stanford on iTunes U, great tutorials from Ray Wenderlich, try and error plus explanations and some hints from stack overflow and so on.\n\nEver since I'm fascinated by how easy it is to turn an idea into a product and I'm glad about it every time I'm at a hackathon, in a hurry to finish something we just invented.\n\nBy the way, the first app I made, that really did something was called \"Lumos!\" and resembled a glowing wand in honor of the Harry Potter books, but turning on the iPhone flashlight when shaking the device.",
        /* Jailbreaking */
    "Before starting with any app development I got into the world of jailbreaking. Now it remains unknown what Apple thinks of the Jailbreak, but I think it is a great opportunity to test awesome features on my own risk and it has an awesome community.\n\nJust recently I started developing the so-called \"tweaks\" myself, small bits of Objective-C code, packaged into a Linux-style package and installed via Cydia.\nIt's not well documented, but digging through some of the private frameworks of SpringBoard and other apps not only is a lot of fun, but also teaches a bit of how iOS works under the hood and I try to apply some of the principles I learned through Jailbreak development in my own apps.\nOf course I'm aware that jailbreaking also means giving up on the latest security updates and potential vulnerabilities, but I take the responsibility for that.\n\nBelow I linked a video to one of the tweaks I made - \"KeyHook\" - that let's jailbroken iPad users navigate their home screen with the arrow keys of a bluetooth keyboard.",
        /* Youth */
    "Writing this seems kind of wrong. I'm 18 years old, well turning 19 in the week after WWDC, and I'm trying to write something about my youth - isn't that now?\nAnyways, I got into computers and all of the following, because my godfather worked in the IT-department of his company and for my birthday always got me a new computer.\nThese things fascinated the hell out of me, so I started learning more and more about them. Bit by bit going forward, tearing apart old Windows PCs, helping my granddad with his mobile phone, got myself the first iPod Touch and later on my first iPhone, iPad and MacBook.\nI can remember the excitement, when my MacBook Pro 13\" 2009 Edition finally arrived and I could install the mysterious \"Xcode\" everyone on the developer forums was talking about, so this is how I got into programming apps for iOS.\n\nFind below some pictures of my first iDevices:"]