//
//  MainNavigationViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "MasterViewController.h"

@interface MainNavigationViewController ()
@end

@implementation MainNavigationViewController
@synthesize lists;
@synthesize rootlist;

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
    
    if( lists == nil)
    {
        lists = [[NSMutableArray alloc] init];
    
        ToDoItem *firstItem = [[ToDoItem alloc] init:@"Setup" :[[NSDate alloc] init] :false :@"I need to set up my ToDo Lists." :Nil: @"My First List"];
        
        ToDoList *all = [[ToDoList alloc] init:@"All" :[[NSMutableArray alloc]init] :@"ToDoList"];

        ToDoList *completed = [[ToDoList alloc] init:@"Completed" : [[NSMutableArray alloc] init] :@"ToDoList"];
        
        ToDoList *myFirstList = [[ToDoList alloc] init:@"My First List" :[[NSMutableArray alloc] init] :@"Personal"];
        
        [all setList:[@[firstItem] mutableCopy]];
         
        [myFirstList setList: [@[firstItem] mutableCopy]];
        [lists addObject:all];
        [lists addObject:completed];
        [lists addObject:myFirstList];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveData
{
    [NSKeyedArchiver archiveRootObject:lists toFile:[self archivePath]];
}
-(void) loadData
{
    NSMutableArray *temp = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]] mutableCopy];
    
    if( temp)
    {
        lists = [[NSMutableArray alloc] initWithArray:temp];
    }
}
-(void)cleanUp
{
    ToDoList* complete = [self.lists objectAtIndex:1];
    for( int i = 0; i < [[complete list] count]; i++)
    {
        NSDate *appComplete = [[[complete list] objectAtIndex:i] completedDate];
        
        NSDate* now = [[NSDate alloc] init];
        
        NSDate *fiveDaysAgo = [now dateByAddingTimeInterval:-10*24*60*60];
        
        if( [appComplete compare:fiveDaysAgo] == NSOrderedAscending)
        {
            [[complete list] removeObjectAtIndex:i];
            i--;
        }
    }
}
-(NSString*) archivePath
{
    // This finds the archive path for history nights
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [ directories objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"Data.bin"];
}
@end
