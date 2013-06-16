//
//  EditItemViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 6/15/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "EditItemViewController.h"

@interface EditItemViewController ()

@end

@implementation EditItemViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Edit ToDo";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    //[self.navigationItem setHidesBackButton:YES];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //[self setEditing:YES animated:NO];
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if( editing == false)
    {
        [self.navigationController popViewControllerAnimated:YES];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if( section == 1)
    {
        return [[(MainNavigationViewController*)self.navigationController lists] count] - 1;
    }
    return 1;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.item setName:[[NSString alloc] initWithString:textField.text]];
}
-(void)killF:(id)sender
{
    [sender resignFirstResponder];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    if(indexPath.section == 0)
    {
        CellIdentifier = @"fieldCell";
    }
    else
    {
       CellIdentifier= @"Cell"; 
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if(indexPath.section == 0)
    {
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(100, 12, 190, 30)];
        cell.textLabel.text = @"Name:";
        field.text = [[NSString alloc] initWithString:[self.item name]];
        field.tag = 0;
        [field setDelegate:self];
        [field setReturnKeyType:UIReturnKeyDone];
        [field addTarget:self action:@selector(killF:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell addSubview:field];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else if( indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = [[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row] name];
        }
        else
        {
            cell.textLabel.text = [[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row+1] name];
        }
        
        if( [cell.textLabel.text isEqualToString: [self.item parentName]] )
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.textLabel.text = @"Delete Item";
        cell.backgroundColor = [UIColor redColor];
    }
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"ToDoItem Name";
    }
    else if( section == 1)
    {
        return @"Select what list this belongs too";
    }
    else
    {
        return @"";
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if( section == 1)
    {
        return @"All ToDoItems will show up in the All list. If that is the only list you want your item to show up in select all. Otherwise select what addtional list you would like your ToDoItem in.";
    }
    else
    {
        return @"";
    }
}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

-(void)setToDoItem:(ToDoItem *)itemt
{
    self.item = itemt;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.section == 0)
   {
       [[[[self.tableView cellForRowAtIndexPath:indexPath] subviews] lastObject] becomeFirstResponder];
   }
   else if(indexPath.section == 1)
    {
        [self.item setParentName:[[NSString alloc] initWithString:[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text]];
        for( int i = 2; i < [[(MainNavigationViewController*)self.navigationController lists] count]; i++)
        {
            if( [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i] name] isEqualToString:[self.item parentName]])
            {
                [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i] list] addObject:self.item];
            }
            else
            {
                [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i] list] removeObject:self.item];
            }
        }
        
        [self.tableView reloadData];
    }
    else
    {
       for( int i = 0; i < [[(MainNavigationViewController*)self.navigationController lists] count]; i++)
        {
            [[[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i ] list] removeObject:self.item];
        }
    [self.navigationController popToViewController:[(MainNavigationViewController*)self.navigationController rootlist] animated:YES];
     
    }
    
}

@end
