//
//  FGAirPlayViewController.h
//  Finn Gaida
//
//  Created by Finn Gaida on 04.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import "UIImage+ImageEffects.h"
#import "FGViewController.h"
#import <UIKit/UIKit.h>

@interface FGAirPlayViewController : UIViewController

/**
 *  Initialized a new instance of FGAirPlayViewController, passing the wanted size, so that it can adapt it's subviews to the changing screen sizes
 *
 *  @param frame The bounds in form of a CGRect object
 *
 *  @return A fully set-up instance of FGAirPlayViewController
 */
- (id)initWithFrame:(CGRect)frame;

@end
