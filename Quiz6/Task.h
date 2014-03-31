//
//  Task.h
//  quiz5
//
//  Created by Vincent Pillinger on 3/29/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic) float urgency;
@property (nonatomic) NSDate *dueDate;
@property (nonatomic) NSString *taskName;

- (id)initWithTaskName:(NSString *)name
               urgency:(float)urgency
               dateDue:(NSDate *)dueDate;

@end
