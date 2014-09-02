//
//  OTEditTaskViewController.m
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import "OTEditTaskViewController.h"

@interface OTEditTaskViewController ()

@end

@implementation OTEditTaskViewController

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
    // Do any additional setup after loading the view.
    
    self.taskDescriptionTextView.delegate = self;
    self.taskTitleTextField.delegate = self;
    
    self.taskTitleTextField.text = self.task.title;
    self.taskDescriptionTextView.text = self.task.taskDescription;
    self.taskDatePicker.date = self.task.date;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender {
    NSString *title = self.taskTitleTextField.text;
    NSString *description = self.taskDescriptionTextView.text;
    NSDate *date = self.taskDatePicker.date;
    
    self.task.title = title;
    self.task.taskDescription = description;
    self.task.date = date;

    [self.delegate didUpdateTask];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTitleTextField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"/n"]) {
        [self.taskDescriptionTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
