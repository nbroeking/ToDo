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

    //if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
   // {
        [(MainNavigationViewController*)self.navigationController setRootlist:self];
  /*  }
    else
    {
        [(MainSplitViewController*)self.splitViewController setRootlist:self];
    }*/
    
    [self setTitle:[[NSString alloc] initWithString:[list name]]];
    
    //self.navigationItem.leftBarButtonItems = @[self.]self.editButtonItem;
    
    
    self.title = [[NSString alloc ] initWithString:list.name ];
    
    if(!([[list name] isEqualToString:@"Completed"]))
    {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
        
        self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects: addButton, self.editButtonItem, nil];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    self.tableView.allowsSelectionDuringEditing = YES;
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if( self.list)
    {
       // if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
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
       /* }
        else
        {
            MainSplitViewController* main = (MainSplitViewController*)self.splitViewController;
            
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
        }*/
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
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
   // if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    //{
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
    //}
    /*else
    {
        ToDoItem *temp = [[ToDoItem alloc] init:@"ToDo" :[[NSDate alloc] init] :false :@"I need to complete this ToDo." :NULL:[list name]];
        
        [[list list] addObject:temp];
        
        if( list != [[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:0])
        {
            [[[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:0] list ]addObject:temp];
        }
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: ([[list list]count] -1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // [self tableView:[self tableView] didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow: ([[list list]count] -2) inSection:0]];
        
        [self setNewItemNeedsEdit:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow: ([[list list]count] -1) inSection:0];
        
        
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        
      [[(IpadFirstViewController*)([[((MainSplitViewController*)self.splitViewController).viewControllers lastObject] topViewController]) masterPopoverController] dismissPopoverAnimated:YES];
        [[[((MainSplitViewController*)self.splitViewController ).viewControllers lastObject] topViewController ]performSegueWithIdentifier:@"EditItem" sender:self];
        
        [(ItemEditIpadViewController*)[[((MainSplitViewController*)self.splitViewController).viewControllers lastObject] topViewController] setItem: [self.list.list objectAtIndex:indexPath.row]];
        //[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    
    }*/
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
    
       // if( [[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPhone)
        //{
            ToDoItem *deleteItem = [[list list] objectAtIndex:indexPath.row];
        
            for( int i = 0; i < [[(MainNavigationViewController*)self.navigationController lists] count]; i++)
            {
                [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i] list ]removeObject:deleteItem];
            }
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //}
        /*else
        {
            ToDoItem *deleteItem = [[list list] objectAtIndex:indexPath.row];
            
            for( int i = 0; i < [[(MainSplitViewController*)self.splitViewController lists] count]; i++)
            {
                [[[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:i] list] removeObject:deleteItem];
            }
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }*/
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ToDoItem *temp = [[list list] objectAtIndex:fromIndexPath.row];
    
    [[list list] removeObject:temp];
    
    [[list list] insertObject:temp atIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    //}
    /*else
    {
        if( self.isEditing)
        {
            
            [[(IpadFirstViewController*)([[((MainSplitViewController*)self.splitViewController).viewControllers lastObject] topViewController]) masterPopoverController] dismissPopoverAnimated:YES];
            
            [[[((MainSplitViewController*)self.splitViewController ).viewControllers lastObject] topViewController ]performSegueWithIdentifier:@"EditItem" sender:self];
            
            [(ItemEditIpadViewController*)[[((MainSplitViewController*)self.splitViewController).viewControllers lastObject] topViewController] setItem: [self.list.list objectAtIndex:indexPath.row]];
        }
        else
        {
        
            IpadFirstViewController *cont = (IpadFirstViewController*)[[self.splitViewController.viewControllers lastObject] topViewController];
       
            [cont setItem: [[self.list list] objectAtIndex:indexPath.row]];
            [cont configureView];
        }
    }*/
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
     [self setNewItemNeedsEdit:NO];
    
}
@end
