//
//  FGViewController.m
//  Finn
//
//  Created by Finn Gaida on 03.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import "FGViewController.h"

@implementation FGViewController {
    
    // three menu buttons at the top of the screen indication the sections
    UIButton *about;
    UIButton *work;
    UIButton *events;
    
    // cutomized label on those buttons
    UILabel *aboutLabel;
    UILabel *workLabel;
    UILabel *eventsLabel;
    UIView *indicator;
    
    // general
    UIScrollView *cardScroll;
    
    // about section
    FGCard *card1;
    FGCard *card2;
    FGCard *card3;
    
    // work section
    FGCard *card4;
    FGCard *card5;
    FGCard *card6;
    FGCard *card7;
    FGCard *card8;
    
    // events section
    FGCard *card9;
    FGCard *card10;
    FGCard *card11;
    FGCard *card12;
    
    // contact
    FGCard *card13;
    FGCard *card14;
    
    // these are used for navigation purposes
    int selectedTab;
    int selectedCard;
    BOOL needsLightStatusBar;
    
    // for the speeches
    AVSpeechSynthesizer *synthesizer;
    AVSpeechUtterance *utterance;
    NSArray *texts;
    int h;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // set the statusbar to white
    needsLightStatusBar = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Basic setup
    h = (IS_IPHONE_5) ? 568 : 480;
    self.view.backgroundColor = [UIColor colorWithWhite:.1 alpha:1];
    selectedTab = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToCard:) name:@"showCard" object:nil];
    
    if ([UIScreen mainScreen].bounds.size.height < 500) {
        
        // Let 3.5" users know that they should update
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey there!" message:@"This app has been developed to be run on a 4\" device, such as an iPhone 5/5c/5s. it might look strange on this device, so please consider using another one!" delegate:Nil cancelButtonTitle:@"I will" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    // section navigation menu setup
    {
        about = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 50)];
        about.tag = 1;
        [about addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
        aboutLabel = [[UILabel alloc] initWithFrame:about.frame];
        aboutLabel.backgroundColor = [UIColor clearColor];
        aboutLabel.textColor = [UIColor whiteColor];
        aboutLabel.textAlignment = NSTextAlignmentCenter;
        aboutLabel.font = [UIFont fontWithName:@"Futura-Normal" size:20];
        aboutLabel.text = @"ABOUT";
        [self.view addSubview:aboutLabel];
        
        work = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 120, 50)];
        work.tag = 2;
        [work addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
        workLabel = [[UILabel alloc] initWithFrame:work.frame];
        workLabel.backgroundColor = [UIColor clearColor];
        workLabel.textColor = [UIColor grayColor];
        workLabel.textAlignment = NSTextAlignmentCenter;
        workLabel.font = [UIFont fontWithName:@"Futura-Normal" size:20];
        workLabel.text = @"WORK";
        [self.view addSubview:workLabel];
        
        events = [[UIButton alloc] initWithFrame:CGRectMake(220, 20, 80, 50)];
        events.tag = 3;
        [events addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchUpInside];
        eventsLabel = [[UILabel alloc] initWithFrame:events.frame];
        eventsLabel.backgroundColor = [UIColor clearColor];
        eventsLabel.textColor = [UIColor grayColor];
        eventsLabel.textAlignment = NSTextAlignmentCenter;
        eventsLabel.font = [UIFont fontWithName:@"Futura-Normal" size:20];
        eventsLabel.text = @"EVENTS";
        [self.view addSubview:eventsLabel];
        
        indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 0, 3)];
        indicator.backgroundColor = [UIColor colorWithWhite:.5 alpha:1];
        indicator.layer.masksToBounds = YES;
        indicator.layer.cornerRadius = 2;
        [self.view addSubview:indicator];
    }
    
    // add a logo onto the background that becomes visible if you scroll down far enough on the first card
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(129, 150, 62, 102)];
    logo.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logo];
    
    
    // Inheriting the UIScrollView's desceleration methods
    cardScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, h)];
    cardScroll.contentSize= CGSizeMake(320, h+1);
    cardScroll.delegate = self;
    [self.view addSubview:cardScroll];
    
    // cards setup - pain in the ass
    card1 = [FGCard card:1 delegate:self];
    [cardScroll addSubview:card1];
    
    card2 = [FGCard card:2 delegate:self];
    card3 = [FGCard card:3 delegate:self];
    card4 = [FGCard card:4 delegate:self];
    card5 = [FGCard card:5 delegate:self];
    card6 = [FGCard card:6 delegate:self];
    card7 = [FGCard card:7 delegate:self];
    card8 = [FGCard card:8 delegate:self];
    card9 = [FGCard card:9 delegate:self];
    card10 = [FGCard card:10 delegate:self];
    card11 = [FGCard card:11 delegate:self];
    card12 = [FGCard card:12 delegate:self];
    card13 = [FGCard card:13 delegate:self];
    card14 = [FGCard card:14 delegate:self];
    
    [self performSelector:@selector(addOtherCards) withObject:nil afterDelay:.5];

    
    // add buttons, so they are on top
    [self.view addSubview:about];
    [self.view addSubview:work];
    [self.view addSubview:events];
    
    // thow in the first card
    [self goToCard:1];
    
}

- (void)addOtherCards {
    
    [cardScroll addSubview:card2];
    [cardScroll addSubview:card3];
    [cardScroll addSubview:card4];
    [cardScroll addSubview:card5];
    [cardScroll addSubview:card6];
    [cardScroll addSubview:card7];
    [cardScroll addSubview:card8];
    [cardScroll addSubview:card9];
    [cardScroll addSubview:card10];
    [cardScroll addSubview:card11];
    [cardScroll addSubview:card12];
    [cardScroll addSubview:card13];
    [cardScroll addSubview:card14];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder]; // for the shake gesture
}


// universal method to go to a specific card
- (void)goToCard:(int)card {
    
    // explanation is only in the first statement
    if (card == 1) {
        
        // simultaneously animate all cards out (so that the currently visible one is gone) and animate card numeró uno in
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 1;
            
            // also take care of the top menu button colors if the sections change
            aboutLabel.textColor = [UIColor whiteColor];
            workLabel.textColor = [UIColor grayColor];
            eventsLabel.textColor = [UIColor grayColor];
            
            card1.center = CGPointMake(160, h/2+40);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
            
            
        }];
        
        selectedCard = 1;
        
    } else if (card == 2) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h/2+40);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        selectedCard = 2;
        
    } else if (card == 3) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 1;
            aboutLabel.textColor = [UIColor whiteColor];
            workLabel.textColor = [UIColor grayColor];
            eventsLabel.textColor = [UIColor grayColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h/2+40);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        selectedCard = 3;
        
    } else if (card == 4) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 2;
            aboutLabel.textColor = [UIColor grayColor];
            workLabel.textColor = [UIColor whiteColor];
            eventsLabel.textColor = [UIColor grayColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h/2+40);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        selectedCard = 4;
        
    } else if (card == 5) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h/2+40);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
        
            
        }];
        
        selectedCard = 5;
        
    } else if (card == 6) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h/2+40);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            

            
        }];
        
        selectedCard = 6;
        
    } else if (card == 7) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h/2+40);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
        
            
        }];
        
        selectedCard = 7;
        
    } else if (card == 8) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 2;
            aboutLabel.textColor = [UIColor grayColor];
            workLabel.textColor = [UIColor whiteColor];
            eventsLabel.textColor = [UIColor grayColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h/2+40);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
        
            
        }];
        
        selectedCard = 8;
        
    } else if (card == 9) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 3;
            aboutLabel.textColor = [UIColor grayColor];
            workLabel.textColor = [UIColor grayColor];
            eventsLabel.textColor = [UIColor whiteColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h/2+40);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        selectedCard = 9;
        
    } else if (card == 10) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h/2+40);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        selectedCard = 10;
        
    } else if (card == 11) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h/2+40);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        selectedCard = 11;
        
    } else if (card == 12) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 3;
            aboutLabel.textColor = [UIColor grayColor];
            workLabel.textColor = [UIColor grayColor];
            eventsLabel.textColor = [UIColor whiteColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h/2+40);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        selectedCard = 12;
        
    } else if (card == 13) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 3;
            aboutLabel.textColor = [UIColor grayColor];
            workLabel.textColor = [UIColor grayColor];
            eventsLabel.textColor = [UIColor whiteColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h/2+40);
            card14.center = CGPointMake(160, h*2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        selectedCard = 13;
        
    } else if (card == 14) {
        
        [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            
            selectedTab = 3;
            aboutLabel.textColor = [UIColor grayColor];
            workLabel.textColor = [UIColor grayColor];
            eventsLabel.textColor = [UIColor grayColor];
            
            card1.center = CGPointMake(160, h*2);
            card2.center = CGPointMake(160, h*2);
            card3.center = CGPointMake(160, h*2);
            card4.center = CGPointMake(160, h*2);
            card5.center = CGPointMake(160, h*2);
            card6.center = CGPointMake(160, h*2);
            card7.center = CGPointMake(160, h*2);
            card8.center = CGPointMake(160, h*2);
            card9.center = CGPointMake(160, h*2);
            card10.center = CGPointMake(160, h*2);
            card11.center = CGPointMake(160, h*2);
            card12.center = CGPointMake(160, h*2);
            card13.center = CGPointMake(160, h*2);
            card14.center = CGPointMake(160, h/2+40);
            
        } completion:^(BOOL finished) {
            
        }];
        
        selectedCard = 13;
        
    }
    
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:damp initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        indicator.frame = CGRectMake(0, 76, 320/12*card, 3);
        
    } completion:^(BOOL finished) {
        
    }];
    
    // automatically show new info on remote screen
    if (card != 1 && card != 13 && card != 14) {
        UIControl *sender = [UIControl new];
        sender.tag = card;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showRemoteView" object:sender];
    }
}

// tapping on one of the top buttons calls this
- (void)changeTab:(UIButton *)sender {
    
    if (sender.tag == 1) {
        
        [self goToCard:1];
        
    } else if (sender.tag == 2) {
        
        [self goToCard:4];
        
    } else if (sender.tag == 3) {
        
        [self goToCard:9];
        
    }
    
}

// making the statusbar white or black
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    
    needsLightStatusBar = !(y>70);
    [self setNeedsStatusBarAppearanceUpdate];
    
}

// switch to upper or lower card on edgedrag
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat y = scrollView.contentOffset.y;
    
    [scrollView setDecelerationRate:0];
    
    if (y>60 && selectedCard != 13) {
        [self goToCard:selectedCard+1];
    } else if (y<-60 && selectedCard != 1) {
        [self goToCard:selectedCard-1];
    }
    
}

// Calling into FGAirplayVC
- (void)showRemoteView:(id)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"showRemoteView" object:sender];
    
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

// called every time a word on the textview was tapped, implements hyperlinks
- (void)handleTapGesture:(UITapGestureRecognizer *)tap {

    // recieve the textView
    UITextView *textView = (UITextView *)tap.view;
    
    // get the range of the closest word
    CGPoint location = [tap locationInView:textView];
    UITextPosition *tapPosition = [textView closestPositionToPoint:location];
    UITextRange *textRange = [textView.tokenizer rangeEnclosingPosition:tapPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    NSString *tappedString = [textView textInRange:textRange];
    
    UIControl *sender = [UIControl new];
    
    if ([UIScreen screens].count == 1) {
        
        // please connect to an Apple TV
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey you!" message:@"Yeah you, I suppose you have an Apple TV somewhere around, because you work at Apple and that's what you do 😉. So please connect it now and enable AirPlay Mirroring to see the contents of this link." delegate:nil cancelButtonTitle:@"I will" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    // handle it
    if ([tappedString isEqual:@"link"]) { // twice

        sender.tag = 15;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"tech"] || [tappedString isEqual:@"magazines"]) {
        
        sender.tag = 16;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"reading"] /*twice*/ || [tappedString isEqual:@"blogs"]) {
        
        sender.tag = 17;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"SunUp"]) {
        
        [self goToCard:4];
        
    } else if ([tappedString isEqual:@"graduate"]) {
        
        sender.tag = 18;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"version"] || [tappedString isEqual:@"1.0"]) {
        
        sender.tag = 19;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"update"] /*twice*/ || [tappedString isEqual:@"2.0"]) {
        
        sender.tag = 20;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"UIKit"] /*twice*/ || [tappedString isEqual:@"classes"]) {
        
        sender.tag = 21;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"motion"] || [tappedString isEqual:@"effects"]) {
        
        sender.tag = 22;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"local"] || [tappedString isEqual:@"notifications"]) { //twice
        
        sender.tag = 23;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"sounds"]) {
        
        sender.tag = 24;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"app"] || [tappedString isEqual:@"purchases"]) {
        
        sender.tag = 25;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Jugend"] || [tappedString isEqual:@"Hackt"]) {
        
        [self goToCard:9];
        
    } else if ([tappedString isEqual:@"Daniel"] || [tappedString isEqual:@"Petri"]) {
        
        sender.tag = 26;
        [self showRemoteView:sender];
    
    } else if ([tappedString isEqual:@"Niklas"] || [tappedString isEqual:@"Riekenbrauck"]) {
        
        sender.tag = 27;
        [self showRemoteView:sender];
    
    } else if ([tappedString isEqual:@"Stolpersteine"]) {
        
        sender.tag = 28;
        [self showRemoteView:sender];
        
    } else if (/*[tappedString isEqual:@"more"] over || */[tappedString isEqual:@"designs"]) {
        
        sender.tag = 29;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"download"]) {
        
        [self presentAppStoreForID:@784533845];
        
    } else if ([tappedString isEqual:@"Jordan"] || [tappedString isEqual:@"Earle"]) {
        
        sender.tag = 30;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"git"]) {
        
        sender.tag = 31;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Colton"] || [tappedString isEqual:@"Anglin"]) {
        
        sender.tag = 32;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Jonathan"] || [tappedString isEqual:@"Kingsley"]) {
        
        sender.tag = 33;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"YouthEast"]) {
        
        [self presentAppStoreForID:@830968649];
        [self goToCard:7];
        
    } else if ([tappedString isEqual:@"friend"]) {
        
        sender.tag = 34;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"push"]) {
        
        sender.tag = 34;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"screenshots"]) {
        
        sender.tag = 46;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Marcel"] || [tappedString isEqual:@"Voss"]) {
        
        sender.tag = 36;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Young"] /*thrice*/ || [tappedString isEqual:@"Rewired"] || [tappedString isEqual:@"State"]) {
        
        sender.tag = 37;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"PlateCollect"]) {
        
        [self goToCard:5];
        
    } else if ([tappedString isEqual:@"Robert"] || [tappedString isEqual:@"*bliep"]) {
        
        sender.tag = 38;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Festival"] || [tappedString isEqual:@"Code"]) {
        
        sender.tag = 47;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"European"] || [tappedString isEqual:@"Parliament"]) {
        
        sender.tag = 39;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Jorge"] || [tappedString isEqual:@"Izquierdo"]) {
        
        sender.tag = 40;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"filmed"]) {
        
        sender.tag = 41;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"M6HY4TKEM9HX"]) {
        
        [self presentAppStoreForID:@648312177];
        
    } else if ([tappedString isEqual:@"Thinkspace's"]) {
        
        sender.tag = 42;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Pioneers"]) {
        
        sender.tag = 43;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"hackathon"]) {
        
        sender.tag = 44;
        [self showRemoteView:sender];
        
    } else if ([tappedString isEqual:@"Max"] || [tappedString isEqual:@"Kramer"]) {
        
        sender.tag = 45;
        [self showRemoteView:sender];
        
    }
    
    
}

// called by some of the inline links into the AppStore view
- (void)presentAppStoreForID:(NSNumber *)appStoreID {
    
    if(NSClassFromString(@"SKStoreProductViewController")) { // Checks for iOS 6 feature.
        
        SKStoreProductViewController *storeController = [[SKStoreProductViewController alloc] init];
        storeController.delegate = self;
        
        [storeController loadProductWithParameters:@{ SKStoreProductParameterITunesItemIdentifier : appStoreID } completionBlock:^(BOOL result, NSError *error) {
            
            if (result) {
            
                [self presentViewController:storeController animated:YES completion:nil];
            
            } else {
            
                [[[UIAlertView alloc] initWithTitle:@"Uh oh!" message:@"There was a problem displaying the app." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
            
            }
        }];
        
        
    } // no need to support pre-iOS 6 stuff
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self goToCard:14];  // show hidden card
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return (needsLightStatusBar) ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
} // for shake gesture

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
