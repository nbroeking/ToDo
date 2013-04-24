//
//  AppDelegate.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationViewController.h"
#import "MainSplitViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainNavigationViewController *MainController;
@property (strong, nonatomic) MainSplitViewController *MainSplitController;

@end
