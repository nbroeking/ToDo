//
//  MainNavigationViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "MainNavigationViewController.h"

@interface MainNavigationViewController ()
@end

@implementation MainNavigationViewController
@synthesize lists;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ToDoItem *nic = [[ToDoItem alloc] init:@"Nic" :[[NSDate alloc] init] :false :@"We Have sex with Nic" :NULL];
    
    NSMutableArray *mainList = [[NSMutableArray alloc] init]; //Load from memory
    
    [mainList addObject:nic];
    
    ToDoList *all = [[ToDoList alloc] init:@"All" :mainList];
    
    lists = [[NSMutableArray alloc] init];
    
    [lists addObject:all];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveData
{
    
}
-(void) loadData
{
    
}
@end
