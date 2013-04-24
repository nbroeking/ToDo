//
//  AppDelegate.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize MainController;
@synthesize MainSplitController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Override point for customization after application launch.
    
    // If it is an Ipad Set the main controller
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        MainController = nil;
        MainSplitController = (MainSplitViewController*)self.window.rootViewController;
        
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *controller = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)controller.topViewController;
    }
    else // If it is an iphone then set the navigation controller
    {
        MainController = (MainNavigationViewController*)self.window.rootViewController;
        MainSplitController = nil;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
