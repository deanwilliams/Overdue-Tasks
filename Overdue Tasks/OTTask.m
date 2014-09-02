//
//  OTTask.m
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import "OTTask.h"

@implementation OTTask

- (id) init
{
    self = [self initWithData:nil];
    return self;
}

- (id) initWithData:(NSDictionary *)data
{
    self = [super init];
    
    self.title = data[TASK_TITLE];
    self.taskDescription = data[TASK_DESCRIPTION];
    self.date = data[TASK_DATE];
    self.completion = [data[TASK_COMPLETION] boolValue];
    
    return self;
}

 - (NSString *) description
{
    return [NSString stringWithFormat:@"Task[%@, %@, %@, %@]", self.title, self.taskDescription, self.date, self.completion ? @"Yes" : @"No"];
}
@end
