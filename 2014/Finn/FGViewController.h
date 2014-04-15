//
//  FGViewController.h
//  Finn
//
//  Created by Finn Gaida on 03.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import "UIView+FGCloning.m"
#import "FGCard.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreText/CoreText.h>
#import <StoreKit/StoreKit.h>

@interface FGViewController : UIViewController <UIScrollViewDelegate, SKStoreProductViewControllerDelegate, FGCardDelegate>

@end
