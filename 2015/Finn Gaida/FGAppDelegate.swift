//
//  AppDelegate.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 17.04.15.
//  Copyright (c) 2015 Finn Gaida. All rights reserved.
//

import UIKit

@UIApplicationMain
class FGAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var window2: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // add support for when the users starts mirroring with the app open and not before
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleScreendidConnectNotification:", name: UIScreenDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleScreendidDisconnectNotification:", name: UIScreenDidDisconnectNotification, object: nil)
        
        
        // if there are more than one screen available, put something neat on it
        if (UIScreen.screens().count > 1) {
            
            let secondScreen:UIScreen = UIScreen.screens()[1] 
            window2 = UIWindow(frame: secondScreen.bounds)
            window2?.screen = secondScreen
            
            let secondVC = FGAirPlayViewController(frame: secondScreen.bounds)
            window2!.rootViewController = secondVC
            window2!.hidden = false
        
        }
        
        return true
    }
    
    func handleScreendidConnectNotification(aNotification:NSNotification) {
        
        let secondScreen:UIScreen = aNotification.object as! UIScreen
        
        // same here as in the didFinishLoading: a new screen was connected, so show some cool stuff on there
        if (window2 == nil) {
            window2 = UIWindow(frame: secondScreen.bounds)
            window2?.screen = secondScreen
            
            let secondVC = FGAirPlayViewController(frame: secondScreen.bounds)
            window2!.rootViewController = secondVC
            window2!.hidden = false
        }
        
    }
    
    func handleScreendidDisconnectNotification(aNotification:NSNotification) {
        
        if ((window2) != nil) {
            // Hide and then delete the window.
            window2!.hidden = true
            window2 = nil
            
        }
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

