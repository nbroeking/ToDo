//
//  ItemEditIpadViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/25/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSplitViewController.h"

@interface ItemEditIpadViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) ToDoItem *item;

-(void) setToDoItem:(ToDoItem *)itemt;

@property (strong, nonatomic) IBOutlet UITableView *table;

@end
