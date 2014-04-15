//
//  FGAboutViewController.h
//  iAm Finn
//
//  Created by Finn Gaida on 01.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LBBlurredImage.h"
#import "FGSideViewController.h"

@interface FGAboutViewController : UIViewController {
    BOOL showingSidemenu;
    UIView *textView;
}

@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *item1;
@property (weak, nonatomic) IBOutlet UIButton *item2;
@property (weak, nonatomic) IBOutlet UIButton *item3;
@property (weak, nonatomic) IBOutlet UIButton *item4;
@property (weak, nonatomic) IBOutlet UIButton *item5;
@property (weak, nonatomic) IBOutlet UIButton *item6;

@end
