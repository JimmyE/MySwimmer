//
//  TTGMeetEventsTVC.m
//  MySwimmer
//
//  Created by Jim on 10/8/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGMeetEventsTVC.h"
#import "TTGMeetInfoCell.h"
#import "TTGMeetEventCell.h"
#import "SwimMeet.h"

@interface TTGMeetEventsTVC ()
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) SwimMeet *swimMeet;
@end

@implementation TTGMeetEventsTVC

@synthesize managedObjectContext;
@synthesize swimmerId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _swimMeet = (SwimMeet*) [managedObjectContext objectRegisteredForID:swimmerId];
    NSString *foo = [self formatDateMMDDYYYY:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    
    return 3;  // **TEMP ****
//    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 80;
    return 44;
}

- (NSString*) formatDateMMDDYYYY:(NSDate*)fromDate
{
    //todo: move to 'utils' class
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:fromDate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *foo = [self formatDateMMDDYYYY:_swimMeet.meetDate];

    if (indexPath.section == 0)
    {
        // Header cell
        static NSString *CellIdentifier = @"meetInfoCell";
        TTGMeetInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        cell.meetInfoName.text = _swimMeet.name;
        cell.meetLocationField.text = [NSString stringWithFormat:@"@%@", _swimMeet.location];
        cell.meetDateField.text = [self formatDateMMDDYYYY:_swimMeet.meetDate];
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"meetEventCell";
        TTGMeetEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.eventDescField.text = @"Boys 50 Fly";
        }
        else if (indexPath.row == 1) {
            cell.eventDescField.text = @"Boys 200 Free";
        }
        else {
            cell.eventDescField.text = @"Girls 50 Fly";
        }
        return cell;
    }
}



/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
