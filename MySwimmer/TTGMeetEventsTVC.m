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
#import "TTGHelper.h"

@interface TTGMeetEventsTVC ()
@property (nonatomic, strong) SwimMeet *swimMeet;
@property (nonatomic) BOOL newSwimmer;
@end

@implementation TTGMeetEventsTVC

@synthesize managedObjectContext;
@synthesize swimmerId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    if (swimmerId != nil ){
        _swimMeet = (SwimMeet*) [managedObjectContext objectRegisteredForID:swimmerId];
        self.newSwimmer = NO;
    }
    else {
        _swimMeet = [NSEntityDescription insertNewObjectForEntityForName:@"SwimMeet" inManagedObjectContext:self.managedObjectContext];
        _swimMeet.meetDate = [NSDate date];
        self.newSwimmer = YES;
        self.editing = YES;
    }
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
    
    return  self.newSwimmer ? 0 : 3;  // TEMP ***
//    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 120;
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        // Header cell
        static NSString *CellIdentifier = @"meetInfoCell";
        TTGMeetInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        cell.meetInfoName.text = _swimMeet.name;
        cell.meetLocationField.text = [NSString stringWithFormat:@"@%@", _swimMeet.location];
        cell.meetDateField.text = [TTGHelper formatDateMMDDYYYY:_swimMeet.meetDate];
        cell.meetType.selectedSegmentIndex = [_swimMeet.meetType integerValue];
        
        cell.meetInfoName.enabled = NO;
        cell.meetDateField.enabled = NO;
        cell.meetLocationField.enabled = NO;
        cell.meetType.enabled = NO;
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"meetEventCell";
        TTGMeetEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        //todo: use db
        if (indexPath.row == 0) {
            cell.eventDescField.text = @"#10 Boys 50 Fly";
        }
        else if (indexPath.row == 1) {
            cell.eventDescField.text = @"#30 Boys 200 Free";
        }
        else {
            cell.eventDescField.text = @"#23 Girls 50 Fly";
        }
        return cell;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    NSLog(@"editing: %d", editing);
    
    if (!editing) {
        [self saveMeetInfo];
    }
    
    [self enableDisableMeetInfoFields:editing];
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath  {
    return indexPath.section == 0 ? NO : YES;
}

- (TTGMeetInfoCell*) getMeetInfoCell {
    TTGMeetInfoCell *meetCell = (TTGMeetInfoCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] ];

    return meetCell;
}

- (void) enableDisableMeetInfoFields:(BOOL)editing {

    TTGMeetInfoCell * meetCell = [self getMeetInfoCell];
    meetCell.meetInfoName.enabled = editing;
    meetCell.meetLocationField.enabled = editing;
    meetCell.meetType.enabled = editing;
    if (editing)    {
        meetCell.meetLocationField.text = _swimMeet.location; //reset field, remove '@'
    }
    
    meetCell.meetInfoName.borderStyle = editing ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
    meetCell.meetLocationField.borderStyle = editing ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) saveMeetInfo {
    TTGMeetInfoCell * meetCell = [self getMeetInfoCell];
    _swimMeet.name = meetCell.meetInfoName.text;
    _swimMeet.location = meetCell.meetLocationField.text;  // TODO * trim leading/trailing white space
    _swimMeet.meetType = [NSNumber numberWithInt:meetCell.meetType.selectedSegmentIndex];
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
