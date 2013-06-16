//
//  DetailViewController.m
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import "DetailViewController.h"
#import "ToDoList.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
@end

@implementation DetailViewController
@synthesize detailItem;
@synthesize swipeDown;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (detailItem != newDetailItem)
    {
        detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem)
    {
        self.title = [[NSString alloc] initWithString:[detailItem name]];
        self.nameLabel.text = [[NSString alloc] initWithFormat:@"%@", [self.detailItem name] ];
        self.parentLabel.text = [[NSString alloc] initWithFormat:@"%@", [self.detailItem parentName]];
        [self.nameLabel setReturnKeyType:UIReturnKeyDone];
        NSDateFormatter *numbert = [[NSDateFormatter alloc] init];
        
            [numbert setDateFormat: @"MMM dd YY  'at:' hh:mm"];
        self.createdLabel.text = [[NSString alloc] initWithString:[numbert stringFromDate:[detailItem startDate]]];
        self.descriptionLabel.text = [[NSString alloc] initWithString: [self.detailItem description]];

            if( [detailItem completed] == true )
            {
               self.dateCompletedLabel.text = [[NSString alloc] initWithString:[numbert stringFromDate:[self.detailItem completedDate]]];
            }
            else
            {
                self.dateCompletedLabel.text = @"Not Completed";
            }
        [self.descriptionLabel setReturnKeyType:UIReturnKeyDone];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeDown:)];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [swipe setDirection:UISwipeGestureRecognizerDirectionDown];
    
    self.nameLabel.enabled = NO;
    self.descriptionLabel.editable = NO;
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeUp:)];
    [self.nameLabel setDelegate:self];
    [self.descriptionLabel setDelegate:self];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    
    [self.view addGestureRecognizer:swipeUp];
    [self.view addGestureRecognizer:swipe];
    [self configureView];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if( textField == self.nameLabel)
    {
        [detailItem setName:[[NSString alloc] initWithString:textField.text]];
        self.title = [[NSString alloc] initWithString:textField.text];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(self.descriptionLabel == textView)
    {
        [UIView beginAnimations:@"MoveUpView" context:nil];
        [UIView setAnimationDuration:.25];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        self.descripP.frame = CGRectMake(self.descripP.frame.origin.x,
                                         5, self.descripP.frame.size.width, self.descripP.frame.size.height);
        textView.frame = CGRectMake(textView.frame.origin.x, 30, textView.frame.size.width, textView.frame.size.height);
        
        //Set Everything else to hidden
        
        [self.nameLabel setHidden:YES];
        [self.nameP setHidden:YES];
        [self.createdLabel setHidden:YES];
        [self.createdP setHidden: YES];
        [self.dateCompletedLabel setHidden:YES];
        [self.finishedP setHidden:YES];
        [self.listP setHidden:YES];
        [self.parentLabel setHidden:YES];
        
        [UIView commitAnimations];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if( self.descriptionLabel == textView)
    {
        [detailItem setDescription:[[NSString alloc] initWithString:textView.text]];
        
        [UIView beginAnimations:@"MoveDownView" context:nil];
        [UIView setAnimationDuration:.25];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        self.descripP.frame = CGRectMake(self.descripP.frame.origin.x,
                                         172, self.descripP.frame.size.width, self.descripP.frame.size.height);
        textView.frame = CGRectMake(textView.frame.origin.x, 210, textView.frame.size.width, textView.frame.size.height);
        
        //Set Everything else to hidden
        
        [self.nameLabel setHidden:NO];
        [self.nameP setHidden:NO];
        [self.createdLabel setHidden:NO];
        [self.createdP setHidden: NO];
        [self.dateCompletedLabel setHidden:NO];
        [self.finishedP setHidden:NO];
        [self.listP setHidden:NO];
        [self.parentLabel setHidden:NO];
        
        [UIView commitAnimations];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if( editing == true)
    {

        [self.nameLabel setBorderStyle:UITextBorderStyleRoundedRect];
     
        
        
        [self.nameLabel setEnabled:YES];
        [self.descriptionLabel setEditable:YES];
        [self.descriptionLabel setSpellCheckingType:UITextSpellCheckingTypeYes];
        //Add a ton of textfields
    }
    else
    {

        [self.nameLabel setBorderStyle:UITextBorderStyleNone];
        
        
        [self.nameLabel setEnabled:NO];
        [self.descriptionLabel setEditable:NO];
        
        [detailItem setName:[[NSString alloc] initWithString:self.nameLabel.text]];
        [detailItem setDescription:[[ NSString alloc] initWithString:self.descriptionLabel.text]];
        //reset the view
    }
}
-(void)SwipeUp:(id)sender
{
    if( swipeDown )
    {
        [detailItem setCompleted:true];

        [detailItem setCompletedDate:[[NSDate alloc]init]];
        ToDoList* Completed = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:1];
        
        NSMutableArray* allLists = [(MainNavigationViewController*)self.navigationController lists];
        
        [[Completed list] addObject: detailItem];
        
        Completed = [[(MainNavigationViewController*)self.navigationController lists] objectAtIndex:0];
        
        [[Completed list] removeObject:detailItem];
        
        for(int i = 2; i < [allLists count]; i++ )
        {
            NSMutableArray *temp = [[allLists objectAtIndex:i] list];
            
            [temp removeObject:detailItem];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)SwipeDown:(id)sender
{
    self.swipeDown = true;
    
    [self performSelector:@selector( reset: ) withObject:self afterDelay:1];
}
-(void)reset:(id) sender
{
    swipeDown = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
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
