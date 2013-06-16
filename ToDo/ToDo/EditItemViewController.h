//
//  EditItemViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/15/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationViewController.h"

@interface EditItemViewController : UITableViewController <UITextFieldDelegate>


@property (strong, nonatomic) ToDoItem *item;

-(void) setToDoItem:(ToDoItem *)itemt;


@end
