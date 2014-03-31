//
//  Quiz6DetailViewController.m
//  Quiz6
//
//  Created by Vincent Pillinger on 3/29/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import "Quiz6DetailViewController.h"
#import "Task.h"

@interface Quiz6DetailViewController ()
- (void)configureView;
@end

@implementation Quiz6DetailViewController
@synthesize task;
@synthesize urgencyField;
@synthesize nameField;
@synthesize urgencyLabel;
@synthesize dateField;
@synthesize dismissBlock;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        task = (Task *)_detailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.nameField.delegate = self;
    [self configureView];
}

- (void)viewDidUnload
{
    [self setNameField:nil];
    [self setUrgencyField:nil];
    [self setDateField:nil];
    [self setUrgencyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [nameField setText:[task taskName]];
    [urgencyField setValue:[task urgency]];
    [urgencyLabel setText:[NSString stringWithFormat: @"%.2f", [task urgency]]];
    [dateField setDate:[task dueDate]];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
							
- (IBAction)saveTask:(id)sender {
    [task setDueDate:[dateField date]];
    [task setTaskName:[nameField text]];
    [task setUrgency:[urgencyField value]];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}
- (IBAction)urgencySlider:(id)sender {
    [urgencyLabel setText:[NSString stringWithFormat: @"%.2f", [urgencyField value]]];
}

- (IBAction)BackgroundTouched:(id)sender {
    [[self view] endEditing:YES];
}



@end
