//
//  StoryController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 21.04.15.
//  Copyright (c) 2015 Finn Gaida. All rights reserved.
//

import UIKit
import StoreKit

class FGStoryController: UIViewController, UIScrollViewDelegate, SKStoreProductViewControllerDelegate {
    
    let titles = ["Events", "Apps", "Education", "Interests", "Hello!"]
    let texts = [
        ["In late summer of 2013 Marcel Voss sent me a link to an organization called Young Rewired State who would host a hackathon in Berlin shortly after. We both instantly signed up and luckily were accepted last minute. I hooked up with Daniel Petri and Niklas Riekenbrauck there to create PlateCollect (later Stumbler) and had a LOT of fun as well. When exploring the city we met Robert from *bliep who connected us to that company and to top it all off we won the first prize and were invited to that years' Festival of Code in the UK.", "As a follow-up of our Attendance at Jugend Hackt, we were invited to the annual International Conference on Telecommunications in Vilnius hosted by the European Parliament. We presented our app PlateCollect and also met a bunch of awesome and inspiring people, such as Jorge Izquierdo, who won one of last years' WWDC scholarships, Neelie Kroes, Eben Upton and had loads of fun. I imagine it similar to the experience of WWDC.", "Eventually the news spread even further and we got invited back to Berlin to present our app PlateCollect once more, this time to a much larger crowd. We were interviewed and filmed. At the end of the day I returned home with that awesome feeling of having put a dent in the universe in me. I felt like I had used this opportunity to the last bit, so I was really proud of myself and what we had accomplished.", "From the early beginning I was a part of Thinkspace's side branch Pioneers which is a group of young developers and designers aiming to form groups and supplying the foundation to create. In January they organized a meetup in London, where about 20 youngsters from the group came together to talk ideas, algorithms, favorite languages and even attending a hackathon. I also got to meet Max Kramer, a really talented and professional iOS developer and made some advances in my english.", "In 2014 Jugend Hackt went for a revival of 2013's awesome first youth coding contest in the history of Germany. Daniel, Niklas and I - as last year's winners - helped a lot with the organization, but couldn't resist competing. Over the course of a weekend we sat together, planned and coded Kolumbus and had even more fun than the first time. There were people from YRS and the CCC and to top it all of we won the first prize again, which resulted in us being prohibited from winning again next year.", "I first came to know the dutch telecom provider *bliep in Berlin at Jugend Hackt. Since then I collaborated with folks from the netherlands to help bring them to germany and so in January 2015 the first meeting of the official group happened in Berlin. We talked about the core idea of the company, even our ethical opinions. All in all it was an interesting meeting with a lot of smart people and I am looking forward to continue working with them."],
        ["When I started building SunUp I had already learned about all major features of iOS, but I had never actually built a project to the very end, so I said to myself I should finish this one. So a good 3 months later I started working on it. I uploaded version 1.0 to the AppStore and since then incorporated several minor updates and two major ones. The app involves several UIKit classes, motion effects, local notifications, sounds and in-app purchases. I use it to apply my knowledge about new Frameworks, such as HealthKit or WatchKit and app extensions. \nYou can check it out on the AppStore by tapping the icon or using this widget: Just hold shortly and then drag around the circle to set a time, just like you were setting a clocks' hour hand.", "When iOS 7 came out my brother, who owned an iPod Touch 4G at the time, told me he wanted to have the possibility to set his display brightness as quick as I could with the control center as well, so I meshed together a small project that followed the two goals of having a startup time of <1sec and providing the simplest interface I could think of. In the following months I added more designs to make it ready for the AppStore and in the end I learned UIKitDynamics with it as well as performance optimization. You can download Brightness from the AppStore by tapping its icon left to this headline.", "FabTap is a simple game featuring singleplayer and multiplayer modes I worked on together with an Android dev friend from my school. It also involves loads of colorful animations and helps me understand GameCenter's core concepts.\nIn the game you have to tap as fast as you can to beat your highscore, or your opponent, who either plays on the same device via split screen or (in the future) remotely via the API I wrote using PHP and MySQL to manage user authorization, push notifications and turn based data management. Tap the icon to go to the AppStore.", "When I went to Jugend Hackt in the fall of 2013, we - that is Daniel Petri, Niklas Riekenbrauck and I - came up with an idea to display Berlin's so-called Stolpersteine on a map to make the supplied big data more useful. The main concept was complete after some hours and then we started geocoding the addresses we got. I was responsible for turning the coordinates into actual pins on the map and also handling the views, while Niklas did the database handling and Daniel the parsing. \nPlateCollect is still in development and is available to everybody on my GitHub account.", "For the second Jugend Hackt hackathon in 2014 Daniel, Niklas and I formed the same team from the last year and came up with the idea of Kolumbus that was awarded Best in Show. \nThe app supplies tourists with a completely customized tour of the visited city based of their budget and time. Therefore Daniel and I worked on the app itself and Niklas built the server-side backend. Also Rico helped us by porting the app to Android. \nKolumbus is still in development and can be accessed on Daniel's GitHub page.", "When Jordan Earle contacted me for help on his new app I immediately accepted the offer. My job was to build some fancy animations to help young people in Belfast find activities to do. I worked remotely, via git, with two other developers, Colton Anglin and Jonathan Kingsley (who are also applying for a scholarship) and ended up not only building said animations but also working with MapKit and NSURLConnections. In the end I had a great time and I'd definitely work remotely again sometime. YouthEast can be found on the AppStore via the icon.", "During my internship at the german mobile advertising company apprupt in Hamburg my main task was to rebuild their showcase app from the ground up. To fit their ideas I worked closely with a designer and got to know professional tools for the organization of upscaled work, such as git and jira. I also got to take a general look on how professionals work in this industry which was really exciting, as you normally don't get this opportunity as a student. \nAs they told me, they appreciated my work and hopefully I will get to work with them again this year's summer break. \nThe showcase app is available on the AppStore."],
        ["Since 2007 I am a student of the Alstergmynasium, the german high school equivalent, now visiting the 12th grade, so I'm expecting to graduate next year. I'm also part of the Physics profile, this means my classes are more focussed on sciences than for example social sciences. In addition I'm a volunteer member of the so-called Schülervertretung - a group of students sitting together with the school's leaders to decide on changes to the school system. \nI'm also leading the Event Technologies Group with three others, that is responsible for the sound and light when something is being presented on our stage.", "In 2012 I had my first internship at DESY, the german CERN, and learned a lot about nuclear physics and the IT behind all of it. We visited one of the astonishingly huge accelerators and had the ability to ask some questions. This year, in 2015 I had my second internship at apprupt, a german provider of mobile ads. You can find out more about my time there in the events category."],
        ["In my free time my biggest hobby as you might have guessed is programming. When I'm not currently working on a personal project or a client app I'm probably browsing through my Twitter feed (you can follow me @fga I'd be so happy ☺️) or 9Gag. I also like to spend time with my family, eating, travelling or playing Wii games and hanging out with my girlfriend to watch TV series or go out. When time is left I usually start doing sports, mostly running and cycling. \nOn holidays I enjoy a relaxed hotel vacation, but love an adventure trip, so we've been to the US west coast, throughout Europe and around Florida travelling from place to place with a van and then sleeping in a tent. \nI also love to meet new people that have similar interests, so I imagine WWDC to be the best place on earth to be for me..."],
        ["I designed this app to showcase my recent work on iOS projects and personal achievements. Each card holds info about one of my qualifications. You can scroll through the cards and hide them by flicking up or down when you're done.\nYou should also connect to an Apple TV if you have one around, because there will be additional info there. Try it out here when mirroring: "]]
    
    var scrollView = UIScrollView()
    var darkener = UIView()
    var container = UIView()
    var identifier:Int = 0
    var pointCache:CGPoint = CGPointZero // for the pan gesture
    var startPoint:CGPoint = CGPointZero
    var block = false
    var titleField = UILabel()
    var textField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        darkener = UIView(frame: self.view.frame)
        darkener.backgroundColor = UIColor.blackColor()
        darkener.alpha = 0.0
        self.view.addSubview(darkener)
        
        
        scrollView.frame = self.view.bounds
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.contentSize = CGSizeMake(scrollView.frame.width, scrollView.frame.height+1)
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        container = UIView(frame: CGRectMake(0, scrollView.frame.height, scrollView.frame.width, scrollView.frame.height))
        container.backgroundColor = UIColor.whiteColor()
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 10
        scrollView.addSubview(container)
        
        titleField = UILabel(frame: CGRectMake(15, 15, self.view.frame.width - 30, 70))
        titleField.backgroundColor = UIColor.clearColor()
        titleField.textColor = UIColor.blackColor()
        titleField.textAlignment = NSTextAlignment.Center
        titleField.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        container.addSubview(titleField)
        
        let statusBG = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 20))
        statusBG.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.view.addSubview(statusBG)
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        blurView.frame = statusBG.frame
        statusBG.addSubview(blurView)
        
    }
    
    
    func showStory(identifier: Int) {
        
        self.titleField.text = titles[identifier]
        
        // specialties
        switch (identifier) {
        case 0:     // Events
            
            let titleField2 = UILabel(frame: CGRectMake(15, 65, self.view.frame.width - 30, 70))
            titleField2.backgroundColor = UIColor.clearColor()
            titleField2.textColor = UIColor.blackColor()
            titleField2.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField2.text = "Jugend Hackt"
            container.addSubview(titleField2)
            
            let jhacktimg = UIImageView(frame: CGRectMake(20, 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.7))
            jhacktimg.image = UIImage(named: "Jugendhackt.jpg")
            jhacktimg.layer.masksToBounds = true
            jhacktimg.layer.cornerRadius = 5
            container.addSubview(jhacktimg)
            
            textField = UITextView(frame: CGRectMake(15, jhacktimg.frame.origin.y + jhacktimg.frame.height + 20, self.view.frame.width - 30, 450))
            textField.backgroundColor = UIColor.clearColor()
            textField.textColor = UIColor.blackColor()
            textField.editable = false
            textField.scrollEnabled = false
            textField.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            self.textField.text = texts[identifier][0]
            container.addSubview(textField)
            
            let adj:CGFloat = -160
            let ict0:CGFloat = textField.frame.origin.y + textField.frame.height + adj + 40
            let titleField3 = UILabel(frame: CGRectMake(15, ict0 + 65, self.view.frame.width - 30, 70))
            titleField3.backgroundColor = UIColor.clearColor()
            titleField3.textColor = UIColor.blackColor()
            titleField3.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField3.text = "ICT"
            container.addSubview(titleField3)
            
            let ictimg = UIImageView(frame: CGRectMake(20, ict0 + 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.7))
            ictimg.image = UIImage(named: "ICT.jpg")
            ictimg.layer.masksToBounds = true
            ictimg.layer.cornerRadius = 5
            container.addSubview(ictimg)
            
            let textField2 = UITextView(frame: CGRectMake(15, ictimg.frame.origin.y + ictimg.frame.height + 20, self.view.frame.width - 30, 450))
            textField2.backgroundColor = UIColor.clearColor()
            textField2.textColor = UIColor.blackColor()
            textField2.editable = false
            textField2.scrollEnabled = false
            textField2.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField2.text = texts[identifier][1]
            container.addSubview(textField2)
            
            
            
            let zugang0 = textField2.frame.origin.y + textField2.frame.height + adj - 10
            let titleField4 = UILabel(frame: CGRectMake(15, zugang0 + 65, self.view.frame.width - 30, 70))
            titleField4.backgroundColor = UIColor.clearColor()
            titleField4.textColor = UIColor.blackColor()
            titleField4.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField4.text = "Zugang gestalten"
            container.addSubview(titleField4)
            
            let zugangimg = UIImageView(frame: CGRectMake(20, zugang0 + 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.7))
            zugangimg.image = UIImage(named: "Zugang.jpg")
            zugangimg.layer.masksToBounds = true
            zugangimg.layer.cornerRadius = 5
            container.addSubview(zugangimg)
            
            let textField3 = UITextView(frame: CGRectMake(15, zugangimg.frame.origin.y + zugangimg.frame.height + 20, self.view.frame.width - 30, 450))
            textField3.backgroundColor = UIColor.clearColor()
            textField3.textColor = UIColor.blackColor()
            textField3.editable = false
            textField3.scrollEnabled = false
            textField3.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField3.text = texts[identifier][2]
            container.addSubview(textField3)
            
            
            
            
            let thinkspace0 = textField3.frame.origin.y + textField3.frame.height + adj - 20
            let titleField5 = UILabel(frame: CGRectMake(15, thinkspace0 + 65, self.view.frame.width - 30, 70))
            titleField5.backgroundColor = UIColor.clearColor()
            titleField5.textColor = UIColor.blackColor()
            titleField5.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField5.text = "Thinkspace"
            container.addSubview(titleField5)
            
            let thinkimg = UIImageView(frame: CGRectMake(20, thinkspace0 + 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.2))
            thinkimg.image = UIImage(named: "Thinkspace")
            thinkimg.layer.masksToBounds = true
            thinkimg.layer.cornerRadius = 5
            container.addSubview(thinkimg)
            
            let textField4 = UITextView(frame: CGRectMake(15, thinkimg.frame.origin.y + thinkimg.frame.height + 20, self.view.frame.width - 30, 450))
            textField4.backgroundColor = UIColor.clearColor()
            textField4.textColor = UIColor.blackColor()
            textField4.editable = false
            textField4.scrollEnabled = false
            textField4.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField4.text = texts[identifier][3]
            container.addSubview(textField4)
            
            
            
            
            let jhackt20 = textField4.frame.origin.y + textField4.frame.height + adj + 20
            let titleField6 = UILabel(frame: CGRectMake(15, jhackt20 + 65, self.view.frame.width - 30, 70))
            titleField6.backgroundColor = UIColor.clearColor()
            titleField6.textColor = UIColor.blackColor()
            titleField6.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField6.text = "Jugend Hackt 2.0"
            container.addSubview(titleField6)
            
            let jhackt2img = UIImageView(frame: CGRectMake(20, jhackt20 + 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.7))
            jhackt2img.image = UIImage(named: "Jugendhackt2.jpg")
            jhackt2img.layer.masksToBounds = true
            jhackt2img.layer.cornerRadius = 5
            container.addSubview(jhackt2img)
            
            let textField5 = UITextView(frame: CGRectMake(15, jhackt2img.frame.origin.y + jhackt2img.frame.height + 20, self.view.frame.width - 30, 450))
            textField5.backgroundColor = UIColor.clearColor()
            textField5.textColor = UIColor.blackColor()
            textField5.editable = false
            textField5.scrollEnabled = false
            textField5.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField5.text = texts[identifier][4]
            container.addSubview(textField5)
            
            
            
            
            let bliep0 = textField5.frame.origin.y + textField5.frame.height + adj + 20
            let titleField7 = UILabel(frame: CGRectMake(15, bliep0 + 65, self.view.frame.width - 30, 70))
            titleField7.backgroundColor = UIColor.clearColor()
            titleField7.textColor = UIColor.blackColor()
            titleField7.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField7.text = "Bliep*"
            container.addSubview(titleField7)
            
            let bliepimg = UIImageView(frame: CGRectMake(20, bliep0 + 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.65))
            bliepimg.image = UIImage(named: "Bliep.jpg")
            bliepimg.layer.masksToBounds = true
            bliepimg.layer.cornerRadius = 5
            container.addSubview(bliepimg)
            
            let textField6 = UITextView(frame: CGRectMake(15, bliepimg.frame.origin.y + bliepimg.frame.height + 20, self.view.frame.width - 30, 450))
            textField6.backgroundColor = UIColor.clearColor()
            textField6.textColor = UIColor.blackColor()
            textField6.editable = false
            textField6.scrollEnabled = false
            textField6.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField6.text = texts[identifier][5]
            container.addSubview(textField6)
            
            self.container.frame = CGRectMake(0, self.container.frame.origin.y, self.container.frame.width, textField6.frame.origin.y + textField6.frame.height - 60)
            self.scrollView.contentSize = CGSizeMake(self.container.frame.width, self.container.frame.height + 20.0)
            
            
        case 1: // Apps
            
            let sunupicon = FGCategoryButton(app: FGApp.SunUp, frame: CGRectMake(20, 80, 40, 40))
            sunupicon.appDelegate = self
            container.addSubview(sunupicon)
            
            let titleField2 = UILabel(frame: CGRectMake(75, 65, self.view.frame.width - 30, 70))
            titleField2.backgroundColor = UIColor.clearColor()
            titleField2.textColor = UIColor.blackColor()
            titleField2.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField2.text = "SunUp"
            container.addSubview(titleField2)
            
            textField = UITextView(frame: CGRectMake(15, 120, self.view.frame.width - 30, 570))
            textField.backgroundColor = UIColor.clearColor()
            textField.textColor = UIColor.blackColor()
            textField.editable = false
            textField.scrollEnabled = false
            textField.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            self.textField.text = texts[identifier][0]
            container.addSubview(textField)
            
            let widget = FGSunUpWidget(frame: CGRectMake(20, 690, self.view.frame.width - 40, 200))
            widget.delegate = self
            container.addSubview(widget)
            
            let brightness0:CGFloat = widget.frame.origin.y + widget.frame.height - 40
            let brightnessicon = FGCategoryButton(app: FGApp.Brightness, frame: CGRectMake(20, brightness0 + 80, 40, 40))
            brightnessicon.appDelegate = self
            container.addSubview(brightnessicon)
            
            let titleField3 = UILabel(frame: CGRectMake(75, brightness0 + 65, self.view.frame.width - 30, 70))
            titleField3.backgroundColor = UIColor.clearColor()
            titleField3.textColor = UIColor.blackColor()
            titleField3.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField3.text = "Brightness"
            container.addSubview(titleField3)
            
            let textField2 = UITextView(frame: CGRectMake(15, brightness0 + 120, self.view.frame.width - 30, 450))
            textField2.backgroundColor = UIColor.clearColor()
            textField2.textColor = UIColor.blackColor()
            textField2.editable = false
            textField2.scrollEnabled = false
            textField2.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField2.text = texts[identifier][1]
            container.addSubview(textField2)
            
            
            let fabtap0:CGFloat = brightness0 + 520
            let fabtapicon = FGCategoryButton(app: FGApp.FabTap, frame: CGRectMake(20, fabtap0 + 80, 40, 40))
            fabtapicon.appDelegate = self
            container.addSubview(fabtapicon)
            
            let titleField4 = UILabel(frame: CGRectMake(75, fabtap0 + 65, self.view.frame.width - 30, 70))
            titleField4.backgroundColor = UIColor.clearColor()
            titleField4.textColor = UIColor.blackColor()
            titleField4.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField4.text = "FabTap"
            container.addSubview(titleField4)
            
            let textField3 = UITextView(frame: CGRectMake(15, fabtap0 + 120, self.view.frame.width - 30, 450))
            textField3.backgroundColor = UIColor.clearColor()
            textField3.textColor = UIColor.blackColor()
            textField3.editable = false
            textField3.scrollEnabled = false
            textField3.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField3.text = texts[identifier][2]
            container.addSubview(textField3)
            
            
            let plate0:CGFloat = fabtap0 + 500
            let plateicon = FGCategoryButton(app: FGApp.PlateCollect, frame: CGRectMake(20, plate0 + 80, 40, 40))
            plateicon.appDelegate = self
            container.addSubview(plateicon)
            
            let titleField5 = UILabel(frame: CGRectMake(75, plate0 + 65, self.view.frame.width - 30, 70))
            titleField5.backgroundColor = UIColor.clearColor()
            titleField5.textColor = UIColor.blackColor()
            titleField5.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField5.text = "PlateCollect"
            container.addSubview(titleField5)
            
            let textField4 = UITextView(frame: CGRectMake(15, plate0 + 120, self.view.frame.width - 30, 450))
            textField4.backgroundColor = UIColor.clearColor()
            textField4.textColor = UIColor.blackColor()
            textField4.editable = false
            textField4.scrollEnabled = false
            textField4.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField4.text = texts[identifier][3]
            container.addSubview(textField4)
            
            
            let kolumbus0:CGFloat = plate0 + 500
            let kolumbusicon = FGCategoryButton(app: FGApp.Kolumbus, frame: CGRectMake(20, kolumbus0 + 80, 40, 40))
            kolumbusicon.appDelegate = self
            container.addSubview(kolumbusicon)
            
            let titleField6 = UILabel(frame: CGRectMake(75, kolumbus0 + 65, self.view.frame.width - 30, 70))
            titleField6.backgroundColor = UIColor.clearColor()
            titleField6.textColor = UIColor.blackColor()
            titleField6.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField6.text = "Kolumbus"
            container.addSubview(titleField6)
            
            let textField5 = UITextView(frame: CGRectMake(15, kolumbus0 + 120, self.view.frame.width - 30, 450))
            textField5.backgroundColor = UIColor.clearColor()
            textField5.textColor = UIColor.blackColor()
            textField5.editable = false
            textField5.scrollEnabled = false
            textField5.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField5.text = texts[identifier][4]
            container.addSubview(textField5)
            
            
            
            let youtheast0:CGFloat = kolumbus0 + 500
            let youtheasticon = FGCategoryButton(app: FGApp.YouthEast, frame: CGRectMake(20, youtheast0 + 80, 40, 40))
            youtheasticon.appDelegate = self
            container.addSubview(youtheasticon)
            
            let titleField7 = UILabel(frame: CGRectMake(75, youtheast0 + 65, self.view.frame.width - 30, 70))
            titleField7.backgroundColor = UIColor.clearColor()
            titleField7.textColor = UIColor.blackColor()
            titleField7.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField7.text = "YouthEast"
            container.addSubview(titleField7)
            
            let textField6 = UITextView(frame: CGRectMake(15, youtheast0 + 120, self.view.frame.width - 30, 450))
            textField6.backgroundColor = UIColor.clearColor()
            textField6.textColor = UIColor.blackColor()
            textField6.editable = false
            textField6.scrollEnabled = false
            textField6.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField6.text = texts[identifier][5]
            container.addSubview(textField6)
            
            
            let apprupt0:CGFloat = youtheast0 + 470
            let apprupticon = FGCategoryButton(app: FGApp.apprupt, frame: CGRectMake(20, apprupt0 + 80, 40, 40))
            apprupticon.appDelegate = self
            container.addSubview(apprupticon)
            
            let titleField8 = UILabel(frame: CGRectMake(75, apprupt0 + 65, self.view.frame.width - 30, 70))
            titleField8.backgroundColor = UIColor.clearColor()
            titleField8.textColor = UIColor.blackColor()
            titleField8.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField8.text = "apprupt"
            container.addSubview(titleField8)
            
            let textField7 = UITextView(frame: CGRectMake(15, apprupt0 + 120, self.view.frame.width - 30, 500))
            textField7.backgroundColor = UIColor.clearColor()
            textField7.textColor = UIColor.blackColor()
            textField7.editable = false
            textField7.scrollEnabled = false
            textField7.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField7.text = texts[identifier][6]
            container.addSubview(textField7)
            
            
            
            self.container.frame = CGRectMake(0, self.container.frame.origin.y, self.container.frame.width, apprupt0 + 600)
            self.scrollView.contentSize = CGSizeMake(self.container.frame.width, self.container.frame.height + 20.0)
            
        case 2:  // Education
            
            let titleField = UILabel(frame: CGRectMake(15, 65, self.view.frame.width - 30, 70))
            titleField.backgroundColor = UIColor.clearColor()
            titleField.textColor = UIColor.blackColor()
            titleField.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField.text = "School"
            container.addSubview(titleField)
            
            let alstergym = UIImageView(frame: CGRectMake(20, 130, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.6))
            alstergym.image = UIImage(named: "alstergym.jpg")
            alstergym.layer.masksToBounds = true
            alstergym.layer.cornerRadius = 9
            container.addSubview(alstergym)
            
            let textField = UITextView(frame: CGRectMake(15, alstergym.frame.origin.y + alstergym.frame.height + 15, self.view.frame.width - 30, 500))
            textField.backgroundColor = UIColor.clearColor()
            textField.textColor = UIColor.blackColor()
            textField.editable = false
            textField.scrollEnabled = false
            textField.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField.text = texts[identifier][0]
            container.addSubview(textField)
            
            
            let y0 = textField.frame.origin.y + textField.frame.height
            let titleField2 = UILabel(frame: CGRectMake(15, y0, self.view.frame.width - 30, 70))
            titleField2.backgroundColor = UIColor.clearColor()
            titleField2.textColor = UIColor.blackColor()
            titleField2.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            titleField2.text = "Internships"
            container.addSubview(titleField2)
            
            let desy = UIImageView(frame: CGRectMake(20, y0 + 80, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.6))
            desy.image = UIImage(named: "desy.jpg")
            desy.layer.masksToBounds = true
            desy.layer.cornerRadius = 9
            container.addSubview(desy)
            
            let textField2 = UITextView(frame: CGRectMake(15, desy.frame.origin.y + desy.frame.height + 20, self.view.frame.width - 30, 500))
            textField2.backgroundColor = UIColor.clearColor()
            textField2.textColor = UIColor.blackColor()
            textField2.editable = false
            textField2.scrollEnabled = false
            textField2.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField2.text = texts[identifier][1]
            container.addSubview(textField2)
            
            
            self.container.frame = CGRectMake(0, self.container.frame.origin.y, self.container.frame.width, textField2.frame.origin.y + textField2.frame.height - 200)
            self.scrollView.contentSize = CGSizeMake(self.container.frame.width, self.container.frame.height + 20.0)
            
        case 3:/*
            println("Skills")
            FGStuffCalculator.skillsCard(self.container)
            
        case 4:*/  // Interests
            
            let family = UIImageView(frame: CGRectMake(20, 80, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.75))
            family.image = UIImage(named: "family")
            family.layer.masksToBounds = true
            family.layer.cornerRadius = 9
            container.addSubview(family)
            
            let textField = UITextView(frame: CGRectMake(15, family.frame.origin.y + family.frame.height , self.view.frame.width - 30, 620))
            textField.backgroundColor = UIColor.clearColor()
            textField.textColor = UIColor.blackColor()
            textField.editable = false
            textField.scrollEnabled = false
            textField.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField.text = texts[identifier][0]
            container.addSubview(textField)
            
            self.container.frame = CGRectMake(0, self.container.frame.origin.y, self.container.frame.width, textField.frame.origin.y + textField.frame.height)
            self.scrollView.contentSize = CGSizeMake(self.container.frame.width, self.container.frame.height + 20.0)
            
        case 4:  // Welcome
            
            let wwdc = UIImageView(frame: CGRectMake(20, 80, self.view.frame.width - 40, (self.view.frame.width - 40) * 0.6))
            wwdc.image = UIImage(named: "wwdc")
            wwdc.layer.masksToBounds = true
            wwdc.layer.cornerRadius = 9
            container.addSubview(wwdc)
            
            let textField = UITextView(frame: CGRectMake(15, 280, self.view.frame.width - 30, 300))
            textField.backgroundColor = UIColor.clearColor()
            textField.textColor = UIColor.blackColor()
            textField.editable = false
            textField.scrollEnabled = false
            textField.font = UIFont(name: "HelveticaNeue", size: self.view.frame.width/380 * 20)
            textField.text = texts[identifier][0]
            container.addSubview(textField)
            
            let hitme = UIButton(frame: CGRectMake(20, textField.frame.origin.y + textField.frame.height, self.view.frame.width - 40, 50))
            hitme.layer.masksToBounds = true
            hitme.layer.cornerRadius = 15
            hitme.backgroundColor = UIColor(red: (32.0/255.0), green: (7.0/255.0), blue: (65.0/255.0), alpha: 1.0)
            hitme.addTarget(self, action: "hitme", forControlEvents: UIControlEvents.TouchUpInside)
            hitme.addTarget(self, action: "hideStory:", forControlEvents: UIControlEvents.TouchUpInside)
            let hitmel = UILabel(frame: CGRectMake(0, 0, hitme.frame.width, hitme.frame.height))
            hitmel.backgroundColor = UIColor.clearColor()
            hitmel.textColor = UIColor.whiteColor()
            hitmel.textAlignment = NSTextAlignment.Center
            hitmel.font = UIFont(name: "HelveticaNeue-Light", size: 35)
            hitmel.text = "Hit me!"
            hitme.addSubview(hitmel)
            container.addSubview(hitme)
            
            
            self.container.frame = CGRectMake(0, self.container.frame.origin.y, self.container.frame.width, hitme.frame.origin.y + hitme.frame.height + 15)
            self.scrollView.contentSize = CGSizeMake(self.container.frame.width, self.container.frame.height + 30.0)
            
        default: print("Something went terribly wrong here")
        }
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            self.container.frame = CGRectMake(0, 20, self.container.frame.width, self.container.frame.height)
            self.darkener.alpha = 0.7
            }) { (Bool) -> Void in
                self.block = false
        }
        
    }
    
    func hideStory(up: Bool) {
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            self.container.frame = CGRectMake(0, (up) ? -self.scrollView.frame.height : self.scrollView.frame.height, self.container.frame.width, self.container.frame.height)
            self.darkener.alpha = 0.0
            }) { (Bool) -> Void in
                self.view.removeFromSuperview()
        }
        
    }
    
    func hitme() {
        remote(1)
    }
    
    func remote(id:Int) {
        
        let sender = UIControl()
        sender.tag = id
        NSNotificationCenter.defaultCenter().postNotificationName("showRemoteView", object: sender)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (!block) {
            
            self.darkener.alpha = 1 - (scrollView.contentOffset.y / -200)
            self.container.alpha = 1 - (scrollView.contentOffset.y / -2000)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        block = true
        
        if (self.titleField.text == "Events") {
            
            let dst:CGFloat = 600
            if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < dst * 1) {
                remote(9)
            } else if (scrollView.contentOffset.y > dst * 1 && scrollView.contentOffset.y < dst * 2) {
                remote(10)
            } else if (scrollView.contentOffset.y > dst * 2 && scrollView.contentOffset.y < dst * 3) {
                remote(11)
            } else if (scrollView.contentOffset.y > dst * 3 && scrollView.contentOffset.y < dst * 4) {
                remote(12)
            } else if (scrollView.contentOffset.y > dst * 4 && scrollView.contentOffset.y < dst * 5) {
                remote(46)
            } else if (scrollView.contentOffset.y > dst * 5 && scrollView.contentOffset.y < dst * 6) {
                remote(47)
            }
            
        } else if (self.titleField.text == "Apps") {
            
            let dst:CGFloat = 700
            if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < dst * 1) {
                remote(4)
            } else if (scrollView.contentOffset.y > dst * 1 && scrollView.contentOffset.y < dst * 2) {
                remote(6)
            } else if (scrollView.contentOffset.y > dst * 2 && scrollView.contentOffset.y < dst * 2.5) {
                remote(8)
            } else if (scrollView.contentOffset.y > dst * 2.5 && scrollView.contentOffset.y < dst * 3) {
                remote(5)
            } else if (scrollView.contentOffset.y > dst * 3 && scrollView.contentOffset.y < dst * 3.5) {
                remote(48)
            } else if (scrollView.contentOffset.y > dst * 3.5 && scrollView.contentOffset.y < dst * 4) {
                remote(7)
            } else if (scrollView.contentOffset.y > dst * 4 && scrollView.contentOffset.y < dst * 4.5) {
                remote(49)
            }
            
        } else if (self.titleField.text == "Education") {
            
            let dst:CGFloat = 700
            if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < dst * 1) {
                remote(50)
            } else if (scrollView.contentOffset.y > dst * 1 && scrollView.contentOffset.y < dst * 2) {
                remote(51)
            }
            
        } else if (self.titleField.text == "Interests") {
            
            remote(52)
            
        }
        
        
        // check minimum offset
        if (scrollView.contentOffset.y < -100) {
            
            remote(1)
            hideStory(false)
            
        } else if (scrollView.contentOffset.y > scrollView.contentSize.height - self.view.frame.height + 100) {
            
            remote(1)
            hideStory(true)
            
        }
        
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
        default:
            appID = ""
        }
        
        if (appID.length > 0) {
            
            // go to appstore
            let appstore = SKStoreProductViewController()
            appstore.delegate = self
            appstore.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:appID], completionBlock: { (result, error) -> Void in
                
                if ((error) != nil) {
                    
                    print("error showing appstore with \(app)")
                    
                } else {
                    
                    self.presentViewController(appstore, animated: true, completion: { () -> Void in
                        
                    })
                    
                }
                
                print("AppStore result is \(result)")
                
            })
        }
        
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
