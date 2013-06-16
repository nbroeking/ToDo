//
//  DetailViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoList.h"
#import "MainNavigationViewController.h"
#import "MainSplitViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) ToDoItem* detailItem;
@property bool swipeDown;

@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *parentLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdLabel;

@property (strong, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateCompletedLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameP;
@property (strong, nonatomic) IBOutlet UILabel *listP;
@property (strong, nonatomic) IBOutlet UILabel *createdP;

@property (strong, nonatomic) IBOutlet UILabel *finishedP;
@property (strong, nonatomic) IBOutlet UILabel *descripP;

@end
