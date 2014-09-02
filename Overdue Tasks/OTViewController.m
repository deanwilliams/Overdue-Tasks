//
//  OTViewController.m
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import "OTViewController.h"
#import "OTAddTaskViewController.h"
#import "OTDetailTaskViewController.h"

@interface OTViewController ()

@end

@implementation OTViewController

- (NSMutableArray *) taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [@[] mutableCopy];
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray *dictionaries = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_PERSISTENCE_KEY];
    if (dictionaries) {
        for (NSDictionary *dictionary in dictionaries) {
            OTTask *task = [self buildTaskFromDictionary:dictionary];
            [self.taskObjects addObject:task];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[OTAddTaskViewController class]]) {
        OTAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[OTDetailTaskViewController class]]) {
            OTDetailTaskViewController *detailVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            detailVC.task = self.taskObjects[indexPath.row];
            detailVC.delegate = self;
        }
    }
}

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"addTaskViewControllerSegue" sender:sender];
}

- (IBAction)reorderBarButtonPressed:(UIBarButtonItem *)sender {
    if (self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    } else {
        [self.tableView setEditing:YES animated:YES];
    }
}

#pragma mark - OTAddTaskViewControllerDelegate Methods

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didAddTask:(OTTask *)task
{
    [self.taskObjects addObject:task];
    
    [self saveTasks];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - OTDetailTaskViewControllerDelegate methods

- (void) updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"taskCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    OTTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:task.date];
    
    NSDate *now = [NSDate date];
    if (task.completion) {
        cell.backgroundColor = [UIColor greenColor];
    } else if ([self isDateGreaterThanDate:now and:task.date]) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OTTask *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        [self saveTasks];
        [self.tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailTaskViewControllerSegue" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    OTTask *taskObject = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    [self saveTasks];
}

#pragma mark - Helper Methods

-(void)updateCompletionOfTask:(OTTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    [self.taskObjects removeObjectAtIndex:indexPath.row];
    task.completion = !task.completion;
    [self.taskObjects insertObject:task atIndex:indexPath.row];
    
    [self saveTasks];
    [self.tableView reloadData];
}

- (NSDictionary *)taskObjectAsAPropertyList:(OTTask *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.taskDescription, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.completion)};
    return dictionary;
}

- (OTTask *) buildTaskFromDictionary: (NSDictionary *) dictionary
{
    OTTask *task = [[OTTask alloc] initWithData:dictionary];
    return task;
}

- (BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    int firstInterval = [date timeIntervalSince1970];
    int secondInterval = [toDate timeIntervalSince1970];
    
    return firstInterval > secondInterval;
}

- (void) saveTasks
{
    NSMutableArray *taskObjectAsPropertyLists = [[NSMutableArray alloc] init];
    for (OTTask *taskObject in self.taskObjects) {
        [taskObjectAsPropertyLists addObject:[self taskObjectAsAPropertyList:taskObject]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyLists forKey:TASK_PERSISTENCE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
