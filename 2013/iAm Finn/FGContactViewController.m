//
//  FGContactViewController.m
//  iAm Finn
//
//  Created by Finn Gaida on 01.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGContactViewController.h"

@implementation FGContactViewController
@synthesize navBar, coverImageView, profileImageView, scrollView, container;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    
    self.container.hidden = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(8, 6, 45, 30)];
    [left setBackgroundImage:[UIImage imageNamed:@"nav-left"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(showSidemenu) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:left];
    
    scrollBG = [[UIView alloc] initWithFrame:CGRectMake(0, 259, 320, 289)];
    scrollBG.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:scrollBG atIndex:1];
    
    [UIView animateWithDuration:3 animations:^{
        [coverImageView setImageToBlur:[UIImage imageNamed:@"cover"] blurRadius:5 completionBlock:nil];
        coverImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        coverImageView.layer.shadowOffset = CGSizeMake(0, 0);
        coverImageView.layer.shadowOpacity = .8;
        coverImageView.layer.shadowRadius = 5;
    }];
    
    self.scrollView.contentSize = CGSizeMake(320, 500);
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    profileImageView.layer.masksToBounds = YES;
    profileImageView.layer.cornerRadius = 50;
    profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    profileImageView.layer.borderWidth = 5;
    
    UIView *timeline1 = [[UIView alloc] initWithFrame:CGRectMake(44, 433, 2, 18)];
    timeline1.backgroundColor = [UIColor lightGrayColor];
    timeline1.alpha = .8;
    [scrollView insertSubview:timeline1 atIndex:0];
    UIView *timeline2 = [[UIView alloc] initWithFrame:CGRectMake(44, 312, 2, 20)];
    timeline2.backgroundColor = [UIColor lightGrayColor];
    timeline2.alpha = .8;
    [scrollView insertSubview:timeline2 atIndex:0];
    UIView *timeline3 = [[UIView alloc] initWithFrame:CGRectMake(44, 375, 2, 17)];
    timeline3.backgroundColor = [UIColor lightGrayColor];
    timeline3.alpha = .8;
    [scrollView insertSubview:timeline3 atIndex:0];
}

- (void)showSidemenu {
    
    if (showingSidemenu) {
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.navBar.center = CGPointMake(160, self.navBar.center.y);
            self.scrollView.center = CGPointMake(160, self.scrollView.center.y);
            self.coverImageView.center = CGPointMake(160, self.coverImageView.center.y);
            scrollBG.center = CGPointMake(160, scrollBG.center.y);
        } completion:^(BOOL finished) {
            showingSidemenu = NO;
            self.container.hidden = YES;
        }];
    } else {
        self.container.hidden = NO;
        
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.navBar.center = CGPointMake(420, self.navBar.center.y);
            self.scrollView.center = CGPointMake(420, self.scrollView.center.y);
            self.coverImageView.center = CGPointMake(420, self.coverImageView.center.y);
            scrollBG.center = CGPointMake(420, scrollBG.center.y);
        } completion:^(BOOL finished) {
            showingSidemenu = YES;
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
