//
//  ItemViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/2/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationViewController.h"

@interface ItemViewController : UITableViewController

@property (strong, nonatomic) ToDoItem *item;

@property bool needsToEdit;

@property (weak, nonatomic) UIImageView *image;
-(void) setToDoItem:(ToDoItem *)itemt;
@end
