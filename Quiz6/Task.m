//
//  Task.m
//  quiz5
//
//  Created by Vincent Pillinger on 3/29/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize taskName, dueDate, urgency;


- (id)initWithTaskName:(NSString *)name
        urgency:(float)urgency
          dateDue:(NSDate *)dueDate
{
    // Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if(self) {
        // Give the instance variables initial values
        [self setTaskName:name];
        [self setUrgency:urgency];
        [self setDueDate:dueDate];
    }
    
    // Return the address of the newly initialized object
    return self;
}


@end
