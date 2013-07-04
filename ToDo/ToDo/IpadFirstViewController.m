//
//  IpadFirstViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/18/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "IpadFirstViewController.h"
#import "ListViewController.h"
#import "IPadListEditViewController.h"
#import "ItemEditIpadViewController.h"

@interface IpadFirstViewController ()

@end

@implementation IpadFirstViewController
@synthesize item;
@synthesize image;
@synthesize needsToEdit;
@synthesize table;

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
    self.title = @"ToDo";
    [self.table setDelegate:self];
	// Do any additional setup after loading the view.
    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
    
    [self configureView];
}

-(void) configureView
{
    if(self.item)
    {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        //[self.tableView reloadInputViews];
        //[self.tableView reloadData];
    }
    else
    {
        MainSplitViewController *split = (MainSplitViewController*)self.splitViewController;
        
        if([[[[split lists] objectAtIndex:0] list] count] > 0)
        {
            [self setItem:[[[[split lists] objectAtIndex:0] list] objectAtIndex:0]];
        }
        else if([[[[split lists] objectAtIndex:1] list] count] > 0)
        {
            [self setItem:[[[[split lists] objectAtIndex:1] list] objectAtIndex:0]];
        }
        else
        {
            ToDoItem *new = [[ToDoItem alloc] init:@"Create more ToDoItems" :[[NSDate alloc] init] :NO :@"Temp" :Nil :@"All" ];
            [[[[split lists] objectAtIndex:0] list] addObject:new];
            
            [self setItem:new];
            
        }
    }
    
    [table reloadData];
}

-(void)setToDoItem:(ToDoItem *)itemt
{
    if( self.item != itemt)
    {
        self.item = itemt;
    }
    [self configureView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    if( (self.item)&&([self.item completed]))
    {
        return 2;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if( section == 1)
    {
        if((self.item)&&([self.item completed]))
        {
            return 3;
        }
        return 2;
    }
    return 1;
}

-(void)setHidd:(bool)y
{
    [self.table setHidden:y];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    
    CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(self.item)
    {
    if( indexPath.section == 0)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"List: %@",[self.item parentName]];
    }
    else if( indexPath.section == 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.text = @"Complete";
    }
    else
    {
        if(indexPath.row == 0)
        {
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if( self.item.completed)
            {
                cell.textLabel.text = @"Completed: Yes";
            }
            else
            {
                cell.textLabel.text = @"Completed: No";
            }
        }
        else if( indexPath.row == 2)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"MMM dd YYYY"];
            
            cell.textLabel.text = [[NSString alloc] initWithFormat:@"Completed On: %@", [format stringFromDate:[self.item completedDate]]];
        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"MMM dd YYYY"];
            
            cell.textLabel.text = [[NSString alloc] initWithFormat:@"Created On: %@", [format stringFromDate:[self.item startDate]]];
        }
    }
    // Configure the cell...
    }
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setEditing:NO animated:animated];
    [self configureView];
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if( section == 2)
    {
        return @"Press to complete the ToDoItem. Once pressed there is no way to uncomplete.";
    }
    else
    {
        return @"";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if( section == 0)
    {
        return 100;
    }
    return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 260)];
    if(self.item)
    {

    //view.backgroundColor = [UIColor blackColor];
    if(section == 0)
    {
        //view.backgroundColor = [UIColor blackColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, 0 , 500, 100)];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont boldSystemFontOfSize:17]];
        
        //label.backgroundColor = [UIColor blackColor];
        label.text = [[NSString alloc] initWithString:[ self.item name]];
        
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 70, 70)];
        
        if( [self.item completed])
        {
            [temp setImage:[UIImage imageNamed:@"CheckIcon.png"]];
        }
        else
        {
            [temp setImage:[UIImage imageNamed:@"itemIcon.png"]];
        }
        
        [view addSubview: temp];
        
        [view addSubview:label];
        
        self.image = temp;
        // [label addSubview:[UIImage imageNamed:@"item.png"]];
    }
    }
    return view;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated: animated];
    
    if(editing == true)
    {
        needsToEdit = false;
        [self performSegueWithIdentifier:@"EditItem" sender:self];
    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

-(void) checkmark: (id)sender
{
    // Set the checkmark
    if( ![self.item completed])
    {
       ListViewController* temp = (ListViewController*)[[self.splitViewController.viewControllers objectAtIndex:0 ] topViewController];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:[[[temp list] list] indexOfObject:self.item]  inSection:0];
        
        
        
        [self.item setCompleted:true];
        
        [self.item setCompletedDate:[[NSDate alloc]init]];
        ToDoList* Completed = [[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:1];
        
        NSMutableArray* allLists = [(MainSplitViewController*)self.splitViewController lists];
        
        [[Completed list] addObject: self.item];
        
        Completed = [[(MainSplitViewController*)self.splitViewController lists] objectAtIndex:0];
        
        [[Completed list] removeObject:self.item];
        
        for(int i = 2; i < [allLists count]; i++ )
        {
            NSMutableArray *temp = [[allLists objectAtIndex:i] list];
            
            [temp removeObject:self.item];
            
        }
        [temp.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.table reloadData];

    }
}
/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   /* if([[segue identifier] isEqualToString:@"settingsList"])
    {
        [(IPadListEditViewController*)[segue destinationViewController] setEditing:YES animated:NO];
        [(IPadListEditViewController*)[segue destinationViewController] setMasterPopoverController:self.masterPopoverController];
    } */
    
   if( [[segue identifier] isEqualToString:@"EditItem"])
    {
        [(ItemEditIpadViewController*)segue.destinationViewController setToDoItem:self.item];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 2)
    {
        [self checkmark:self];
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"ToDoList", @"ToDoList");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
@end
