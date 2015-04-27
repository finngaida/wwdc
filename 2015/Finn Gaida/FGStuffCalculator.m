//
//  FGStuffCalculator.m
//  SunUp
//
//  Created by Finn Gaida on 13.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGStuffCalculator.h"

@implementation FGStuffCalculator

- (CGFloat)angleForTriangleInScreenQuarter:(FGScreenQuarter)screenQuarter toPoint:(CGPoint)p inView:(UIView *)view {
    
    CGPoint m = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    
    switch (screenQuarter) {
        case FGScreenQuarterTopLeft: {
            
            CGFloat oppositeLeg = m.y - p.y;
            CGFloat adjacentLeg = m.x - p.x;
            
            
            CGFloat angleRadians = atanf(oppositeLeg/adjacentLeg);
            CGFloat angle = (angleRadians/M_PI)*180;
            
            return angle +270; // Weil es das vierte Viertel ist.
            
        } break;
        case FGScreenQuarterTopRight: {
            
            CGFloat oppositeLeg = m.y - p.y;
            CGFloat adjacentLeg = p.x - m.x;
            
            //NSLog(@"Gegenkathete: %f, Ankathete: %f", oppositeLeg, adjacentLeg);
            
            CGFloat angleRadians = atanf(oppositeLeg/adjacentLeg);
            CGFloat angle = (angleRadians/M_PI)*180;
            
            return 90 - angle;
            
        } break;
        case FGScreenQuarterBottomLeft: {
            
            CGFloat oppositeLeg = p.y - m.y;
            CGFloat adjacentLeg = m.x - p.x;
            
            //NSLog(@"Gegenkathete: %f, Ankathete: %f", oppositeLeg, adjacentLeg);
            
            CGFloat angleRadians = atanf(oppositeLeg/adjacentLeg);
            CGFloat angle = (angleRadians/M_PI)*180;
            
            return 90 - angle + 180; // Weil es das dritte Viertel ist.
            
        } break;
        case FGScreenQuarterBottomRight: {
            
            CGFloat oppositeLeg = p.y - m.y;
            CGFloat adjacentLeg = p.x - m.x;
            
            //NSLog(@"Gegenkathete: %f, Ankathete: %f", oppositeLeg, adjacentLeg);
            
            CGFloat angleRadians = atanf(oppositeLeg/adjacentLeg);
            CGFloat angle = (angleRadians/M_PI)*180;
            
            return angle + 90; // Weil es der zweite Viertel ist.
            
        } break;
    }
    
}

+ (CGFloat)minutesAtDegree:(CGFloat)degree h24:(BOOL)h24 {
    if (h24) {
        if (degree/15 < 1) {return (degree- 0 *15)/15*60;}
        else if (degree/15 < 2)  {return (degree-  1 *15)/15*60;}
        else if (degree/15 < 3)  {return (degree-  2 *15)/15*60;}
        else if (degree/15 < 4)  {return (degree-  3 *15)/15*60;}
        else if (degree/15 < 5)  {return (degree-  4 *15)/15*60;}
        else if (degree/15 < 6)  {return (degree-  5 *15)/15*60;}
        else if (degree/15 < 7)  {return (degree-  6 *15)/15*60;}
        else if (degree/15 < 8)  {return (degree-  7 *15)/15*60;}
        else if (degree/15 < 9)  {return (degree-  8 *15)/15*60;}
        else if (degree/15 < 10) {return (degree-  9 *15)/15*60;}
        else if (degree/15 < 11) {return (degree- 10 *15)/15*60;}
        else if (degree/15 < 12) {return (degree- 11 *15)/15*60;}
        else if (degree/15 < 13) {return (degree- 12 *15)/15*60;}
        else if (degree/15 < 14) {return (degree- 13 *15)/15*60;}
        else if (degree/15 < 15) {return (degree- 14 *15)/15*60;}
        else if (degree/15 < 16) {return (degree- 15 *15)/15*60;}
        else if (degree/15 < 17) {return (degree- 16 *15)/15*60;}
        else if (degree/15 < 18) {return (degree- 17 *15)/15*60;}
        else if (degree/15 < 19) {return (degree- 18 *15)/15*60;}
        else if (degree/15 < 20) {return (degree- 19 *15)/15*60;}
        else if (degree/15 < 21) {return (degree- 20 *15)/15*60;}
        else if (degree/15 < 22) {return (degree- 21 *15)/15*60;}
        else if (degree/15 < 23) {return (degree- 22 *15)/15*60;}
        else if (degree/15 < 24) {return (degree- 23 *15)/15*60;}
        
        else {return 0;}
    } else {
        if (degree/30 < 1) {return (degree- 0 *30)/30*60;}
        else if (degree/30 < 2)  {return (degree-  1 *30)/30*60;}
        else if (degree/30 < 3)  {return (degree-  2 *30)/30*60;}
        else if (degree/30 < 4)  {return (degree-  3 *30)/30*60;}
        else if (degree/30 < 5)  {return (degree-  4 *30)/30*60;}
        else if (degree/30 < 6)  {return (degree-  5 *30)/30*60;}
        else if (degree/30 < 7)  {return (degree-  6 *30)/30*60;}
        else if (degree/30 < 8)  {return (degree-  7 *30)/30*60;}
        else if (degree/30 < 9)  {return (degree-  8 *30)/30*60;}
        else if (degree/30 < 10) {return (degree-  9 *30)/30*60;}
        else if (degree/30 < 11) {return (degree- 10 *30)/30*60;}
        else if (degree/30 < 12) {return (degree- 11 *30)/30*60;}
        
        else {return 0;}
    }
}

+ (CGFloat)unroundedFloatWithoutDecimalPlace:(CGFloat)f {
    
    NSString *s = [NSString stringWithFormat:@"%.5f", f];
    unichar c = [s characterAtIndex:1];
    
    NSString *final;
    
    if (c == (unichar)@".") {final = [NSString stringWithFormat:@"0%@", [s substringWithRange:NSMakeRange(0, 1)]];}
    else {final = [s substringWithRange:NSMakeRange(0, 2)];}
    
    return [final floatValue];
}

+ (UIImage *)screenshotViewOfView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (CGFloat) degreesToRadians:(CGFloat) degrees {
    return degrees * M_PI / 180;
}

+ (CGFloat) radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

void FGMotionize(UIView *v, BOOL f) {
    if (UIDevice.currentDevice.systemVersion.intValue >= 7) {
        UIInterpolatingMotionEffect *x = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        x.minimumRelativeValue = (f) ? @-20 : @-10; x.maximumRelativeValue = (f) ? @20 : @10;
        
        UIInterpolatingMotionEffect *y = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        y.minimumRelativeValue = (f) ? @-20 : @-10; y.maximumRelativeValue = (f) ? @20 : @10;
        
        [v addMotionEffect:x];
        [v addMotionEffect:y];
    }
}

+ (void)skillsCard:(UIView *)v {
    
    // image in the upper right that when tapped on shows something on the remote screen
    UIButton *meButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    UIImageView *me = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    me.layer.masksToBounds = YES;
    me.layer.cornerRadius = me.frame.size.width/2;
    me.image = [UIImage imageNamed:@"me"];
    meButton.tag = 1;
    //[meButton addTarget:self action:@selector(showRemoteView:) forControlEvents:UIControlEventTouchUpInside];
    [meButton addSubview:me];
    [v addSubview:meButton];
    
    // title of the card
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(150, 20, 160, 110)];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentLeft;
    name.numberOfLines = 0;
    name.font = [UIFont fontWithName:@"Helvetica Neue LT Com" size:52];
    name.text = @"Finn\nGaida";
    [v addSubview:name];
    
    
    // Age bar with label
    UILabel *age = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 50, 30)];
    age.backgroundColor = [UIColor clearColor];
    age.textColor = [UIColor blackColor];
    age.textAlignment = NSTextAlignmentLeft;
    age.numberOfLines = 0;
    age.font = [UIFont fontWithName:@"Futura-Normal" size:20];
    age.text = @"Age:";
    [v addSubview:age];
    
    UIView *agebar = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 30, 30)];
    agebar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
    agebar.layer.masksToBounds = YES;
    agebar.layer.cornerRadius = agebar.frame.size.width/2;
    [v addSubview:agebar];
    
    UIView *agebarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 30, 30)];
    agebarMark.backgroundColor = [UIColor colorWithRed:0 green:(113.0/255.0) blue:(67.0/255.0) alpha:1];
    agebarMark.layer.masksToBounds = YES;
    agebarMark.layer.cornerRadius = agebarMark.frame.size.width/2;
    [v addSubview:agebarMark];
    
    UILabel *ageLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    ageLoading.backgroundColor = [UIColor clearColor];
    ageLoading.textColor = [UIColor whiteColor];
    ageLoading.textAlignment = NSTextAlignmentLeft;
    ageLoading.numberOfLines = 0;
    ageLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    ageLoading.text = @"Loading 17%";
    [agebarMark addSubview:ageLoading];
    
    
    // Hobbies bar with title
    UILabel *hobbies = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 80, 30)];
    hobbies.backgroundColor = [UIColor clearColor];
    hobbies.textColor = [UIColor blackColor];
    hobbies.textAlignment = NSTextAlignmentLeft;
    hobbies.numberOfLines = 0;
    hobbies.font = [UIFont fontWithName:@"Futura-Normal" size:20];
    hobbies.text = @"Hobbies:";
    [v addSubview:hobbies];
    
    UIView *hobbiesbar = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
    hobbiesbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
    hobbiesbar.layer.masksToBounds = YES;
    hobbiesbar.layer.cornerRadius = hobbiesbar.frame.size.width/2;
    [v addSubview:hobbiesbar];
    
    UIView *familybarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
    familybarMark.backgroundColor = [UIColor colorWithRed:(3.0/255.0) green:(66.0/255.0) blue:(106.0/255.0) alpha:1];
    familybarMark.layer.masksToBounds = YES;
    familybarMark.layer.cornerRadius = familybarMark.frame.size.width/2;
    [v addSubview:familybarMark];
    
    UILabel *familyLoading = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 100, 30)];
    familyLoading.backgroundColor = [UIColor clearColor];
    familyLoading.textColor = [UIColor whiteColor];
    familyLoading.textAlignment = NSTextAlignmentLeft;
    familyLoading.numberOfLines = 0;
    familyLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    familyLoading.text = @"Family";
    [familybarMark addSubview:familyLoading];
    
    UIView *codingbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
    codingbarMark.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(139.0/255.0) blue:(0.0/255.0) alpha:1];
    codingbarMark.layer.masksToBounds = YES;
    codingbarMark.layer.cornerRadius = codingbarMark.frame.size.width/2;
    [v addSubview:codingbarMark];
    
    UILabel *codingLoading = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 100, 30)];
    codingLoading.backgroundColor = [UIColor clearColor];
    codingLoading.textColor = [UIColor whiteColor];
    codingLoading.textAlignment = NSTextAlignmentLeft;
    codingLoading.numberOfLines = 0;
    codingLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    codingLoading.text = @"Coding";
    [codingbarMark addSubview:codingLoading];
    
    UIView *schoolbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
    schoolbarMark.backgroundColor = [UIColor colorWithRed:(159.0/255.0) green:(0.0/255.0) blue:(19.0/255.0) alpha:1];
    schoolbarMark.layer.masksToBounds = YES;
    schoolbarMark.layer.cornerRadius = schoolbarMark.frame.size.width/2;
    [v addSubview:schoolbarMark];
    
    UILabel *schoolLoading = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 100, 30)];
    schoolLoading.backgroundColor = [UIColor clearColor];
    schoolLoading.textColor = [UIColor whiteColor];
    schoolLoading.textAlignment = NSTextAlignmentLeft;
    schoolLoading.numberOfLines = 0;
    schoolLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    schoolLoading.text = @"School";
    [schoolbarMark addSubview:schoolLoading];
    
    UIView *sportsbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 260, 30, 30)];
    sportsbarMark.backgroundColor = [UIColor colorWithRed:(74.0/255.0) green:(3.0/255.0) blue:(111.0/255.0) alpha:1];
    sportsbarMark.layer.masksToBounds = YES;
    sportsbarMark.layer.cornerRadius = sportsbarMark.frame.size.width/2;
    [v addSubview:sportsbarMark];
    
    UILabel *sportsLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    sportsLoading.backgroundColor = [UIColor clearColor];
    sportsLoading.textColor = [UIColor whiteColor];
    sportsLoading.textAlignment = NSTextAlignmentLeft;
    sportsLoading.numberOfLines = 0;
    sportsLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    sportsLoading.text = @"Sports";
    [sportsbarMark addSubview:sportsLoading];
    
    
    
    // Education Bar Section
    UILabel *education = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 90, 30)];
    education.backgroundColor = [UIColor clearColor];
    education.textColor = [UIColor blackColor];
    education.textAlignment = NSTextAlignmentLeft;
    education.numberOfLines = 0;
    education.font = [UIFont fontWithName:@"Futura-Normal" size:20];
    education.text = @"Education:";
    [v addSubview:education];
    
    UIView *educationbar = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
    educationbar.backgroundColor = [UIColor colorWithWhite:.6 alpha:1];
    educationbar.layer.masksToBounds = YES;
    educationbar.layer.cornerRadius = educationbar.frame.size.width/2;
    [v addSubview:educationbar];
    
    UIView *englishbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
    englishbarMark.backgroundColor = [UIColor colorWithRed:(0.0/255.0) green:(162.0/255.0) blue:(135.0/255.0) alpha:1];
    englishbarMark.layer.masksToBounds = YES;
    englishbarMark.layer.cornerRadius = englishbarMark.frame.size.width/2;
    [v addSubview:englishbarMark];
    
    UILabel *englishLoading = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 30)];
    englishLoading.backgroundColor = [UIColor clearColor];
    englishLoading.textColor = [UIColor whiteColor];
    englishLoading.textAlignment = NSTextAlignmentLeft;
    englishLoading.numberOfLines = 0;
    englishLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    englishLoading.text = @"English";
    [englishbarMark addSubview:englishLoading];
    
    UIView *mathsbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
    mathsbarMark.backgroundColor = [UIColor colorWithRed:(227.0/255.0) green:(57.0/255.0) blue:(164.0/255.0) alpha:1];
    mathsbarMark.layer.masksToBounds = YES;
    mathsbarMark.layer.cornerRadius = mathsbarMark.frame.size.width/2;
    [v addSubview:mathsbarMark];
    
    UILabel *mathsLoading = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 100, 30)];
    mathsLoading.backgroundColor = [UIColor clearColor];
    mathsLoading.textColor = [UIColor whiteColor];
    mathsLoading.textAlignment = NSTextAlignmentLeft;
    mathsLoading.numberOfLines = 0;
    mathsLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    mathsLoading.text = @"Maths";
    [mathsbarMark addSubview:mathsLoading];
    
    UIView *physicsbarMark = [[UIView alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
    physicsbarMark.backgroundColor = [UIColor colorWithRed:(255.0/255.0) green:(53.0/255.0) blue:(0.0/255.0) alpha:1];
    physicsbarMark.layer.masksToBounds = YES;
    physicsbarMark.layer.cornerRadius = physicsbarMark.frame.size.width/2;
    [v addSubview:physicsbarMark];
    
    UILabel *physicsLoading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    physicsLoading.backgroundColor = [UIColor clearColor];
    physicsLoading.textColor = [UIColor whiteColor];
    physicsLoading.textAlignment = NSTextAlignmentLeft;
    physicsLoading.numberOfLines = 0;
    physicsLoading.font = [UIFont fontWithName:@"Futura-Normal" size:15];
    physicsLoading.text = @"Physics";
    [physicsbarMark addSubview:physicsLoading];
    
    
    // animate the bars
    [UIView animateWithDuration:1.5 delay:.6 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        agebar.frame = CGRectMake(20, 180, 280, 30);
        agebarMark.frame = CGRectMake(20, 180, 130, 30);
        
        hobbiesbar.frame = CGRectMake(20, 260, 280, 30);
        familybarMark.frame = CGRectMake(20, 260, 280, 30);
        codingbarMark.frame = CGRectMake(20, 260, 220, 30);
        schoolbarMark.frame = CGRectMake(20, 260, 140, 30);
        sportsbarMark.frame = CGRectMake(20, 260, 80, 30);
        
        educationbar.frame = CGRectMake(20, 340, 280, 30);
        englishbarMark.frame = CGRectMake(20, 340, 280, 30);
        mathsbarMark.frame = CGRectMake(20, 340, 190, 30);
        physicsbarMark.frame = CGRectMake(20, 340, 100, 30);
        
    } completion:^(BOOL finished) {
        
    }];
    
}


@end
