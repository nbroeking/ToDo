//
//  SettingsListViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 5/8/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoList.h"

@interface SettingsListViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) ToDoList *list;
@property (strong, nonatomic) NSMutableArray *categorys;
@end
