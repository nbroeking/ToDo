//
//  IpadFirstViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/18/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSplitViewController.h"

@interface IpadFirstViewController : UIViewController <UISplitViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;

@property bool needsToEdit;
@property (strong, nonatomic) ToDoItem *item;
@property (weak, nonatomic) UIImageView *image;
-(void) setToDoItem:(ToDoItem *)itemt;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;-(void) configureView;
@property (strong, nonatomic) IBOutlet UIImageView *backImage;

-(void) setHidd:(bool)y;
@end
