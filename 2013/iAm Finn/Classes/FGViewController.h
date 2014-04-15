//
//  FGViewController.h
//  iAm Finn
//
//  Created by Finn Gaida on 30.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+LBBlurredImage.h"
#import "FGGradientLayer.h"
#import "FGSideViewController.h"

@interface FGViewController : UIViewController <UIScrollViewDelegate> {
    BOOL showingSidemenu;
    UIView *scrollBG;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *container;

@end
