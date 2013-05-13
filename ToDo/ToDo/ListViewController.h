//
//  ListViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 5/7/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationViewController.h"

@interface ListViewController : UITableViewController

@property (strong, nonatomic) ToDoList *list;
@end
