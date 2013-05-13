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
    
        ToDoList *all = [[ToDoList alloc] init:@"All" :[[NSMutableArray alloc]init] :@"Misc."];

        [lists addObject:all];
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
    NSLog(@"Saving Data");
    
    [NSKeyedArchiver archiveRootObject:lists toFile:[self archivePath]];
}
-(void) loadData
{
    NSLog(@"Load Data");
    NSMutableArray *temp = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]] mutableCopy];
    
    if( temp)
    {
        NSLog(@"Sets List");
        lists = [[NSMutableArray alloc] initWithArray:temp];
        
        NSLog(@"%d number of lists", [lists count]);
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
