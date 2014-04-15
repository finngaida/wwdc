//
//  FGAboutViewController.m
//  iAm Finn
//
//  Created by Finn Gaida on 01.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGAboutViewController.h"

@implementation FGAboutViewController
@synthesize container, bgImageView, navBar, scrollView;
@synthesize item1, item2, item3, item4, item5, item6;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    
    // Sidemenu
    self.container.hidden = YES;
    
    // Left Bar Button Item
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(8, 6, 45, 30)];
    [left setBackgroundImage:[UIImage imageNamed:@"nav-left"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(showSidemenu) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:left];
    
    // Nice addon / Not really necessary
    [self.bgImageView setImageToBlur:[UIImage imageNamed:@"ios"] blurRadius:5 completionBlock:nil];
    
    self.scrollView.contentSize = CGSizeMake(320, self.scrollView.frame.size.height+1);
    
    [item1 setBackgroundImage:[UIImage imageNamed:@"Finngaida"] forState:UIControlStateNormal];
    [item2 setBackgroundImage:[UIImage imageNamed:@"Apfeltube"] forState:UIControlStateNormal];
    [item3 setBackgroundImage:[UIImage imageNamed:@"Arduino"] forState:UIControlStateNormal];
    [item4 setBackgroundImage:[UIImage imageNamed:@"SunUp"] forState:UIControlStateNormal];
    [item5 setBackgroundImage:[UIImage imageNamed:@"Movie"] forState:UIControlStateNormal];
    [item6 setBackgroundImage:[UIImage imageNamed:@"Future"] forState:UIControlStateNormal];
    
    [item1 addTarget:self action:@selector(showFinngaida) forControlEvents:UIControlEventTouchUpInside];
    [item2 addTarget:self action:@selector(showApfeltube) forControlEvents:UIControlEventTouchUpInside];
    [item3 addTarget:self action:@selector(showArduino) forControlEvents:UIControlEventTouchUpInside];
    [item4 addTarget:self action:@selector(showSunup) forControlEvents:UIControlEventTouchUpInside];
    [item5 addTarget:self action:@selector(showMovies) forControlEvents:UIControlEventTouchUpInside];
    [item6 addTarget:self action:@selector(showFuture) forControlEvents:UIControlEventTouchUpInside];

    item1.layer.masksToBounds = YES;
    item2.layer.masksToBounds = YES;
    item3.layer.masksToBounds = YES;
    item4.layer.masksToBounds = YES;
    item5.layer.masksToBounds = YES;
    item6.layer.masksToBounds = YES;
    
    item1.layer.cornerRadius = 10;
    item2.layer.cornerRadius = 10;
    item3.layer.cornerRadius = 10;
    item4.layer.cornerRadius = 10;
    item5.layer.cornerRadius = 10;
    item6.layer.cornerRadius = 10;
}

- (void)showSidemenu {
    
    if (showingSidemenu) {
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bgImageView.center = CGPointMake(160, self.bgImageView.center.y);
            self.navBar.center = CGPointMake(160, self.navBar.center.y);
            self.scrollView.center = CGPointMake(160, self.scrollView.center.y);
        } completion:^(BOOL finished) {
            showingSidemenu = NO;
            self.container.hidden = YES;
        }];
    } else {        
        self.container.hidden = NO;
        
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.bgImageView.center = CGPointMake(420, self.bgImageView.center.y);
            self.navBar.center = CGPointMake(420, self.navBar.center.y);
            self.scrollView.center = CGPointMake(420, self.scrollView.center.y);
        } completion:^(BOOL finished) {
            showingSidemenu = YES;
        }];
    }
    
}

#pragma mark Items

- (void)showApfeltube {
    textView = [[UIView alloc] initWithFrame:CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1)];
    textView.backgroundColor = [UIColor whiteColor];
    
    // Tapping bg makes text pop back
    UIButton *leave = [[UIButton alloc] initWithFrame:CGRectMake(0, -40, 320, 550)];
    leave.backgroundColor = [UIColor blackColor]; leave.alpha = .7;
    [leave addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    headline.backgroundColor = [UIColor clearColor];
    headline.textColor = [UIColor blackColor];
    headline.font = [UIFont fontWithName:@"Open Sans" size:30];
    headline.text = @"ApfelTube";
    [textView addSubview:headline];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 60, 60)];
    icon.image = [UIImage imageNamed:@"Apfeltube"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 30;
    [textView addSubview:icon];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, self.view.frame.size.height -50)];
    content.backgroundColor = [UIColor clearColor];
    content.textColor = [UIColor blackColor];
    content.numberOfLines = 0;
    content.font = [UIFont fontWithName:@"Helvetica" size:20];
    content.text = @"Ok, so one and a half year ago I didn't have my Mac and iPhone, but was so passionate about my iPad, that I had to share it. I met two friends of mine and we built a small german blog to show progress on Apple products and Apps. ";
    [textView addSubview:content];
    
    // Pop it up!!
    [UIView animateWithDuration:.2 animations:^{
        [self.view addSubview:leave];
        [self.view addSubview:textView];
        
        textView.frame = CGRectMake(40, 20, 240, self.view.frame.size.height -40);
    }];
}


// Following five methods are the same.

- (void)showFinngaida {
    textView = [[UIView alloc] initWithFrame:CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1)];
    textView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leave = [[UIButton alloc] initWithFrame:CGRectMake(0, -40, 320, 550)];
    leave.backgroundColor = [UIColor blackColor]; leave.alpha = .7;
    [leave addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    headline.backgroundColor = [UIColor clearColor];
    headline.textColor = [UIColor blackColor];
    headline.font = [UIFont fontWithName:@"Open Sans" size:30];
    headline.text = @"Finngaida.de";
    [textView addSubview:headline];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 60, 60)];
    icon.image = [UIImage imageNamed:@"Finngaida"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 30;
    [textView addSubview:icon];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, self.view.frame.size.height -50)];
    content.backgroundColor = [UIColor clearColor];
    content.textColor = [UIColor blackColor];
    content.numberOfLines = 0;
    content.font = [UIFont fontWithName:@"Helvetica" size:20];
    content.text = @"Last year during my internship at DESY Hamburg I started building my own website. There's not much you can see on here, but there are backends that I play with in reference to HTTP requests from XCode.";
    [textView addSubview:content];
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view addSubview:leave];
        [self.view addSubview:textView];
        
        textView.frame = CGRectMake(40, 20, 240, self.view.frame.size.height -40);
    }];
}

- (void)showSunup {
    textView = [[UIView alloc] initWithFrame:CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1)];
    textView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leave = [[UIButton alloc] initWithFrame:CGRectMake(0, -40, 320, 550)];
    leave.backgroundColor = [UIColor blackColor]; leave.alpha = .7;
    [leave addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    headline.backgroundColor = [UIColor clearColor];
    headline.textColor = [UIColor blackColor];
    headline.font = [UIFont fontWithName:@"Open Sans" size:30];
    headline.text = @"SunUp";
    [textView addSubview:headline];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 60, 60)];
    icon.image = [UIImage imageNamed:@"SunUp"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 30;
    [textView addSubview:icon];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, self.view.frame.size.height -50)];
    content.backgroundColor = [UIColor clearColor];
    content.textColor = [UIColor blackColor];
    content.numberOfLines = 0;
    content.font = [UIFont fontWithName:@"Helvetica" size:20];
    content.text = @"This is a project I am working on with a buddy at the moment. It's an extremely simplified alarm clock aiming to save people's time waisted in scrolling through menus. ";
    [textView addSubview:content];
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view addSubview:leave];
        [self.view addSubview:textView];
        
        textView.frame = CGRectMake(40, 20, 240, self.view.frame.size.height -40);
    }];
}

- (void)showArduino {
    textView = [[UIView alloc] initWithFrame:CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1)];
    textView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leave = [[UIButton alloc] initWithFrame:CGRectMake(0, -40, 320, 550)];
    leave.backgroundColor = [UIColor blackColor]; leave.alpha = .7;
    [leave addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    headline.backgroundColor = [UIColor clearColor];
    headline.textColor = [UIColor blackColor];
    headline.font = [UIFont fontWithName:@"Open Sans" size:30];
    headline.text = @"Arduino";
    [textView addSubview:headline];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 60, 60)];
    icon.image = [UIImage imageNamed:@"Arduino"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 30;
    [textView addSubview:icon];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, self.view.frame.size.height -50)];
    content.backgroundColor = [UIColor clearColor];
    content.textColor = [UIColor blackColor];
    content.numberOfLines = 0;
    content.font = [UIFont fontWithName:@"Helvetica" size:20];
    content.text = @"For Christmas 2012 I got an Arduino which I wanted to have since like half a year. Since then I'm building circuits to answer one of my main questions: How does one connect hardware and software. \n BTW I'm not even close to getting an answer...";
    [textView addSubview:content];
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view addSubview:leave];
        [self.view addSubview:textView];
        
        textView.frame = CGRectMake(40, 20, 240, self.view.frame.size.height -40);
    }];
}

- (void)showMovies {
    textView = [[UIView alloc] initWithFrame:CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1)];
    textView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leave = [[UIButton alloc] initWithFrame:CGRectMake(0, -40, 320, 550)];
    leave.backgroundColor = [UIColor blackColor]; leave.alpha = .7;
    [leave addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    headline.backgroundColor = [UIColor clearColor];
    headline.textColor = [UIColor blackColor];
    headline.font = [UIFont fontWithName:@"Open Sans" size:30];
    headline.text = @"Movies";
    [textView addSubview:headline];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 60, 60)];
    icon.image = [UIImage imageNamed:@"Movie"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 30;
    [textView addSubview:icon];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, self.view.frame.size.height -50)];
    content.backgroundColor = [UIColor clearColor];
    content.textColor = [UIColor blackColor];
    content.numberOfLines = 0;
    content.font = [UIFont fontWithName:@"Helvetica" size:20];
    content.text = @"This doesn't really have something to do with my skills, but I found it should be in here, too. So, I'm busy every now and then shooting and editing shorts with some friends of mine. Those mostly are targeted for private use, but we once competed in a short movie challenge.";
    [textView addSubview:content];
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view addSubview:leave];
        [self.view addSubview:textView];
        
        textView.frame = CGRectMake(40, 20, 240, self.view.frame.size.height -40);
    }];
}

- (void)showFuture {
    textView = [[UIView alloc] initWithFrame:CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1)];
    textView.backgroundColor = [UIColor whiteColor];
    
    UIButton *leave = [[UIButton alloc] initWithFrame:CGRectMake(0, -40, 320, 550)];
    leave.backgroundColor = [UIColor blackColor]; leave.alpha = .7;
    [leave addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    headline.backgroundColor = [UIColor clearColor];
    headline.textColor = [UIColor blackColor];
    headline.font = [UIFont fontWithName:@"Open Sans" size:30];
    headline.text = @"Previsional";
    [textView addSubview:headline];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 60, 60)];
    icon.image = [UIImage imageNamed:@"Future"];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 30;
    [textView addSubview:icon];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, self.view.frame.size.height -50)];
    content.backgroundColor = [UIColor clearColor];
    content.textColor = [UIColor blackColor];
    content.numberOfLines = 0;
    content.font = [UIFont fontWithName:@"Helvetica" size:20];
    content.text = @"I have written down several dozens of ideas for potential apps, but because I'm kind of finical about getting things just right, only two of them actually got into testing phase. One of them is SunUp (see above).";
    [textView addSubview:content];
    
    [UIView animateWithDuration:.2 animations:^{
        [self.view addSubview:leave];
        [self.view addSubview:textView];
        
        textView.frame = CGRectMake(40, 20, 240, self.view.frame.size.height -40);
    }];
}

// Pop back
- (void)dismiss:(UIButton *)b {
    [UIView animateWithDuration:.2 animations:^{
        textView.frame = CGRectMake(159, [UIScreen mainScreen].bounds.size.height/2, 1, 1);
        b.alpha = 0;
    } completion:^(BOOL finished) {
        [textView removeFromSuperview];
        [b removeFromSuperview];
        
        textView = nil;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
