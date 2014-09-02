//
//  OTTask.h
//  Overdue Tasks
//
//  Created by Dean Williams on 30/08/2014.
//  Copyright (c) 2014 Dean Williams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

- (id) initWithData: (NSDictionary *) data;

@end
