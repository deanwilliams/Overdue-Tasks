//
//  OTDetailTaskViewController.h
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTTask.h"
#import "OTEditTaskViewController.h"

@protocol OTDetailTaskViewControllerDelegate <NSObject>

@required
-(void) updateTask;


@end

@interface OTDetailTaskViewController : UIViewController <OTEditTaskViewControllerDelegate>

@property (weak, nonatomic) id <OTDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionLabel;

- (IBAction)editTaskButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) OTTask *task;

@end
