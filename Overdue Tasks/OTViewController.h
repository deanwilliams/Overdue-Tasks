//
//  OTViewController.h
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTAddTaskViewController.h"
#import "OTDetailTaskViewController.h"

@interface OTViewController : UIViewController <OTAddTaskViewControllerDelegate, OTDetailTaskViewControllerDelegate,  UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSMutableArray *taskObjects;

@end
