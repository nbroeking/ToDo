//
//  ItemViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/2/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "ItemViewController.h"
#import "EditItemViewController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController
@synthesize needsToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setEditing:NO animated:NO];
    [self.tableView reloadData];
}
-(void)setToDoItem:(ToDoItem *)itemt
{
    if( self.item != itemt)
    {
        self.item = itemt;
    }
    [self configureView];
}
-(void) configureView
{
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"ToDo";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    if( (self.item )&&(![self.item completed]))
    {
       self.navigationItem.rightBarButtonItem = self.editButtonItem; 
    }
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.needsToEdit)
    {
        self.needsToEdit = false;
        //[self setEditing:YES animated:NO]; Edit this to have the screen auto change
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    
    CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

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
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if( section == 2)
    {
        return @"Press to complete the ToDoItem.";
    }
    else
    {
        return @"";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if( section == 0)
        {
            return 100;
        }
    }
    else
    {
        if( section == 0)
        {
            return 150;
        }
    }
    return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 48)];
    //view.backgroundColor = [UIColor blackColor];
    if(section == 0)
    {
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            //view.backgroundColor = [UIColor blackColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 180, 100)];
        
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor blackColor]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setFont:[UIFont boldSystemFontOfSize:17]];
    
            label.text = [[NSString alloc] initWithString:[ self.item name]];
        
            UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        
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
        }
        else
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 580, 150)];
            
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor blackColor]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setFont:[UIFont boldSystemFontOfSize:25]];
            
            label.text = [[NSString alloc] initWithString:[ self.item name]];
            
            UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 120)];
            
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
            
            self.image = temp;        }
       // [label addSubview:[UIImage imageNamed:@"item.png"]];
    }
    
        return view;
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated: animated];
    
    if(editing == true)
    {
        needsToEdit = false;
        [self performSegueWithIdentifier:@"editItem" sender:self];
    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

 //Override to support editing the table view.
/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
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
}*/

-(void) checkmark: (id)sender
{
    // Set the checkmark
    if( ![self.item completed])
    {
    [self.item setCompleted:true];
    
    [self.item setCompletedDate:[[NSDate alloc]init]];
    ToDoList* Completed = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:1];
    
    NSMutableArray* allLists = [(MainNavigationViewController*)self.navigationController lists];
    
    [[Completed list] addObject: self.item];
    
    Completed = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:0];
    
    [[Completed list] removeObject:self.item];
    
    for(int i = 2; i < [allLists count]; i++ )
    {
        NSMutableArray *temp = [[allLists objectAtIndex:i] list];
        
        [temp removeObject:self.item];
        
    }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
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
    if( [[segue identifier] isEqualToString:@"editItem"])
    {
        [(EditItemViewController*)segue.destinationViewController setToDoItem:self.item];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 2)
    {
        [self checkmark:self];
    }
}

@end
