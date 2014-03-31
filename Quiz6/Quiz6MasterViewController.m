//
//  Quiz6MasterViewController.m
//  Quiz6
//
//  Created by Vincent Pillinger on 3/29/14.
//  Copyright (c) 2014 Vincent Pillinger. All rights reserved.
//

#import "Quiz6MasterViewController.h"

#import "Quiz6DetailViewController.h"
#import "Task.h"

@interface Quiz6MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation Quiz6MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
            _objects = [[NSMutableArray alloc]init];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [NSDateComponents new];
            NSDate *currDate = [NSDate date];
            
            for(int i = 0; i < 10; i++){
                NSString *str = [NSString stringWithFormat:@"Task %d", i];
                components.day = i;
                NSDate *date = [calendar dateByAddingComponents:components toDate:currDate options:0];
                Task *t = [[Task alloc]initWithTaskName:str urgency:i dateDue:date];
                [_objects addObject:t];
            }
            
        }
        return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *arr = [_objects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate *d1 = [obj1 dueDate];
        NSDate *d2 = [obj2 dueDate];
        return [d1 compare:d2];
    }];
    _objects = [arr mutableCopy];
    [[self tableView] reloadData];
    //sort the task array
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }


    NSDate *object = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [object description];
    return cell;*/
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    int i = [indexPath row];
    Task *t = [_objects objectAtIndex:i];
  
    
    //where we can set the cell info
    [[cell textLabel] setText:t.taskName];
    [[cell textLabel] setTextColor:[UIColor colorWithRed:[t urgency]/10.0 green:1-[t urgency]/10.0 blue:0 alpha:0.5]];
    
    //display date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *str = [NSString stringWithFormat:@" (%d)", (int)[t urgency] ];
    NSString *d = [[dateFormatter stringFromDate:[t dueDate]] stringByAppendingString:str];
    [[cell detailTextLabel] setText:d];
    [[cell detailTextLabel] setTextColor:[UIColor blackColor]];
    
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[Quiz6DetailViewController alloc] initWithNibName:nil bundle:nil];
    }
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    self.detailViewController.detailItem = object;
    //[self.navigationController pushViewController:self.detailViewController animated:YES];
    [self.detailViewController setDismissBlock:^{[self.tableView reloadData];}];
    [self.detailViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:self.detailViewController animated:YES completion:nil];
}

@end
