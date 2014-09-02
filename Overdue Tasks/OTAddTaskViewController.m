//
//  OTAddTaskViewController.m
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import "OTAddTaskViewController.h"

@interface OTAddTaskViewController ()

@end

@implementation OTAddTaskViewController

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
    
    self.taskTitleTextField.delegate = self;
    self.taskDescriptionTextView.delegate = self;
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

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    OTTask *task = [self buildTask];
    [self.delegate didAddTask:task];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
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

#pragma mark - Helper methods

- (OTTask *) buildTask
{
    NSString *title = self.taskTitleTextField.text;
    NSString *description = self.taskDescriptionTextView.text;
    NSDate *date = self.taskDatePicker.date;
    
    NSMutableDictionary *dictionary = [@{TASK_TITLE : title, TASK_DESCRIPTION : description, TASK_DATE : date, TASK_COMPLETION : @NO} mutableCopy];
    OTTask *newTask = [[OTTask alloc] initWithData:dictionary];
    return newTask;
}

@end
