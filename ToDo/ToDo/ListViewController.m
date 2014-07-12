//
//  ListViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 5/7/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "ItemViewController.h"
#import "EditItemViewController.h"
#import "IpadFirstViewController.h"
#import "ItemEditIpadViewController.h"
#import "SettingsListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize list;
@synthesize newItemNeedsEdit;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [(MainNavigationViewController*)self.navigationController setRootlist:self];

    
    [self setTitle:[[NSString alloc] initWithString:[list name]]];
    
    //self.navigationItem.leftBarButtonItems = @[self.]self.editButtonItem;
    
    
    self.title = [[NSString alloc ] initWithString:list.name ];
    
    UIBarButtonItem * button =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    button.style=UIBarButtonSystemItemEdit;
    
    
    if(!([[list name] isEqualToString:@"Completed"])&&(!([[list name] isEqualToString:@"All"])))
    {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
        self.navigationItem.rightBarButtonItems = [[NSMutableArray alloc] initWithObjects: addButton, button, nil];
    }
    else
    {
        self.navigationItem.rightBarButtonItems = [[NSMutableArray alloc] initWithObjects: nil];
    }
    //self.tableView.allowsSelectionDuringEditing = YES;
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*
        UIBarButtonItem * button =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
        [(NSMutableArray*)self.navigationItem.rightBarButtonItems addObject: button];
        button.style=UIBarButtonSystemItemEdit;
    */
    if( self.list)
    {
            MainNavigationViewController* main = (MainNavigationViewController*)self.navigationController;
            
            for( int i = 0; i < [[[[main lists] objectAtIndex:0] list]count]; i++)
            {
               // NSLog(@"Searching");
                if([[[[[[main lists] objectAtIndex:0] list] objectAtIndex:i] parentName] isEqualToString:[self.list name]])
                {
                    if( !([[self.list list] containsObject:[[[[main lists] objectAtIndex:0] list] objectAtIndex:i]]))
                    {
                        [[self.list list] addObject:[[[[main lists] objectAtIndex:0] list] objectAtIndex:i]];
                    }
                }
            }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setTitle:[[NSString alloc] initWithString:[list name]]];
    [self setEditing:NO animated:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void) insertNewObject: (id)sender
{
        ToDoItem *temp = [[ToDoItem alloc] init:@"ToDo" :[[NSDate alloc] init] :false :@"I need to complete this ToDo." :NULL:[list name]];
    
        [[list list] addObject:temp];
    
        if( list != [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:0])
        {
            [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:0] list ]addObject:temp];
        }
    
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: ([[list list]count] -1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
   // [self tableView:[self tableView] didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow: ([[list list]count] -2) inSection:0]];
    
        [self setNewItemNeedsEdit:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow: ([[list list]count] -1) inSection:0];
    
    
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
 }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[list list] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.showsReorderControl = true;
    
    cell.textLabel.text =[[ NSString alloc] initWithString:[[[list list] objectAtIndex:indexPath.row] name]];

    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"MMM dd yyyy hh:mm a"];
    
    cell.detailTextLabel.text = [[NSString alloc] initWithString: [format stringFromDate:[[[list list] objectAtIndex:indexPath.row] startDate]]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
    
            ToDoItem *deleteItem = [[list list] objectAtIndex:indexPath.row];
        
            for( int i = 0; i < [[(MainNavigationViewController*)self.navigationController lists] count]; i++)
            {
                [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i] list ]removeObject:deleteItem];
            }
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
   
    }
  
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ToDoItem *temp = [[list list] objectAtIndex:fromIndexPath.row];
    
    [[list list] removeObject:temp];
    
    [[list list] insertObject:temp atIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    //{
        if(self.isEditing)
        {
            [self performSegueWithIdentifier:@"addEdit" sender:self];
        }
        else
        {
            if( self.newItemNeedsEdit)
            {
                [self performSegueWithIdentifier:@"addEdit" sender:self];
            }
            else
            {
                [self performSegueWithIdentifier:@"showDetail" sender:self];
            }
        }
   }
-(void) edit
{
    [self performSegueWithIdentifier:@"settingsList" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [(ItemViewController*)[segue destinationViewController] setToDoItem:[[self.list list] objectAtIndex:indexPath.row]];
    }
    else if([[segue identifier] isEqualToString:@"addEdit"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [(EditItemViewController*)[segue destinationViewController] setToDoItem:[[self.list list] objectAtIndex:indexPath.row]];
    }
    else if ([[segue identifier] isEqualToString:@"settingsList"])
    {
 
                [(SettingsListViewController*)([segue destinationViewController]) setList:list];
    }
     [self setNewItemNeedsEdit:NO];
    
}
@end
