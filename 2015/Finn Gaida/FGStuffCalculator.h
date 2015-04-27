//
//  FGStuffCalculator.h
//  SunUp
//
//  Created by Finn Gaida on 13.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FGScreenQuarter) {
    FGScreenQuarterTopLeft,
    FGScreenQuarterTopRight,
    FGScreenQuarterBottomRight,
    FGScreenQuarterBottomLeft
} ;

@interface FGStuffCalculator : NSObject

- (CGFloat)angleForTriangleInScreenQuarter:(FGScreenQuarter)screenQuarter toPoint:(CGPoint)p inView:(UIView *)view;
+ (CGFloat)minutesAtDegree:(CGFloat)degree h24:(BOOL)h24;
+ (CGFloat)unroundedFloatWithoutDecimalPlace:(CGFloat)f;
+ (UIImage *)screenshotViewOfView:(UIView *)view;
+ (CGFloat)degreesToRadians:(CGFloat)degrees;
+ (CGFloat)radiansToDegrees:(CGFloat)radians;
+ (void)skillsCard:(UIView *)v;
void FGMotionize(UIView *v, BOOL f);

@end
