//
//  FGAppDelegate.m
//  Finn
//
//  Created by Finn Gaida on 03.04.14.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import "TestFlight.h"
#import "FGAppDelegate.h"

@implementation FGAppDelegate {
    
    // Apple TV screen is being put into this
    UIWindow *secondWindow;

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // add support for when the users starts mirroring with the app open and not before
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleScreenDidConnectNotification:) name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleScreenDidDisconnectNotification:) name:UIScreenDidDisconnectNotification object:nil];
    
    // start monitoring
    [TestFlight takeOff:@"f04bbbe2-80c0-4a5b-951b-dc0983d601ce"];
    
    // if there are more than one screen available, put something neat on it
    if ([[UIScreen screens] count] > 1) {
        
        UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
        secondWindow = [[UIWindow alloc] initWithFrame:secondScreen.bounds];
        secondWindow.screen = secondScreen;
        
        FGAirPlayViewController *secondVC = [[FGAirPlayViewController alloc] initWithFrame:secondScreen.bounds];
        secondWindow.rootViewController = secondVC;
        secondWindow.hidden = NO;
    }
    
    return YES;

    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        UIControl *sender = [UIControl new];
        
        if ([[url.absoluteString substringFromIndex:12] isEqual:@"daniel"]) {
            
            sender.tag = 26;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showRemoteView" object:sender];
            
        } else if ([[url.absoluteString substringFromIndex:12] isEqual:@"niklas"]) {
            
            sender.tag = 27;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showRemoteView" object:sender];
            
        } else if ([[url.absoluteString substringFromIndex:12] isEqual:@"jugendhackt"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showCard" object:@9];
            
        } else if ([[url.absoluteString substringFromIndex:12] isEqual:@"platecollect"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showCard" object:@5];
            
        }
    
    });
    
    return YES;
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification {
    
    UIScreen *secondScreen = [aNotification object];
    
    // same here as in the didFinishLoading: a new screen was connected, so show some cool stuff on there
    if (!secondWindow) {
        secondWindow = [[UIWindow alloc] initWithFrame:secondScreen.bounds];
        secondWindow.screen = secondScreen;
        
        // Add VC
        FGAirPlayViewController *secondVC = [[FGAirPlayViewController alloc] initWithFrame:secondScreen.bounds];
        secondWindow.rootViewController = secondVC;
        secondWindow.hidden = NO;
    }
    
}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification {
    
    if (secondWindow) {
        // Hide and then delete the window.
        secondWindow.hidden = YES;
        secondWindow = nil;
        
    }
    
}

@end
