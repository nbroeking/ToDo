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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.allowsSelectionDuringEditing = true;
    

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) changeName:(id)sender
{
    [(UITextField*)sender resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Done");
    UITableViewCell *current = ((UITableViewCell*)(textField.superview));
    
    ToDoList *list = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:[self.tableView indexPathForCell:current].row];
    
    if( ![textField.text isEqual: @""] )
    {
        [list setName:[[NSString alloc] initWithString:textField.text]];
    }
    [self.tableView reloadData];
    [textField resignFirstResponder];
    [textField removeFromSuperview];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    
    if(editing)
    {
        int size = [[(MainNavigationViewController*)self.navigationController lists]count];
        for(int i = 1; i < size; i++ )
        {
            [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]].selectionStyle = UITableViewCellSelectionStyleNone;
            NSString *temp = [[NSString alloc] initWithString: [[[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:i] name]];
            
            [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]].textLabel.text = [[NSString alloc] initWithFormat:@"%@: Press to Change", temp];
        }
    }
    else
    {
        int size = [[(MainNavigationViewController*)self.navigationController lists]count];
        for(int i = 1; i < size; i++ )
        {
            [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]].selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        
        [self.tableView reloadData];
    }
}

- (void)insertNewObject:(id)sender
{
    ToDoList *temp = [[ToDoList alloc] init:@"New List" :NULL];
    
    [[(MainNavigationViewController*)self.navigationController lists] addObject:temp];
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:YES];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section == 0)
    {
       // [self.navigationController ]
        return [[(MainNavigationViewController*)self.navigationController lists] count];
    }
    return 1; //_objects.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"ToDoLists";
    }
    else if(section == 1)
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

    if( indexPath.section == 0)
    {
        ToDoItem *temp = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:indexPath.row];
        cell.textLabel.text = [[NSString alloc] initWithString:[temp name]];
        
        cell.imageView.image = NULL;
        
    }
    else
    {
        cell.textLabel.text = @"Settings";
        cell.imageView.image = [UIImage imageNamed:@"settings_button.png"];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if( indexPath.section == 0)
    {
        if( indexPath.row != 0)
        {
        // Return NO if you do not want the specified item to be editable.
            return YES;
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
      //  [_objects removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
     //   NSDate *object = _objects[indexPath.row];
       // self.detailViewController.detailItem = object;
    }
    else
    {
        if( indexPath.section == 0)
        {
            if( self.tableView.isEditing)
            {
                if(indexPath.row != 0)
                {
                    [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text = @"Name: ";
                    UITextField *weightField = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, 170, 30)];
                    weightField.tag = 1;
                    weightField.keyboardType = UIKeyboardTypeAlphabet;
                    [weightField setReturnKeyType:UIReturnKeyDone];
                    [weightField addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventEditingDidEndOnExit];
                    [weightField setDelegate:self];
                    [weightField setPlaceholder:@"New Name"];
                    [ [self.tableView cellForRowAtIndexPath:indexPath] addSubview:weightField];
                    [weightField becomeFirstResponder];
                }
            }
            else
            {
                [self performSegueWithIdentifier:@"mainList" sender:self];
            }
        }
        else
        {
            [self performSegueWithIdentifier:@"mainList" sender:self];
        }
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
    if([[segue identifier] isEqualToString:@"mainList"])
    {
        
    }
}

@end
