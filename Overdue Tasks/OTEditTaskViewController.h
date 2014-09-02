//
//  OTEditTaskViewController.h
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTTask.h"

@protocol OTEditTaskViewControllerDelegate <NSObject>

@required

- (void) didUpdateTask;

@end

@interface OTEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDatePicker;

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;

@property (weak, nonatomic) id <OTEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) OTTask *task;

@end
