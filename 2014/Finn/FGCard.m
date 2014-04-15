//
//  FGCard.m
//  Finn Gaida
//
//  Created by Finn Gaida on 08.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import "FGCard.h"

@implementation FGCard {
    
    NSArray *texts;
    
    // for the speeches
    AVSpeechSynthesizer *synthesizer;
    AVSpeechUtterance *utterance;
    
    int h;
    
}

@synthesize delegate;

- (id)initWithCardID:(int)cardID {
    
    self = [super init];
    if (self) {
        
        // basic setup
        h = (IS_IPHONE_5) ? 568 : 480;
        
        self.frame = CGRectMake(0, h*2, 320, h-80);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor whiteColor];
        
        // add texts
        texts = @[@"Welcome to my WWDC app!",
                  @"Hi, I'm Finn",
                  @"I designed this app to showcase my recent work on iOS projects and personal achievements. Each card holds info about one of my qualifications. You can swipe through the cards by flicking them up or down.\nYou should also tap on every image, button or underlined text in this app and if you're connected to an Apple TV you will see more info there. Try it out on this link.",
                  @"When I was 7 I started reading german tech magazines and since then, couldn't stop diving deeper into the scene. I proceeded with taking my PC apart, writing html websites, reading blogs, playing around (actually also jailbreaking) with my iPod Touch 1G and since I bought my MacBook in 2012 also coding for iOS. \nI have done projects for nearly every major API included in the iOS SDK and ended up posting SunUp on the AppStore last year.\nI expect to graduate in 2016 and plan on developing more apps until then.",
                  @"When I started building SunUp I had already learned about all major features of iOS, but I had never actually built a project to the very end, so I said to myself I should finish this one. A good 3 months after I started working on it I uploaded version 1.0 to the AppStore and since then incorporated several minor updates and just in December 2013 pushed update 2.0. The app involves several UIKit classes, motion effects, local notifications, sounds and in-app purchases. If you want to test it, you can use this promo code: --licensed--",
                  @"When I went to Jugend Hackt in the fall of 2013, we - that is Daniel Petri, Niklas Riekenbrauck and I - came up with an idea to display Berlin's so-called Stolpersteine on a map to make the supplied big data more useful. The main concept was final after some hours and then we started geocoding the addresses we got. I was responsible for turning the coordinates into actual pins on the map and also handling the views, while Niklas did the database handling and Daniel the parsing. \nWe won the first prize and since have had some decent press.",
                  @"When iOS 7 came out my brother, who owned an iPod Touch 4G at the time, told me he wanted to have the possibility to set his display brightness as quick as via the control center as well, so I meshed together a small project that followed the two goals of having a startup time of <1sec and providing the simplest interface I could think of. In the following months I added more designs to make it ready for the AppStore and in the end I learned UIKitDynamics with it as well as performance optimization. You can download Brightness from the AppStore.",
                  @"When Jordan Earle contacted me for help on his new app I immediately accepted the offer. My job was to build some fancy animations to help young people in Belfast find activities to do. I worked remotely, via git, with two other developers, Colton Anglin and Jonathan Kingsley and ended up not only building said animations but also working with MapKit and NSURLConnections. In recap I had a great time and I'd definitely work remotely again sometime. Go check out YouthEast.",
                  @"FabTap is a simple game featuring singleplayer and multiplayer modes I am working on together with an Android dev friend. It also involves loads of colorful animations and helps me understand GameCenter's core concepts.\nIn the game you have to tap as fast as you can to beat your highscore, or your opponent, who either plays on the same device via split screen  or remotely via the API I wrote using PHP and MySQL to manage user authorization, push notifications and turn based data management. Here are some screenshots.",
                  @"In late summer of 2013 Marcel Voss sent me a link to an organization called Young Rewired State who would host a hackathon in Berlin shortly after. We both instantly signed up and luckily were accepted last minute. I hooked up with Daniel Petri and Niklas Riekenbrauck there to create PlateCollect (later Stumbler) and had a LOT of fun as well. When exploring the city we met Robert from *bliep who connected us to that company and to top it all off we won the first prize and were invited to this years' Festival of Code in the UK.",
                  @"As a follow-up of our Attendance at Jugend Hackt, we were invited to the annual International Conference on Telecommunications in Vilnius by the European Parliament. We presented our app, called PlateCollect at that time and also met a bunch of awesome and inspiring people, such as Jorge Izquierdo, who won one last years' WWDC scholarships, Neelie Kroes, Eben Upton and many more.",
                  @"Eventually the news spread even further and we got invited back to Berlin to present our app once more, this time to a much larger crowd. We were interviewed and filmed and at the end of the day I returned home with that awesome feeling of having put a dent in the universe in me. I felt like I had used this opportunity to the last bit, so I was really proud of myself and what we had accomplished.",
                  @"From the early beginning I was a part of Thinkspace's side branch Pioneers which is a group of young developers and designers aiming to form groups and supplying the foundation to create. In January they organized a meetup in London, where about 20 of the group came together to talk ideas, algorithms, favorite languages and even attending a hackathon. I also got to meet Max Kramer, a really talented and professional iOS developer and made some advances in my english.",
                  
                  @"", // contact
                  @"WOW!  \n            Such card!\n  Many secret!\n\n              Very cool!  \n\n How shake!\n    So one more thing! \n\n                  Amazing!"
                  ];
        
        if (cardID == 1) {
            
            
            // image in the upper right that when tapped on shows something on the remote screen
            UIButton *meButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
            UIImageView *me = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            me.layer.masksToBounds = YES;
            me.layer.cornerRadius = me.frame.size.width/2;
            me.image = [UIImage imageNamed:@"me"];
            meButton.tag = 1;
            [meButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [meButton addSubview:me];
            [self addSubview:meButton];
            
            // title of the card
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(150, 20, 160, 110)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:52];
            name.text = @"Finn\nGaida";
            [self addSubview:name];
            
            
            // Age bar with label
            UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 50, 30)];
            age.backgroundColor = [UIColor clearColor];
            age.textColor = [UIColor blackColor];
            age.textAlignment = NSTextAlignmentLeft;
            age.numberOfLines = 0;
            age.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            age.text = @"Age:";
            [self addSubview:age];
            
            UIView *agebar = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 30, 30)];
            agebar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
            agebar.layer.masksToBounds = YES;
            agebar.layer.cornerRadius = agebar.frame.size.width/2;
            [self addSubview:agebar];
            
            UIView *agebarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 30, 30)];
            agebarMark.backgroundColor = [UIColor colorWithRed:0 green:(113.0/255.0) blue:(67.0/255.0) alpha:1];
            agebarMark.layer.masksToBounds = YES;
            agebarMark.layer.cornerRadius = agebarMark.frame.size.width/2;
            [self addSubview:agebarMark];
            
            UILabel *ageLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
            ageLoading.backgroundColor = [UIColor clearColor];
            ageLoading.textColor = [UIColor whiteColor];
            ageLoading.textAlignment = NSTextAlignmentLeft;
            ageLoading.numberOfLines = 0;
            ageLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            ageLoading.text = @"Loading 16%";
            [agebarMark addSubview:ageLoading];
            
            
            // Hobbies bar with title
            UILabel *hobbies = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 80, 30)];
            hobbies.backgroundColor = [UIColor clearColor];
            hobbies.textColor = [UIColor blackColor];
            hobbies.textAlignment = NSTextAlignmentLeft;
            hobbies.numberOfLines = 0;
            hobbies.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            hobbies.text = @"Hobbies:";
            [self addSubview:hobbies];
            
            UIView *hobbiesbar = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            hobbiesbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
            hobbiesbar.layer.masksToBounds = YES;
            hobbiesbar.layer.cornerRadius = hobbiesbar.frame.size.width/2;
            [self addSubview:hobbiesbar];
            
            UIView *familybarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            familybarMark.backgroundColor = [UIColor colorWithRed:(3.0/255.0) green:(66.0/255.0) blue:(106.0/255.0) alpha:1];
            familybarMark.layer.masksToBounds = YES;
            familybarMark.layer.cornerRadius = familybarMark.frame.size.width/2;
            [self addSubview:familybarMark];
            
            UILabel *familyLoading = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 100, 30)];
            familyLoading.backgroundColor = [UIColor clearColor];
            familyLoading.textColor = [UIColor whiteColor];
            familyLoading.textAlignment = NSTextAlignmentLeft;
            familyLoading.numberOfLines = 0;
            familyLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            familyLoading.text = @"Family";
            [familybarMark addSubview:familyLoading];
            
            UIView *codingbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            codingbarMark.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(139.0/255.0) blue:(0.0/255.0) alpha:1];
            codingbarMark.layer.masksToBounds = YES;
            codingbarMark.layer.cornerRadius = codingbarMark.frame.size.width/2;
            [self addSubview:codingbarMark];
            
            UILabel *codingLoading = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 100, 30)];
            codingLoading.backgroundColor = [UIColor clearColor];
            codingLoading.textColor = [UIColor whiteColor];
            codingLoading.textAlignment = NSTextAlignmentLeft;
            codingLoading.numberOfLines = 0;
            codingLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            codingLoading.text = @"Coding";
            [codingbarMark addSubview:codingLoading];
            
            UIView *schoolbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            schoolbarMark.backgroundColor = [UIColor colorWithRed:(159.0/255.0) green:(0.0/255.0) blue:(19.0/255.0) alpha:1];
            schoolbarMark.layer.masksToBounds = YES;
            schoolbarMark.layer.cornerRadius = schoolbarMark.frame.size.width/2;
            [self addSubview:schoolbarMark];
            
            UILabel *schoolLoading = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 100, 30)];
            schoolLoading.backgroundColor = [UIColor clearColor];
            schoolLoading.textColor = [UIColor whiteColor];
            schoolLoading.textAlignment = NSTextAlignmentLeft;
            schoolLoading.numberOfLines = 0;
            schoolLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            schoolLoading.text = @"School";
            [schoolbarMark addSubview:schoolLoading];
            
            UIView *sportsbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            sportsbarMark.backgroundColor = [UIColor colorWithRed:(74.0/255.0) green:(3.0/255.0) blue:(111.0/255.0) alpha:1];
            sportsbarMark.layer.masksToBounds = YES;
            sportsbarMark.layer.cornerRadius = sportsbarMark.frame.size.width/2;
            [self addSubview:sportsbarMark];
            
            UILabel *sportsLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
            sportsLoading.backgroundColor = [UIColor clearColor];
            sportsLoading.textColor = [UIColor whiteColor];
            sportsLoading.textAlignment = NSTextAlignmentLeft;
            sportsLoading.numberOfLines = 0;
            sportsLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            sportsLoading.text = @"Sports";
            [sportsbarMark addSubview:sportsLoading];
            
            
            
            // Education Bar Section
            UILabel *education = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 90, 30)];
            education.backgroundColor = [UIColor clearColor];
            education.textColor = [UIColor blackColor];
            education.textAlignment = NSTextAlignmentLeft;
            education.numberOfLines = 0;
            education.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            education.text = @"Education:";
            [self addSubview:education];
            
            UIView *educationbar = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
            educationbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
            educationbar.layer.masksToBounds = YES;
            educationbar.layer.cornerRadius = educationbar.frame.size.width/2;
            [self addSubview:educationbar];
            
            UIView *englishbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
            englishbarMark.backgroundColor = [UIColor colorWithRed:(0.0/255.0) green:(162.0/255.0) blue:(135.0/255.0) alpha:1];
            englishbarMark.layer.masksToBounds = YES;
            englishbarMark.layer.cornerRadius = englishbarMark.frame.size.width/2;
            [self addSubview:englishbarMark];
            
            UILabel *englishLoading = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 30)];
            englishLoading.backgroundColor = [UIColor clearColor];
            englishLoading.textColor = [UIColor whiteColor];
            englishLoading.textAlignment = NSTextAlignmentLeft;
            englishLoading.numberOfLines = 0;
            englishLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            englishLoading.text = @"English";
            [englishbarMark addSubview:englishLoading];
            
            UIView *mathsbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
            mathsbarMark.backgroundColor = [UIColor colorWithRed:(227.0/255.0) green:(57.0/255.0) blue:(164.0/255.0) alpha:1];
            mathsbarMark.layer.masksToBounds = YES;
            mathsbarMark.layer.cornerRadius = mathsbarMark.frame.size.width/2;
            [self addSubview:mathsbarMark];
            
            UILabel *mathsLoading = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 30)];
            mathsLoading.backgroundColor = [UIColor clearColor];
            mathsLoading.textColor = [UIColor whiteColor];
            mathsLoading.textAlignment = NSTextAlignmentLeft;
            mathsLoading.numberOfLines = 0;
            mathsLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            mathsLoading.text = @"Maths";
            [mathsbarMark addSubview:mathsLoading];
            
            UIView *physicsbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
            physicsbarMark.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(53.0/255.0) blue:(0.0/255.0) alpha:1];
            physicsbarMark.layer.masksToBounds = YES;
            physicsbarMark.layer.cornerRadius = physicsbarMark.frame.size.width/2;
            [self addSubview:physicsbarMark];
            
            UILabel *physicsLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
            physicsLoading.backgroundColor = [UIColor clearColor];
            physicsLoading.textColor = [UIColor whiteColor];
            physicsLoading.textAlignment = NSTextAlignmentLeft;
            physicsLoading.numberOfLines = 0;
            physicsLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
            physicsLoading.text = @"Physics";
            [physicsbarMark addSubview:physicsLoading];
            
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"how to";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
            // animate the bars
            [UIView animateWithDuration:1.5 delay:.6 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                agebar.frame = CGRectMake(20, 180, 280, 30);
                agebarMark.frame = CGRectMake(20, 180, 130, 30);
                
                hobbiesbar.frame = CGRectMake(20, 260, 280, 30);
                familybarMark.frame = CGRectMake(20, 260, 280, 30);
                codingbarMark.frame = CGRectMake(20, 260, 220, 30);
                schoolbarMark.frame = CGRectMake(20, 260, 140, 30);
                sportsbarMark.frame = CGRectMake(20, 260, 80, 30);
                
                educationbar.frame = CGRectMake(20, 340, 280, 30);
                englishbarMark.frame = CGRectMake(20, 340, 280, 30);
                mathsbarMark.frame = CGRectMake(20, 340, 190, 30);
                physicsbarMark.frame = CGRectMake(20, 340, 100, 30);
                
            } completion:^(BOOL finished) {
                
            }];
            
            
        }
        else if (cardID == 2) {
            
            
            // top of the card
            UIButton *wwdcButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *wwdc = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            wwdc.layer.masksToBounds = YES;
            wwdc.layer.cornerRadius = wwdc.frame.size.width/2;
            wwdc.image = [UIImage imageNamed:@"wwdc.jpg"];
            [wwdcButton addSubview:wwdc];
            wwdcButton.tag = 2;
            [wwdcButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:wwdcButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"How to use this app";
            [self addSubview:name];
            
            //UILabel *explanation = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 300)];
            //explanation.backgroundColor = [UIColor clearColor];
            //explanation.textColor = [UIColor blackColor];
            //explanation.textAlignment = NSTextAlignmentLeft;
            //explanation.numberOfLines = 0;
            //explanation.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            //explanation.text = texts[2];
            //[self addSubview:explanation];
            
            /* this is where it's at! create a text field to
             1. show the content in a respectful manner
             2. Make use of newer APIs
             3. Underline the links */
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[2] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(366, 4)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"more info";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
            
        }
        else if (cardID == 3) {
            
            
            // top of the card
            UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *more = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            more.layer.masksToBounds = YES;
            more.layer.cornerRadius = more.frame.size.width/2;
            more.image = [UIImage imageNamed:@"me2.jpg"];
            [moreButton addSubview:more];
            moreButton.tag = 3;
            [moreButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:moreButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"More about me";
            [self addSubview:name];
            
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[3] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(38, 14)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(173, 13)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(407, 5)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(452, 8)];
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"apps by me";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 4) {
            
            
            // top of the card
            UIButton *sunupButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *sunup = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            sunup.layer.masksToBounds = YES;
            sunup.layer.cornerRadius = sunup.frame.size.width/2;
            sunup.image = [UIImage imageNamed:@"sunup"];
            [sunupButton addSubview:sunup];
            sunupButton.tag = 4;
            [sunupButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:sunupButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"SunUp";
            [self addSubview:name];
            
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[4] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(246, 11)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(357, 10)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(394, 13)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(409, 14)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(425, 19)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(446, 6)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(457, 16)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(528, 12)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"platecollect";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 5) {
            
            
            // top of the card
            UIButton *stumblerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *stumbler = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            stumbler.layer.masksToBounds = YES;
            stumbler.layer.cornerRadius = stumbler.frame.size.width/2;
            stumbler.image = [UIImage imageNamed:@"stumbler"];
            [stumblerButton addSubview:stumbler];
            stumblerButton.tag = 5;
            [stumblerButton addTarget:self action:@selector(showAppAlert:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:stumblerButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"PlateCollect";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[5] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(15, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(62, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(76, 19)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(155, 13)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(426, 6)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(463, 6)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"brightness";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 6) {
            
            
            // top of the card
            UIButton *brightnessButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *brightness = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            brightness.layer.masksToBounds = YES;
            brightness.layer.cornerRadius = brightness.frame.size.width/2;
            brightness.image = [UIImage imageNamed:@"brightness"];
            [brightnessButton addSubview:brightness];
            brightnessButton.tag = 6;
            [brightnessButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:brightnessButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"Brightness";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[6] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(374, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(513, 8)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"youtheast";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 7) {
            
            
            // top of the card
            UIButton *youtheastButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *youtheast = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            youtheast.layer.masksToBounds = YES;
            youtheast.layer.cornerRadius = youtheast.frame.size.width/2;
            youtheast.image = [UIImage imageNamed:@"youtheast"];
            [youtheastButton addSubview:youtheast];
            youtheastButton.tag = 7;
            [youtheastButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:youtheastButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"YouthEast";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[7] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(5, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(241, 13)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(259, 17)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(465, 9)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"fabtap";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 8) {
            
            
            // top of the card
            UIButton *fabtapButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *fabtap = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            fabtap.layer.masksToBounds = YES;
            fabtap.layer.cornerRadius = fabtap.frame.size.width/2;
            fabtap.image = [UIImage imageNamed:@"fabtap"];
            [fabtapButton addSubview:fabtap];
            fabtapButton.tag = 8;
            [fabtapButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:fabtapButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"FabTap";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[8] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(114, 6)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(444, 18)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(509, 11)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"events I attended";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 9) {
            
            
            // top of the card
            UIButton *jugendhacktButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *jugendhackt = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            jugendhackt.layer.masksToBounds = YES;
            jugendhackt.layer.cornerRadius = jugendhackt.frame.size.width/2;
            jugendhackt.image = [UIImage imageNamed:@"jugendhackt.jpg"];
            [jugendhacktButton addSubview:jugendhackt];
            jugendhacktButton.tag = 9;
            [jugendhacktButton addTarget:self action:@selector(showAppAlert:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:jugendhacktButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"Jugend Hackt";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[9] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(23, 11)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(76, 19)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(232, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(249, 19)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(285, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(376, 18)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(505, 16)];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"ict";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 10) {
            
            
            // top of the card
            UIButton *ictButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *ict = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            ict.layer.masksToBounds = YES;
            ict.layer.cornerRadius = ict.frame.size.width/2;
            ict.image = [UIImage imageNamed:@"ict.jpg"];
            [ictButton addSubview:ict];
            ictButton.tag = 10;
            [ictButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:ictButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"ICT 2013";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[10] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(36, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(145, 19)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(195, 12)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(283, 15)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(292, 4)];
            
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"zugang gestalten";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 11) {
            
            
            // top of the card
            UIButton *zugangButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *zugang = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            zugang.layer.masksToBounds = YES;
            zugang.layer.cornerRadius = zugang.frame.size.width/2;
            zugang.image = [UIImage imageNamed:@"zugang.jpg"];
            [zugangButton addSubview:zugang];
            zugangButton.tag = 11;
            [zugangButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:zugangButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"Zugang Gestalten";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[11] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(162, 6)];
            
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"pioneers london";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 12) {
            
            
            // top of the card
            UIButton *pioneersButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *pioneers = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            pioneers.layer.masksToBounds = YES;
            pioneers.layer.cornerRadius = pioneers.frame.size.width/2;
            pioneers.image = [UIImage imageNamed:@"pioneers.jpg"];
            [pioneersButton addSubview:pioneers];
            pioneersButton.tag = 12;
            [pioneersButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:pioneersButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"Pioneers London";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:18],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[12] attributes:attrs];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(41, 10)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(66, 8)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(343, 9)];
            [string addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(373, 10)];
            
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"contact";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            [self addSubview:arrow];
            
            
        }
        else if (cardID == 13) {
            
            // image in the upper right
            UIButton *meButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
            UIImageView *me = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            me.layer.masksToBounds = YES;
            me.layer.cornerRadius = me.frame.size.width/2;
            me.image = [UIImage imageNamed:@"me"];
            meButton.tag = 13;
            [meButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [meButton addSubview:me];
            [self addSubview:meButton];
            
            // title of the card
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(145, 20, 170, 110)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:50];
            name.text = @"Contact";
            [self addSubview:name];
            
            
            // email bar with label
            UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 50, 30)];
            email.backgroundColor = [UIColor clearColor];
            email.textColor = [UIColor blackColor];
            email.textAlignment = NSTextAlignmentLeft;
            email.numberOfLines = 0;
            email.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            email.text = @"E-Mail:";
            [self addSubview:email];
            
            UIView *emailbar = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 30, 30)];
            emailbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
            emailbar.layer.masksToBounds = YES;
            emailbar.layer.cornerRadius = emailbar.frame.size.width/2;
            [self addSubview:emailbar];
            
            UIView *emailbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 30, 30)];
            emailbarMark.backgroundColor = [UIColor colorWithRed:(45.0/255.0) green:(215.0/255.0) blue:0 alpha:1];
            emailbarMark.layer.masksToBounds = YES;
            emailbarMark.layer.cornerRadius = emailbarMark.frame.size.width/2;
            [self addSubview:emailbarMark];
            
            UILabel *emailLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 30)];
            emailLoading.backgroundColor = [UIColor clearColor];
            emailLoading.textColor = [UIColor whiteColor];
            emailLoading.textAlignment = NSTextAlignmentLeft;
            emailLoading.numberOfLines = 0;
            emailLoading.font = [UIFont fontWithName:@"Futura-Normal" size:17];
            emailLoading.text = @"finn.gaida@me.com";
            [emailbarMark addSubview:emailLoading];
            
            
            
            // twitter bar with title
            UILabel *twitter = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 80, 30)];
            twitter.backgroundColor = [UIColor clearColor];
            twitter.textColor = [UIColor blackColor];
            twitter.textAlignment = NSTextAlignmentLeft;
            twitter.numberOfLines = 0;
            twitter.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            twitter.text = @"Twitter:";
            [self addSubview:twitter];
            
            UIView *twitterbar = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            twitterbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
            twitterbar.layer.masksToBounds = YES;
            twitterbar.layer.cornerRadius = twitterbar.frame.size.width/2;
            [self addSubview:twitterbar];
            
            UIView *twitterbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
            twitterbarMark.backgroundColor = [UIColor colorWithRed:(86.0/255.0) green:(172.0/255.0) blue:(238.0/255.0) alpha:1];
            twitterbarMark.layer.masksToBounds = YES;
            twitterbarMark.layer.cornerRadius = twitterbarMark.frame.size.width/2;
            [self addSubview:twitterbarMark];
            
            UILabel *twitterLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
            twitterLoading.backgroundColor = [UIColor clearColor];
            twitterLoading.textColor = [UIColor whiteColor];
            twitterLoading.textAlignment = NSTextAlignmentLeft;
            twitterLoading.numberOfLines = 0;
            twitterLoading.font = [UIFont fontWithName:@"Futura-Normal" size:17];
            twitterLoading.text = @"@finngaida";
            [twitterbarMark addSubview:twitterLoading];
            
            
            
            // github Bar Section
            UILabel *github = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 90, 30)];
            github.backgroundColor = [UIColor clearColor];
            github.textColor = [UIColor blackColor];
            github.textAlignment = NSTextAlignmentLeft;
            github.numberOfLines = 0;
            github.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            github.text = @"GitHub:";
            [self addSubview:github];
            
            UIView *githubbar = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
            githubbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
            githubbar.layer.masksToBounds = YES;
            githubbar.layer.cornerRadius = githubbar.frame.size.width/2;
            [self addSubview:githubbar];
            
            UIView *githubbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
            githubbarMark.backgroundColor = [UIColor blackColor];
            githubbarMark.layer.masksToBounds = YES;
            githubbarMark.layer.cornerRadius = githubbarMark.frame.size.width/2;
            [self addSubview:githubbarMark];
            
            UILabel *githubLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
            githubLoading.backgroundColor = [UIColor clearColor];
            githubLoading.textColor = [UIColor whiteColor];
            githubLoading.textAlignment = NSTextAlignmentLeft;
            githubLoading.numberOfLines = 0;
            githubLoading.font = [UIFont fontWithName:@"Futura-Normal" size:17];
            githubLoading.text = @"github.com/finngaida";
            [githubbarMark addSubview:githubLoading];
            
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"that's all folks";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            arrow.transform = CGAffineTransformMakeRotation(M_PI);
            [self addSubview:arrow];
            
            
            // animate the bars
            [UIView animateWithDuration:1.5 delay:.6 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                emailbar.frame = CGRectMake(20, 180, 280, 30);
                emailbarMark.frame = CGRectMake(20, 180, 158, 30);
                
                twitterbar.frame = CGRectMake(20, 260, 280, 30);
                twitterbarMark.frame = CGRectMake(20, 260, 103, 30);
                
                githubbar.frame = CGRectMake(20, 340, 280, 30);
                githubbarMark.frame = CGRectMake(20, 340, 170, 30);
                
            } completion:^(BOOL finished) {
                
            }];
            
        } // contact
        else if (cardID == 14) {
            
            // top of the card
            UIButton *secretButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
            UIImageView *secret = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            secret.layer.masksToBounds = YES;
            secret.layer.cornerRadius = secret.frame.size.width/2;
            secret.image = [UIImage imageNamed:@"easteregg"];
            [secretButton addSubview:secret];
            secretButton.tag = 14;
            [secretButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:secretButton];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 20, 220, 80)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor blackColor];
            name.textAlignment = NSTextAlignmentLeft;
            name.numberOfLines = 0;
            name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:40];
            name.text = @"Secret Card";
            [self addSubview:name];
            
            // step one: create the field
            UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 320)];
            field.editable = NO;
            field.scrollEnabled = NO;
            field.selectable = NO;
            field.dataDetectorTypes = UIDataDetectorTypeAll;
            
            // step two: set up general settings (font, wrapping, etc.)
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.lineSpacing = 2.0f;
            NSDictionary *attrs = @{NSVerticalGlyphFormAttributeName : @1,
                                    NSParagraphStyleAttributeName : paragraph,
                                    NSFontAttributeName : [UIFont fontWithName:@"Futura-Normal" size:25],
                                    };
            
            // step 3: add underlining ranges
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:texts[14] attributes:attrs];
            
            // step 4: add string to field and field to view
            [field setAttributedText:string];
            [self addSubview:field];
            
            // step 5: add gesture recognizer to make the links work. (see handleTapGesture: for that)
            [field addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            
            
            // Next card ->
            UILabel *moreInfo = [[UILabel alloc] initWithFrame:CGRectMake(100, 420, 120, 40)];
            moreInfo.backgroundColor = [UIColor clearColor];
            moreInfo.textColor = [UIColor blackColor];
            moreInfo.textAlignment = NSTextAlignmentCenter;
            moreInfo.numberOfLines = 0;
            moreInfo.font = [UIFont fontWithName:@"Futura-Normal" size:20];
            moreInfo.text = @"alpine";
            [self addSubview:moreInfo];
            
            UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(140, 450, 40, 40)];
            arrow.image = [UIImage imageNamed:@"back"];
            arrow.transform = CGAffineTransformMakeRotation(M_PI);
            [self addSubview:arrow];
            
        } // hidden one
        
        
        // speech setup takes time, so put that in here
        synthesizer = [[AVSpeechSynthesizer alloc] init];
        //[self speakText:@0];
        
    }
    
    return self;
}

- (void)showRemoteView:(id)sender {
    
    [delegate showRemoteView:sender];
    
}

- (void)handleTapGesture:(id)sender {
    
    // forward to delegate
    [delegate handleTapGesture:sender];
    
}

- (void)showAppAlert:(id)sender {
    
    // Link into Niklas and Daniels apps
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Other apps" message:@"So to demonstrate our teamwork we (Daniel, Niklas and I) decided to connect our apps one another. If you've got their apps installed as well you can jump there from here:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Daniel's app", @"Niklas' app", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        NSLog(@"Daniel");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"danielpetri://"]];
        
    } else if (buttonIndex == 2) {
        
        NSLog(@"Niklas");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"nikriek://"]];
    
    }
    
}

// when tapping on the speak button on each card this will turn text to speech
- (void)speakText:(id)sender {
    
    int tag;
    if ([[sender class] isSubclassOfClass:[UIControl class]]) {
        tag = (int)[(UIControl *)sender tag];
    } else {
        tag = [sender intValue];
    }
    
    utterance = [[AVSpeechUtterance alloc] initWithString:[texts objectAtIndex:tag]];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.rate = .3f;
    utterance.preUtteranceDelay = .2f;
    utterance.postUtteranceDelay = .2f;
    [synthesizer speakUtterance:utterance];
    
}

+ (FGCard *)card:(int)cardID delegate:(id <FGCardDelegate>)delegate {
    
    FGCard *card = [[FGCard alloc] initWithCardID:cardID];
    card.delegate = delegate;
    
    return card;
}


@end
