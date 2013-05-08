//
//  MainNavigationViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoList.h"
@interface MainNavigationViewController : UINavigationController

@property (strong, nonatomic) NSMutableArray *lists;

-(void) saveData;
-(void) loadData;
@end
