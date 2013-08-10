//
//  MasterViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "MainNavigationViewController.h"
#import "MainSplitViewController.h"
#import "SettingsListViewController.h"
#import "ListViewController.h"
#import "IPadListEditViewController.h"
#import "IpadFirstViewController.h"

@interface MasterViewController ()
@end

@implementation MasterViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    //[self.editButtonItem setAction:@selector(changeValue)];
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
    self.title = @"ToDo Lists";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.allowsSelectionDuringEditing = true;
    
   // self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackTableview.png"]];
    //[self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackTableview.png"]]];
    
   // self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
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

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    
    [super setEditing:editing animated:animate];
  
    [[self.splitViewController.viewControllers lastObject] popToRootViewControllerAnimated:YES];
 
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1]  withRowAnimation:UITableViewRowAnimationFade];
    
   // [self.tableView reloadData];

}

- (void)insertNewObject:(id)sender
{
   // if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    //{
        
        ToDoList *temp = [[ToDoList alloc] init:@"New List" :[[NSMutableArray alloc] init] : @"Misc."];
        
        [[(MainNavigationViewController*)self.navigationController lists] addObject:temp];
  
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: [[(MainNavigationViewController*)self.navigationController lists] count] -3 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow: ([[(MainNavigationViewController*)self.navigationController lists]count] -1) inSection:0];
    
        [self setEditing:YES animated:NO];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    //[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        
        
        
        [self performSegueWithIdentifier:@"settingsList" sender:self];
        
       
   /* }
    else
    {
        
        ToDoList *temp = [[ToDoList alloc] init:@"New List" :[[NSMutableArray alloc] init] : @"Misc."];
        
        [[(MainSplitViewController*)self.splitViewController lists] addObject:temp];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow: [[(MainSplitViewController*)self.splitViewController lists] count] -3 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow: ([[(MainSplitViewController*)self.splitViewController lists]count] -1) inSection:0];
        
        [self setEditing:YES animated:NO];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [((IpadFirstViewController*)[[((MainSplitViewController*)self.splitViewController).viewControllers lastObject] topViewController]).masterPopoverController dismissPopoverAnimated:YES];
        
        //[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        
        //[self performSegueWithIdentifier:@"settingsList" sender:self];
        
        [[[self.splitViewController.viewControllers lastObject] topViewController] performSegueWithIdentifier:@"settingsList" sender:self];
       
        if(indexPath.section == 1)
        {
            [(IPadListEditViewController*)([[self.splitViewController.viewControllers lastObject] topViewController]) setListt:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row + 2]];
            
        }
        else
        {
            [(IPadListEditViewController*)([[self.splitViewController.viewControllers lastObject] topViewController]) setListt:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row]];
        }
    }
    
    //Figure out how to autoselect the list for editing
*/
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; //Fix
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0)
    {
        return 2;
    }
    else if( section == 1)
    {
       // [self.navigationController ]
     //   if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
       // {
            return [[(MainNavigationViewController*)self.navigationController lists] count ] - 2;
        //}
        //else
        //{
          //  return [[(MainSplitViewController*)self.splitViewController lists] count] - 2;
        //}
    }
    return 1; //_objects.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"ToDoLists";
    }
    else if( section == 1)
    {
        return @"My ToDoLists";
    }
    else if(section == 2)
    {
        return @"Settings";
    }
    else
    {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    if( (indexPath.section == 0))
    {
      //  if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            cell.textLabel.text = [[NSString alloc] initWithString:[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row] name] ];
            cell.detailTextLabel.text = [[NSString alloc] initWithString:[[[(MainNavigationViewController*)self.navigationController lists]objectAtIndex:indexPath.row] category] ];
        
        if(indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"list.png"];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"list.png"];
        }
        //}
        //else
        //{
            
          /*  cell.textLabel.text = [[NSString alloc] initWithString:[[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row] name] ];
            cell.detailTextLabel.text = [[NSString alloc] initWithString:[[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row] category]];
            
            cell.imageView.image = [UIImage imageNamed:@"list.png"];*/
        //}
    }
    else if(indexPath.section == 1)
    {
        cell.showsReorderControl = true;
        cell.imageView.image = [UIImage imageNamed:@"list.png"];
        
       // if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            cell.textLabel.text = [[NSString alloc] initWithString:[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row + 2] name] ];
            cell.detailTextLabel.text = [[NSString alloc] initWithString:[[[(MainNavigationViewController*)self.navigationController lists]objectAtIndex:indexPath.row + 2] category] ];
        //}
        /*else
        {
            cell.textLabel.text = [[NSString alloc] initWithString:[[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row + 2] name] ];
            cell.detailTextLabel.text = [[NSString alloc] initWithString:[[[(MainSplitViewController*)self.splitViewController lists]objectAtIndex:indexPath.row + 2] category] ];
        }*/
        
    }
    else
    {
        cell.textLabel.text = @"Settings";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"settings_button.png"];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if( indexPath.section == 0)
    {
        return NO;
    }
    else if( indexPath.section == 1)
    {
        // Return NO if you do not want the specified item to be editable.
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
      //  if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            [[(MainNavigationViewController*)self.navigationController lists] removeObjectAtIndex:indexPath.row + 2];
        
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //}
        /*else
        {
            [[(MainSplitViewController*)self.splitViewController lists] removeObjectAtIndex:indexPath.row + 2];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }*/
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
   /* if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {*/
        ToDoList *list = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:fromIndexPath.row+2];
    
        [[(MainNavigationViewController*)self.navigationController lists] removeObject:list];
    
        [[(MainNavigationViewController*)self.navigationController lists] insertObject:list atIndex:toIndexPath.row + 2];
    /*}
    else
    {
        ToDoList *list = [[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:fromIndexPath.row+2];
        
        [[(MainSplitViewController*)self.splitViewController lists] removeObject:list];
        
        [[(MainSplitViewController*)self.splitViewController lists] insertObject:list atIndex:toIndexPath.row + 2];
    }*/
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.section != sourceIndexPath.section)
    {
        //keep cell where it was...
        return sourceIndexPath;
    }
    
    //ok to move cell to proposed path...
    return proposedDestinationIndexPath;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 1)
    {
        return YES;
    }
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0)
        {
            if( self.tableView.isEditing)
            {
                [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
            }
            else
            {
                [self performSegueWithIdentifier:@"mainList" sender:self];
            }
        }
        if( indexPath.section == 1)
        {
            if( self.tableView.isEditing)
            {
               // if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
                //{
                    [self performSegueWithIdentifier:@"settingsList" sender:self];
               /* }
                else
                {
                    [(IpadFirstViewController*)([[self.splitViewController.viewControllers lastObject] topViewController]) setHidd:YES];
                    [[[self.splitViewController.viewControllers lastObject] topViewController] performSegueWithIdentifier:@"settingsList" sender:self];
                    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
                    if(indexPath.section == 1)
                    {
                        [(IPadListEditViewController*)([[self.splitViewController.viewControllers lastObject] topViewController]) setListt:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row + 2]];
                        
                    }
                    else
                    {
                        [(IPadListEditViewController*)([[self.splitViewController.viewControllers lastObject] topViewController]) setListt:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row]];
                    }
                }*/
            }
            else
            {
                [self performSegueWithIdentifier:@"mainList" sender:self];
            }
        }
        else
        {
        
        }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    
   if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
    
    else if( ([[segue identifier] isEqualToString:@"settingsList"]))
    {
      //  if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            if(indexPath.section == 1)
            {
                [(SettingsListViewController*)([segue destinationViewController]) setList:[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row + 2]];
            }
            else
            {
                [(SettingsListViewController*)([segue destinationViewController]) setList:[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row]];
            }
        /*}
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            if(indexPath.section == 1)
            {
                [(IPadListEditViewController*)([segue destinationViewController]) setList:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row + 2]];
                
            }
            else
            {
                [(IPadListEditViewController*)([segue destinationViewController]) setList:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row]];
            }
        }*/
    }
    if([[segue identifier] isEqualToString:@"mainList"])
    {
       // if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
            if(indexPath.section == 1)
            {
                [(ListViewController*)([segue destinationViewController]) setList:[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row + 2]];
            }
            else
            {
                [(ListViewController*)([segue destinationViewController]) setList:[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row]];
            }
       // }
        /*else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            
            if(indexPath.section == 1)
            {
                [(ListViewController*)([segue destinationViewController]) setList:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row + 2]];
            }
            else
            {
                [(ListViewController*)([segue destinationViewController]) setList:[[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:indexPath.row]];
            }
        }*/
    }
}

@end
