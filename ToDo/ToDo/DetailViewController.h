//
//  DetailViewController.h
//  ToDo
//
//  Created by Nicolas Charles Herbert Broeking on 4/23/13.
//  Copyright (c) 2013 Nicolas C. Broeking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
