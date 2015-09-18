//
//  FGAirPlayViewController.m
//  Finn Gaida
//
//  Created by Finn Gaida on 04.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

// Credits to:
// Matteo Senesi - Gocce               http://500px.com/photo/50271004
// Anek S - Doi Inthanon National park http://500px.com/photo/57161416
// Daniel Bosma - Blue Hour            http://500px.com/photo/33767065
// David Orias - MG_7511 Trapezoid     http://500px.com/photo/24088985

#define damp 0.5

#import "FGAirPlayViewController.h"
#import "UIImage+ImageEffects.h"

@implementation FGAirPlayViewController {
    
    // shortcuts for screen width and height, just sparing code
    int w;
    int h;
    
    NSArray *texts;
    
    // Managing UIKitDynamics animations
    UIDynamicAnimator *animator;
    UISnapBehavior *snapImg;
    UISnapBehavior *snapTitle;
    UISnapBehavior *snapDesc;
    UISnapBehavior *snapWelcome;
    UISnapBehavior *snapiPhone;
    UIDynamicItemBehavior *imgItem;
    
    // Basic setup views
    UIImageView *bg;
    UILabel *welcome;
    UIImageView *topLeftImage;
    UILabel *title;
    UILabel *description;
    UIImageView *detailImage;
    
    // special setup views
    UIImageView *screenshot1;
    UIImageView *screenshot2;
    
    // Used for navigation
    int currentlyShowing;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super init];
    if (self) {
        
        // basic setup
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor blackColor];
        [self setNeedsStatusBarAppearanceUpdate];
        
        w = self.view.frame.size.width;
        h = self.view.frame.size.height;
        
        texts = @[@"Welcome to my WWDC app!",
                  @"Hi, I'm Finn and this is my WWDC 2015 scholarship application with Apple TV support.",
                  @"Whoa awesome, looks like you got it working! Okay, so this is where you will find additional text to ALL of the links in-app plus some screenshots of my work on  apps. I spent more than 100 hours finetuning this app, but working with something this different complicates the testing process a little bit, so bare with me if loading times are not optimized.\nNow have fun browsing my life! 😉",
                  @"Now that I've got some space here I can write about my expections of WWDC, if I get chosen: I would plan on talking to as many professionals, but also devs of my level and distribute as many busness cards as possible. \nFurther if iOS 8 is released I would try to get down with as many of the new APIs and maybe even start implementing them into my current apps. Still the networking aspect of that week would matter more to me than experiencing the keynote live.",
                  @"I also tried out various methods of selling with SunUp, such as completely free in the beginning, then Freemium with a paid Pro version and since I'm on the paid plan, because the AppStore makes it really easy for users to buy paid apps.\nOh, and here is a screenshot:",
                  @"Funnily enough I won most prizes with the app I put the least work into. After just 24h most of the app was working and we since did lots of improvements, but no major overhaul. ",
                  @"Brightness is also my most downloaded app overall I got just a little more than 5000 downloads this year. SunUp returned similar numbers at the time it was available free of charge, but now numbers have decreased.",
                  @"Alongside the development of YouthEast I came to really appreciate Google's hangout service. Here's a heads up: I know a bunch of people who would immediately switch to FaceTime if it had support for multiple members in one call.",
                  @"I am probably working on FabTap at this very moment, as it's definitely my biggest project yet. If I get selected for WWDC I plan on improving my current code, but also my understanding of the concepts.\nThis is what FabTap looks like:",
                  
                  @"It's incredible how much power establishing connections holds and I first recognised this fact here. I am still in contact with a lot of the attendees on a daily basis and I definitely plan on going again this year. \nAs I was the only one from my area this time I'll bring at least three of my friends that all started coding, because of me. 😄",
                  @"Jorge has given me some advice on how to structure this app and further I've chewed his ears off to get some facts and experiences from last year's WWDC, but all I got was an even stronger urge to go, so here I am.",
                  @"This blurred background image is actually Daniel, Niklas and myself discussing the presence of coding class in local schools and as it turns out many people think, that it should be introduced in all secondary schools, at least. But if so starting way earlier than 10th grade. As a matter of fact this discussion was the reason for me joining Thinkspace Pioneers and thus attending the Jan event (next card).",
                  @"As this was my first time travelling alone abroad I was a little bit scared, but the excitement and thrill about the coming weekend put that to a shame. I started talking to strangers, learning local rules and also a little bit of a british accent, all of which I wouldn't have done if I had somebody travelling with me.\nIn the end I came home with a strengthened self-confidence and feel the need to do it again.",//12
                  @"You can also take a look at some of my designs at http://dribbble.com/finngaida or take a look at my personal website http://finngaida.de. If you wish to take a look at my resume you are free to do so at http://finngaida.de/resume.pdf. ",
                  @"Oh, yeah, looks like you found the secret card. Now what this card enables you to do is laugh really hard, but that's about it... Anyways here's a picture of doge: ",
                  
                  @"Whoa awesome, looks like you got it working! Okay, so this is where you will find additional text to ALL of the links in-app plus some screenshots of my work on  apps. They will appear right here where this placeholder sits. I spent more than 60 hours finetuning this app, but working with something this different hardens the testing process a little bit, so bare with me if loading times are not optimized.\nNow have fun browsing my life! 😉",
                  @"These magazines like Chip or ComputerBILD were german, but contained a lot of the english technology terms, so that got me into the scene pretty quickly...",
                  @"At first I only came across german tech sites, such as apfelpage.de or apfeleimer.de, but by time I got to know 9to5Mac, iDownloadBlog, TUAW and so on. Today I prefer reading through hacker news and reddit, but I also have a regular read on Medium.",
                  @"In germany you don't really graduate, but you get this certificate called \"Abitur\" which is needed for pretty much any good job.",
                  @"Back when I released the first version of SunUp on the AppStore is was a barebone app and pretty embarrassing from my current point of view, but anyways, this was the first AppStore screenshot.",
                  @"With the 2.0 update, I improved a lot of things, one of which was the ability to set themes and custom ringtones. It's pretty much a completely new app.",
                  @"In order to get SunUp the interface it deserves I pretty much digged through all of UIKit's classes, such as switches, sliders, containers, labels and so on.",
                  @"Motion is cool. Nothing else to say.",
                  @"I went through a lot of ideas trying to figure out the best way of waking up the user, but I don't feel like I found it yet... Apparently there is no non-hacky way for developers to bypass the mute switch which gave me some bad reviews on the AppStore, because SunUp didn't ring.",
                  @"AVSpeechSynthesizer for the win!",
                  @"As one of the selling methods I tried out on SunUp, I also got to learn the concepts of in-app purchases, but I quickly recognized that this method isn't suited for my amount of users and so I switched to the paid plan.",
                  @"If you tap on the icon of PlateCollect in the upper left corner of this card you will get prompted to open one of their apps. We decided to build this feature in as a sign of our teamwork.\nDaniel is a very amibitious and engaged iOS developer, who most definitely saved our prize at the event with his knowledge of Python.",
                  @"Same goes for Niklas, tap on the upper left image to release the dragon.\nNiklas is the single most professional iOS dev I came across these days and he is just about to go do some internships. Check out his app for the WWDC as well!",
                  @"Stolpersteine are small golden plates, buried into the ground in front of the residences of former victims of the holocaust. This project was initiated by a man called Gunter Demnig and they shall help remembering the times of the holocaust.",
                  @"Since I made the control for the about view of Brightness public on GitHub I am fan of open-source software and try to contribute to as many projects I use as possible.",
                  @"Jordan is a designer from Belfast, but I often think of him as an ideal. He is passionate yet professional at managing companies like Thinkspace and Pioneers and I imagine he will someday found his own company. You can reach him @jte on twitter.",
                  @"",
                  @"Colton is a really young developer from the united states who I came to work with via YouthEast. He is very eager to learn and always on the run to improve himself. He is @iColtonAnglin on twitter.",
                  @"Jonathan is also applying for a scholarship this year and he is the only one I know of who is building a Mac OS X app. he's @jfkingsley on twitter.",
                  @"I went to school with Rico since the first grade and since he does Android development and I do iOS we teamed up to build FabTap, a small game for iOS aiming to be ready for the AppStore this summer.",
                  @"This is not really interesting, as it won't be viewed, but I'll write something anyways.",
                  @"Marcel is a front-end iOS developer and I came to finally meet him at Jugend Hackt after having chatted with him for months on twitter. It's really a nice feeling to have somebody there that does the same as you do and that you can ask questions, which your 'normal' friends would answer with: \"WHAT?!?\"",
                  @"Young Rewired State is an awesome organization from the UK organizing weekend hackathons for young developers in their local youth clubs.\nIn 2013 they expanded into europe and Jugend Hackt was their german branch where I came to meet Daniel and Niklas.",
                  @"Robert asked us three to jump on board with *bliep, a dutch phone provider who is run in most instances by people at the age of 21 and under. At the moment we are the german representatives, but in the future, we'll possibly be leading the german branch.",
                  @"When I recieved a letter whose sender was nobody else that the European Parliament I felt a little strange, but that feeling turned into pure happiness after having read that I was invited to the ICT.",
                  @"Jorge has 6 apps on the AppStore and won a scholarship to WWDC last year. We had a lot of fun together in Vilnius and the following days.",
                  @"The Movie is available at ",
                  @"Thinkspace is a UK-based non-profit organization that wants schools from all over the world to install so-called 'Thinkspaces' in their buildings that look very similar to silicon valley oragnizations' headquarters.",
                  @"With Pioneers, if you want to start a project you simply have to drop a line in the Slack chat and after 10 minutes you will have 3 people lining up to join your team, which pretty much represents the spirit of the team.",
                  @"The hackathon was only about three hours and we didn't really come up with a notable idea, but it was still really cool sitting down in front of a command line and XCode knowing that everybody else in the room would do the exact same thing.",
                  @"Max Kramer is a London based iOS developer who already worked with several clients and thus may safely be called a professional at his expertise.",
                  @"Actually Jugend Hackt 3.0 is in the making and I help organizing one of the events that is being held in the north of Germany. We have a very good connection to the hosts and every once in a while we meet them someplace cool, for example at the 2014 31c3 - an international hacker convention in Hammburg.",
                  @"What I find coolest about *bliep is the fact that although it is a professional telecom provider, it really just feels like a really friendly startup from Silicon Valley. The people are really kind and always up for a joke and their Headquarters are used for all kinds of skating, table tennis and whatnot.",
                  @"In 2012 we recieved a lot of attention with PlateCollect, as it also played a role in the political debate, but with Kolumbus this didn't happen. In early 2015 we got an offer though from people who might be interested in applying the concept to their region.",
                  @"When I first sat down at my office at apprupt I immediately felt home, simply because XCode just looks and feels the same everywhere. It took me some time to understand the concepts of the codebase, but once that was done I could dive right into it.",
                  @"As it appears I am the only student of my school who is interested in iOS development. That doesn't mean that there is no interest in coding at all, we even have a teacher-hosted coding workshop every week and coding class from grade 11.",
                  @"Although I learned a lot at DESY I liked my internship at apprupt way more, because I had a task. At DESY I was just one of many visitors, but there I really became part of the team and was treated like so, already after the first few days.", @"", @"", @"", @"", @"", @"", @"", @""
                  ];
        
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; // shortcut
        [nc addObserver:self selector:@selector(showView:) name:@"showRemoteView" object:nil];
        
        // Setup the golden gate as blurred background
        bg = [[UIImageView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:bg];
        
        bg.image = [UIImage imageNamed:@"aggb.jpg"];
        
        
        // Welcome title
        welcome = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        welcome.backgroundColor = [UIColor clearColor];
        welcome.textColor = [UIColor whiteColor];
        welcome.textAlignment = NSTextAlignmentCenter;
        welcome.numberOfLines = 0;
        welcome.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:w/12];
        welcome.text = @"Welcome to my WWDC app!";
        [self.view addSubview:welcome];
        
        // At this time unused circular icon in the top left corner
        topLeftImage = [[UIImageView alloc] initWithFrame:CGRectMake(-w/5, 220, w/10, w/10)];
        topLeftImage.layer.masksToBounds = YES;
        topLeftImage.layer.cornerRadius = topLeftImage.frame.size.width/2;
        [self.view addSubview:topLeftImage];
        
        // The Futura title of every section
        title = [[UILabel alloc] initWithFrame:CGRectMake(w, 220, w*0.8, w/5)];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.numberOfLines = 0;
        title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
        title.text = @"Finn Gaida";
        [self.view addSubview:title];
        
        // A more detailed text about what is currently shown
        description = [[UILabel alloc] initWithFrame:CGRectMake(0, h, w*0.5, h*0.9)];
        description.backgroundColor = [UIColor clearColor];
        description.textColor = [UIColor whiteColor];
        description.textAlignment = NSTextAlignmentLeft;
        description.numberOfLines = 0;
        description.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        [self.view addSubview:description];
        
        // mostly iphone image view - shall not be resized
        detailImage = [[UIImageView alloc] initWithFrame:CGRectMake(w, h/2, w*0.2, w*0.4)];
        [self.view addSubview:detailImage];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (void)showView:(id)sender {
    
    int identifier = 0;

    if ([[(NSNotification *)sender object] respondsToSelector:@selector(tag)]) {
        identifier = (int)[[(NSNotification *)sender object] tag];
    }
    
    if (identifier != currentlyShowing) {
        
        // remove currently showing views dynamically
        [animator removeAllBehaviors];
        
        // snap all views outside of the screen
        snapImg = [[UISnapBehavior alloc] initWithItem:topLeftImage snapToPoint:CGPointMake(-w/2, w/13)];
        snapTitle = [[UISnapBehavior alloc] initWithItem:title snapToPoint:CGPointMake(w*0.75, -w/12)];
        snapDesc = [[UISnapBehavior alloc] initWithItem:description snapToPoint:CGPointMake(w*0.3, h*2)];
        snapWelcome = [[UISnapBehavior alloc] initWithItem:welcome snapToPoint:CGPointMake(w*0.5, -h*2)];
        snapiPhone = [[UISnapBehavior alloc] initWithItem:detailImage snapToPoint:CGPointMake(w*1.5, h*1.5)];
        
        imgItem = [[UIDynamicItemBehavior alloc] initWithItems:@[topLeftImage, title, description, detailImage]];
        imgItem.resistance = 1-damp;
        
        [animator addBehavior:imgItem];
        [animator addBehavior:snapImg];
        [animator addBehavior:snapTitle];
        [animator addBehavior:snapDesc];
        [animator addBehavior:snapWelcome];
        [animator addBehavior:snapiPhone];
        
        
        // Image variable to be set to the bg afterwards
        UIImage __block *newImg;
        
        // and animate the new ones in
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            if (identifier == 1 && currentlyShowing != 1) {
                
                topLeftImage.image = [UIImage imageNamed:@"ame"];
                title.text = @"Finn Gaida";
                description.text = texts[1];
                detailImage.image = [UIImage imageNamed:@"afinng0"];
                newImg = [UIImage imageNamed:@"aggb.jpg"];
                
            } else if (identifier == 2 && currentlyShowing != 2) {
                
                topLeftImage.image = [UIImage imageNamed:@"awwdc"];
                title.text = @"About this app";
                description.text = texts[2];
                detailImage.image = [UIImage imageNamed:@"afinng0"];
                newImg = [UIImage imageNamed:@"aaboutBG.jpg"];
                
            } else if (identifier == 3 && currentlyShowing != 3) {
                
                topLeftImage.image = [UIImage imageNamed:@"ame2.jpg"];
                title.text = @"More about me";
                description.text = texts[3];
                detailImage.image = [UIImage imageNamed:@"afinng0"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 4 && currentlyShowing != 4) {
                
                topLeftImage.image = [UIImage imageNamed:@"asunup"];
                title.text = @"SunUp";
                description.text = texts[4];
                detailImage.image = [UIImage imageNamed:@"asunup1"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 5 && currentlyShowing != 5) {
                
                topLeftImage.image = [UIImage imageNamed:@"astumbler"];
                title.text = @"PlateCollect";
                description.text = texts[5];
                detailImage.image = [UIImage imageNamed:@"astumbler1"];
                newImg = [UIImage imageNamed:@"astumblerBG.jpg"];
                
            } else if (identifier == 6 && currentlyShowing != 6) {
                
                topLeftImage.image = [UIImage imageNamed:@"abrightness"];
                title.text = @"Brightness";
                description.text = texts[6];
                detailImage.image = [UIImage imageNamed:@"abrightness1"];
                newImg = [UIImage imageNamed:@"abrightnessBG.jpg"];
                
            } else if (identifier == 7 && currentlyShowing != 7) {
                
                topLeftImage.image = [UIImage imageNamed:@"ayoutheast"];
                title.text = @"YouthEast";
                description.text = texts[7];
                detailImage.image = [UIImage imageNamed:@"ayoutheast0"];
                newImg = [UIImage imageNamed:@"ayoutheastBG.jpg"];
                
            } else if (identifier == 8 && currentlyShowing != 8) {
                
                topLeftImage.image = [UIImage imageNamed:@"afabtap"];
                title.text = @"FabTap";
                description.text = texts[8];
                detailImage.image = [UIImage imageNamed:@"afabtap1"];
                newImg = [UIImage imageNamed:@"afabtapBG.jpg"];
                
            } else if (identifier == 9 && currentlyShowing != 9) {
                
                topLeftImage.image = [UIImage imageNamed:@"ajugendhackt.jpg"];
                title.text = @"Jugend Hackt";
                description.text = texts[9];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"ajugendhacktBG.jpg"];
                
            } else if (identifier == 10 && currentlyShowing != 10) {
                
                topLeftImage.image = [UIImage imageNamed:@"aict.JPG"];
                title.text = @"ICT 2013";
                description.text = texts[10];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"aictBG.jpg"];
                
            } else if (identifier == 11 && currentlyShowing != 11) {
                
                topLeftImage.image = [UIImage imageNamed:@"azugang.jpg"];
                title.text = @"Zugang Gestalten";
                description.text = texts[11];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"azugangBG.jpg"];
                
            } else if (identifier == 12 && currentlyShowing != 12) {
                
                topLeftImage.image = [UIImage imageNamed:@"apioneers.jpg"];
                title.text = @"Pioneers London";
                description.text = texts[12];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"apioneersBG.jpg"];
                
            } else if (identifier == 13 && currentlyShowing != 13) {
                
                topLeftImage.image = [UIImage imageNamed:@"ame2.jpg"];
                title.text = @"Contact";
                description.text = texts[13];
                detailImage.image = [UIImage imageNamed:@"afinng0"];
                newImg = [UIImage imageNamed:@"aggb.jpg"];
                
            } else if (identifier == 14 && currentlyShowing != 14) {
                
                topLeftImage.image = [UIImage imageNamed:@"ame2.jpg"];
                title.text = @"Secret Card";
                description.text = texts[14];
                detailImage.image = [UIImage imageNamed:@"awindoge0"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 15 && currentlyShowing != 15) {
                
                topLeftImage.image = [UIImage imageNamed:@"ame2.jpg"];
                title.text = @"Intro";
                description.text = texts[15];
                detailImage.image = [UIImage imageNamed:@"afinng0"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 16 && currentlyShowing != 16) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Magazines";
                description.text = texts[16];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 17 && currentlyShowing != 17) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Blogs";
                description.text = texts[17];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 18 && currentlyShowing != 18) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Abitur";
                description.text = texts[18];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 19 && currentlyShowing != 19) {
                
                topLeftImage.image = [UIImage imageNamed:@"asunup"];
                title.text = @"SunUp 1.0";
                description.text = texts[19];
                detailImage.image = [UIImage imageNamed:@"asunup1"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 20 && currentlyShowing != 20) {
                
                topLeftImage.image = [UIImage imageNamed:@"asunup"];
                title.text = @"SunUp 2.0";
                description.text = texts[20];
                detailImage.image = [UIImage imageNamed:@"asunup2"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 21 && currentlyShowing != 21) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"UIKit classes";
                description.text = texts[21];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 22 && currentlyShowing != 22) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Motion Effects";
                description.text = texts[22];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 23 && currentlyShowing != 23) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Local Notifications";
                description.text = texts[23];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 24 && currentlyShowing != 24) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Sounds";
                description.text = texts[24];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 25 && currentlyShowing != 25) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"In-App purchases";
                description.text = texts[25];
                detailImage.image = [UIImage imageNamed:@"ain-app"];
                newImg = [UIImage imageNamed:@"asunupBG.jpg"];
                
            } else if (identifier == 26 && currentlyShowing != 26) {
                
                topLeftImage.image = [UIImage imageNamed:@"apetri.jpg"];
                title.text = @"Daniel Petri";
                description.text = texts[26];
                detailImage.image = [UIImage imageNamed:@"astumbler0"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 27 && currentlyShowing != 27) {
                
                topLeftImage.image = [UIImage imageNamed:@"arieke.jpg"];
                title.text = @"Niklas Riekenbrauck";
                description.text = texts[27];
                detailImage.image = [UIImage imageNamed:@"astumbler0"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 28 && currentlyShowing != 28) {
                
                topLeftImage.image = [UIImage imageNamed:@"astumbler"];
                title.text = @"Stolpersteine";
                description.text = texts[28];
                detailImage.image = [UIImage imageNamed:@"astolpersteine.jpg"];
                newImg = [UIImage imageNamed:@"astumblerBG.jpg"];
                
            } else if (identifier == 29 && currentlyShowing != 29) {
                
                topLeftImage.image = [UIImage imageNamed:@"abrightness"];
                title.text = @"More Designs";
                description.text = texts[29];
                detailImage.image = [UIImage imageNamed:@"abrightness0"];
                newImg = [UIImage imageNamed:@"abrightnessBG.jpg"];
                
            } else if (identifier == 30 && currentlyShowing != 30) {
                
                topLeftImage.image = [UIImage imageNamed:@"aearle.jpg"];
                title.text = @"Jordan Earle";
                description.text = texts[30];
                detailImage.image = [UIImage imageNamed:@"ayoutheast0"];
                newImg = [UIImage imageNamed:@"ayoutheastBG.jpg"];
                
            } else if (identifier == 32 && currentlyShowing != 32) {
                
                topLeftImage.image = [UIImage imageNamed:@"aanglin"];
                title.text = @"Colton Anglin";
                description.text = texts[32];
                detailImage.image = [UIImage imageNamed:@"ayoutheast0"];
                newImg = [UIImage imageNamed:@"ayoutheastBG.jpg"];
                
            } else if (identifier == 33 && currentlyShowing != 33) {
                
                topLeftImage.image = [UIImage imageNamed:@"akingsley.jpg"];
                title.text = @"Jonathan Kingsley";
                description.text = texts[33];
                detailImage.image = [UIImage imageNamed:@"ayoutheast0"];
                newImg = [UIImage imageNamed:@"ayoutheastBG.jpg"];
                
            } else if (identifier == 34 && currentlyShowing != 34) {
                
                topLeftImage.image = [UIImage imageNamed:@"aklimpel.jpg"];
                title.text = @"Rico Klimpel";
                description.text = texts[34];
                detailImage.image = [UIImage imageNamed:@"afabtap0"];
                newImg = [UIImage imageNamed:@"afabtapBG.jpg"];
                
            } else if (identifier == 35 && currentlyShowing != 35) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Push";
                description.text = texts[35];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"amoreBG.jpg"];
                
            } else if (identifier == 36 && currentlyShowing != 36) {
                
                topLeftImage.image = [UIImage imageNamed:@"avoss.jpg"];
                title.text = @"Marcel Voss";
                description.text = texts[36];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"ajugendhacktBG.jpg"];
                
            } else if (identifier == 37 && currentlyShowing != 37) {
                
                topLeftImage.image = [UIImage imageNamed:@"ayrs"];
                title.text = @"Young Rewired";
                description.text = texts[37];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"ajugendhacktBG.jpg"];
                
            } else if (identifier == 38 && currentlyShowing != 38) {
                
                topLeftImage.image = [UIImage imageNamed:@"ahoesel.jpg"];
                title.text = @"Robert van Hoesel";
                description.text = texts[38];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"ajugendhacktBG.jpg"];
                
            } else if (identifier == 39 && currentlyShowing != 39) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Parliament";
                description.text = texts[39];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"aictBG.jpg"];
                
            } else if (identifier == 40 && currentlyShowing != 40) {
                
                topLeftImage.image = [UIImage imageNamed:@"aizqui.jpg"];
                title.text = @"Jorge Izquierdo";
                description.text = texts[40];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"aictBG.jpg"];
                
            } else if (identifier == 41 && currentlyShowing != 41) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Movie";
                description.text = texts[41];
                detailImage.image = [UIImage imageNamed:@"amovie0"];
                newImg = [UIImage imageNamed:@"azugangBG.jpg"];
                
            } else if (identifier == 42 && currentlyShowing != 42) {
                
                topLeftImage.image = [UIImage imageNamed:@"athinkspace.jpg"];
                title.text = @"Thinkspace";
                description.text = texts[42];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"apioneersBG.jpg"];
                
            } else if (identifier == 43 && currentlyShowing != 43) {
                
                topLeftImage.image = [UIImage imageNamed:@"apioneers.jpg"];
                title.text = @"Pioneers";
                description.text = texts[43];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"apioneersBG.jpg"];
                
            } else if (identifier == 44 && currentlyShowing != 44) {
                
                topLeftImage.image = [UIImage imageNamed:@"a"];
                title.text = @"Hackathon";
                description.text = texts[44];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"apioneersBG.jpg"];
                
            } else if (identifier == 45 && currentlyShowing != 45) {
                
                topLeftImage.image = [UIImage imageNamed:@"akramer.jpg"];
                title.text = @"Max Kramer";
                description.text = texts[45];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"apioneersBG.jpg"];
                
            } else if (identifier == 46 && currentlyShowing != 46) {
                
                topLeftImage.image = [UIImage imageNamed:@"ajugendhackt.jpg"];
                title.text = @"Jugend Hackt 2.0";
                description.text = texts[46];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"ajugendhackt.jpg"];
                
            } else if (identifier == 47 && currentlyShowing != 47) {
                
                topLeftImage.image = [UIImage imageNamed:@"Bliep.jpg"];
                title.text = @"*bliep";
                description.text = texts[47];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"Spider.jpg"];
                
            } else if (identifier == 48 && currentlyShowing != 48) {
                
                topLeftImage.image = [UIImage imageNamed:@"Kolumbus"];
                title.text = @"Kolumbus";
                description.text = texts[48];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"Flower.jpg"];
                
            } else if (identifier == 49 && currentlyShowing != 49) {
                
                topLeftImage.image = [UIImage imageNamed:@"apprupt"];
                title.text = @"apprupt";
                description.text = texts[49];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"Spider.jpg"];
                
            } else if (identifier == 50 && currentlyShowing != 50) {
                
                topLeftImage.image = [UIImage imageNamed:@"alstergym.jpg"];
                title.text = @"Alstergymnasium";
                description.text = texts[50];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"alstergym.jpg"];
                
            } else if (identifier == 51 && currentlyShowing != 51) {
                
                topLeftImage.image = [UIImage imageNamed:@"desy.jpg"];
                title.text = @"Internships";
                description.text = texts[51];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"Spider.jpg"];
                
            } else if (identifier == 52 && currentlyShowing != 52) {
                
                topLeftImage.image = [UIImage imageNamed:@"family"];
                title.text = @"Personal Interests";
                description.text = texts[52];
                detailImage.image = [UIImage imageNamed:@"a"];
                newImg = [UIImage imageNamed:@"Flower.jpg"];
                
            }
            
            
            /*/ add screenshots to remote view if it's the fabtap screen
            if (identifier == 46) {
                
                screenshot1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, h, w*0.2, w*0.4)];
                screenshot2 = [[UIImageView alloc] initWithFrame:CGRectMake(w*0.37, h, w*0.2, w*0.4)];
                
                screenshot1.image = [UIImage imageNamed:@"afabtap1"];
                screenshot2.image = [UIImage imageNamed:@"afabtap2"];
                
                [self.view addSubview:screenshot1];
                [self.view addSubview:screenshot2];
                
                [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                
                    screenshot1.center = CGPointMake(w*0.2, h*0.6);
                    screenshot2.center = CGPointMake(w*0.5, h*0.6);
                    
                } completion:^(BOOL finished) {
                    
                }];
                
            } else {
                
                [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                    
                    screenshot1.center = CGPointMake(0, h*2);
                    screenshot2.center = CGPointMake(w*0.5, h*2);
                    
                } completion:^(BOOL finished) {
                
                    [screenshot1 removeFromSuperview];
                    [screenshot2 removeFromSuperview];
                    
                }];
                
                
            }       //*/
            
            
            [animator removeAllBehaviors];
            
            snapImg = [[UISnapBehavior alloc] initWithItem:topLeftImage snapToPoint:CGPointMake(w/13, w/13)];
            snapTitle = [[UISnapBehavior alloc] initWithItem:title snapToPoint:CGPointMake(w*0.6, w/12)];
            snapDesc = [[UISnapBehavior alloc] initWithItem:description snapToPoint:CGPointMake(w*0.35, h*0.6)];
            snapiPhone = [[UISnapBehavior alloc] initWithItem:detailImage snapToPoint:CGPointMake(w*0.8, h*0.6)];
            
            imgItem = [[UIDynamicItemBehavior alloc] initWithItems:@[topLeftImage, title, description, detailImage]];
            imgItem.resistance = 1-damp;
            
            [animator addBehavior:imgItem];
            [animator addBehavior:snapImg];
            [animator addBehavior:snapTitle];
            [animator addBehavior:snapDesc];
            [animator addBehavior:snapiPhone];
            [animator addBehavior:snapWelcome];
            
            
            currentlyShowing = identifier;
            
            bg.image = [newImg applyBlurWithRadius:20 tintColor:[UIColor colorWithWhite:0 alpha:.2] saturationDeltaFactor:1 maskImage:nil];
            
        });
        
    }
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
