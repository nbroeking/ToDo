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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   
    
    // Sets the setting defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"NO" forKey:@"cleanUp"];
    
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    // If it is an Ipad Set the main controller
 
        MainController = (MainNavigationViewController*)self.window.rootViewController;

        [MainController loadData];
        
        BOOL def = [defaults boolForKey:@"cleanUp"];
        
        if(def)
        {
            [MainController cleanUp];
            [MainController saveData];
        }
    
    //Get settings and clean up
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
  
        [(MainNavigationViewController*)self.window.rootViewController saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
        [(MainNavigationViewController*)self.window.rootViewController saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  
        [(MainNavigationViewController*)self.window.rootViewController loadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL clean = [defaults boolForKey:@"cleanUp"];
    
    if(clean)
    {
        [MainController cleanUp];
        [MainController saveData];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
 /*   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [(MainSplitViewController*)self.window.rootViewController loadData];
    }
    else
    {
        [(MainNavigationViewController*)self.window.rootViewController loadData];
    }
    */
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    [(MainNavigationViewController*)self.window.rootViewController saveData];
}

@end
