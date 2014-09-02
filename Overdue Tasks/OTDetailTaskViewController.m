//
//  OTDetailTaskViewController.m
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import "OTDetailTaskViewController.h"
#import "OTEditTaskViewController.h"

@interface OTDetailTaskViewController ()

@end

@implementation OTDetailTaskViewController

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
    
    [self displayTask];
}

- (void) displayTask
{
    self.taskTitleLabel.text = self.task.title;
    self.taskDescriptionLabel.text = self.task.taskDescription;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.taskDateLabel.text = [formatter stringFromDate:self.task.date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[OTEditTaskViewController class]]) {
        OTEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
    }
}

- (IBAction)editTaskButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"editTaskViewControllerSegue" sender:sender];
}

#pragma mark - OTEditTaskViewControllerDelegate

- (void) didUpdateTask
{
    [self displayTask];
    [self.delegate updateTask];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
