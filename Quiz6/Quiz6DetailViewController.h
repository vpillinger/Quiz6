//
//  Quiz6DetailViewController.h
//  Quiz6
//
//  Created by Vincent Pillinger on 3/29/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface Quiz6DetailViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) id detailItem;
@property (nonatomic, copy) void (^dismissBlock)(void);
@property (nonatomic) Task *task;
@property (weak, nonatomic) IBOutlet UISlider *urgencyField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *urgencyLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;

- (IBAction)saveTask:(id)sender;
- (IBAction)urgencySlider:(id)sender;
- (IBAction)BackgroundTouched:(id)sender;

@end
