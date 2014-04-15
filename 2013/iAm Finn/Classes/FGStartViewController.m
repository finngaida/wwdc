//
//  FGViewController.m
//  iAm Finn
//
//  Created by Finn Gaida on 25.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGStartViewController.h"

@implementation FGStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Shorter code later on
    CGSize s = [UIScreen mainScreen].bounds.size;
    
    self.view.backgroundColor = [UIColor blackColor];
	
    // Blur the bg
    UIImageView *bg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:bg];
    [bg setImageToBlur:[UIImage imageNamed:@"fam.jpg"] blurRadius:10 completionBlock:nil];
    
    
    // Rocket parts
    top = [[UIImageView alloc] initWithFrame:CGRectMake(160-50, 70, 100, 106)];
    top.image = [UIImage imageNamed:@"top.png"];
    [self.view addSubview:top];
    
    bottom = [[UIImageView alloc] initWithFrame:CGRectMake(160-50, s.height-150, 100, 73)];
    bottom.image = [UIImage imageNamed:@"bottom.png"];
    [self.view addSubview:bottom];
    
    // For noobs    
    NSTimer *timer = [NSTimer timerWithTimeInterval:7 target:self selector:@selector(showArrow) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


// Show transculent arrow, then hide it
- (void)showArrow {
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(130, 180, 60, 130)];
    arrow.image = [UIImage imageNamed:@"arrow"];
    arrow.alpha = 0;
    [self.view insertSubview:arrow atIndex:1];
    
    [UIView animateWithDuration:1 animations:^{
        arrow.alpha = .8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            arrow.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if (CGRectContainsPoint(top.frame, [touch locationInView:self.view])) {
        
        // Prevent top from being pulled further down than base
        if (top.center.y < [UIScreen mainScreen].bounds.size.height-203) {
            top.center = CGPointMake(top.center.x, [touch locationInView:self.view].y);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if (top.center.y > [UIScreen mainScreen].bounds.size.height-204) {
        
        UIImageView *rocket = [[UIImageView alloc] initWithFrame:CGRectMake(160-50, 224, 100, 179)];
        rocket.image = [UIImage imageNamed:@"rocket"];
        [self.view addSubview:rocket];
        
        [top removeFromSuperview];
        [bottom removeFromSuperview];
        
        //Animate
        [UIView animateWithDuration:.5 animations:^{
            rocket.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.5 animations:^{
                rocket.center = CGPointMake(450, rocket.center.y);
            } completion:^(BOOL finished) {
                
                // And pull the view
                [self performSegueWithIdentifier:@"showHome" sender:self];
            }];
        }];
        
    } else {
        
        // Plop back
        [UIView animateWithDuration:.5 animations:^{
            top.frame = CGRectMake(160-50, 70, 100, 106);
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
