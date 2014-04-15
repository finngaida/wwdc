//
//  FGGradientLayer.m
//  SunUp
//
//  Created by Finn Gaida on 13.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGGradientLayer.h"

@implementation FGGradientLayer

+ (CAGradientLayer *)standardGradient {
    UIColor *colorOne = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *returnedLayer = [CAGradientLayer new];
    returnedLayer.colors = colors;
    returnedLayer.locations = locations;
    
    return returnedLayer;
}


@end
