//
//  IPadListEditViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainSplitViewController.h"

@interface IPadListEditViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate,UIPopoverControllerDelegate>

@property (strong, nonatomic) ToDoList *list;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
-(void) setListt:(ToDoList *)listt;

-(void) configureView;

@property (strong, nonatomic) NSMutableArray *categorys;

@property (strong, nonatomic) IBOutlet UITableView *table;

-(void)setHidd :(bool)y;

@end

