//
//  SettingsListViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 5/8/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "SettingsListViewController.h"
#import "MainNavigationViewController.h"

@interface SettingsListViewController ()

@end

@implementation SettingsListViewController
@synthesize list;
@synthesize categorys;

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

    self.title = [[NSString alloc] initWithString:[list name]];
    
    categorys = [[NSMutableArray alloc] initWithArray:@[@"Misc.", @"Productivity", @"Work", @"Groceries", @"Personal", @"Shopping"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    
    if( section == 0)
    {
        return 1;
    }
    else if( section == 1)
    {
        return 6;
    }
    else
    {
        return 1;
    }
    // Return the number of rows in the section.
    return 0;
}

-(void)endKeyboard : sender
{
    [(UITextField*)sender resignFirstResponder];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Name";
    }
    else if(section == 1)
    {
        return @"Category";
    }
    else
    {
        return @"Add ToDo Items";
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [list setName:textField.text];
    
    for(int i = 0; i < [[list list] count]; i++)
    {
        [[[list list] objectAtIndex:i]setParentName:textField.text];
    }
    //Set the information
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if(indexPath.section == 0)
    {
        static NSString *CellIdentifier = @"FieldCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"Name:";
        
            cell.detailTextLabel.text = @"";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITextField *ageField = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 220, 30)];
            ageField.tag = indexPath.row;
            ageField.keyboardType = UIKeyboardTypeDefault;
            ageField.placeholder = [[NSString alloc] initWithString:[list name]];
            [ageField setReturnKeyType:UIReturnKeyDone];
            [ageField addTarget:self action:@selector(endKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
            [ageField setDelegate:self];
            [cell addSubview:ageField];        // Add TextFields
        }
        else
        {
            static NSString *CellIdentifier = @"FieldCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
        }
    }
    else if( indexPath.section == 1)
    {
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.textLabel.text = [categorys objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"";
        
        if( [[list category] isEqualToString:cell.textLabel.text])
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else
        {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.textLabel.text = @"List of ToDoItems";
    }
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            [[[[self.tableView cellForRowAtIndexPath:indexPath]subviews]lastObject] becomeFirstResponder];
        }
    }
    else if(indexPath.section == 1)
    {
        for( int i = 0; i < 6; i++)
        {
            [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]] setAccessoryType:UITableViewCellAccessoryNone];
        }
        [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        [list setCategory:[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    }
}

@end