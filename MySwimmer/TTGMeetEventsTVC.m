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
#import "TTGEventEditTVC.h"
#import "SwimMeet.h"
#import "TTGHelper.h"

@interface TTGMeetEventsTVC ()
@property (nonatomic, strong) SwimMeet *swimMeet;
@property (nonatomic, strong) NSMutableArray *eventList;
@property (nonatomic, assign) BOOL isNewMeet;
@property (nonatomic, assign) BOOL showMeetDatePicker;

@end

@implementation TTGMeetEventsTVC

NSDate * newMeetDate;
@synthesize managedObjectContext;
@synthesize detailObjectId;

const int MemberInfoSectionId = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.showMeetDatePicker = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    if (detailObjectId != nil ){
        _swimMeet = (SwimMeet*) [managedObjectContext objectRegisteredForID:detailObjectId];
        _isNewMeet = NO;
    }
    else {
        _swimMeet = [NSEntityDescription insertNewObjectForEntityForName:@"SwimMeet" inManagedObjectContext:self.managedObjectContext];
        _swimMeet.meetDate = [NSDate date];
        _isNewMeet = YES;
        self.editing = YES;
    }

    _eventList = [NSMutableArray arrayWithArray:[_swimMeet.hasEvents allObjects]];  // todo: sort array by event number
}

- (void) viewDidAppear:(BOOL)animated
{
    _eventList = [NSMutableArray arrayWithArray:[_swimMeet.hasEvents allObjects]];  // todo: sort array by event number
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int addRow = self.tableView.isEditing ? 1 : 0; //when editing, need a row for the "Add event" cell
    int result = section == MemberInfoSectionId ? 1 : (int)[_eventList count] + addRow;
    return result;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == MemberInfoSectionId)
    {
        if (_showMeetDatePicker) {
            return 200;  //todo
        }
        else {
            return 100;
        }
//        return 110;  // ** TODO **
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == MemberInfoSectionId)
    {
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
    else if (indexPath.row == self.swimMeet.hasEvents.count)
    {
        static NSString *CellIdentifier = @"addEventCell";
        return [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else
    {
        static NSString *CellIdentifier = @"meetEventCell";
        TTGMeetEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        MeetEvent *event = [_eventList objectAtIndex:indexPath.row];
        cell.eventDescField.text = [NSString stringWithFormat:@"%@", event.EventDescription];
        cell.ageDescField.text = event.AgeClassDescription;
        return cell;
    }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath  {
    return indexPath.section == MemberInfoSectionId ? NO : YES;
 //   return NO;
}

-  (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (indexPath.row == self.swimMeet.hasEvents.count) ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    [self.tableView setEditing:editing animated:animate];

    //todo: make section a constant
    NSArray *paths = [NSArray arrayWithObject:
                      [NSIndexPath indexPathForRow:(self.eventList.count) inSection:1]];
    
    if (!editing) {
        [self saveMeetInfo];

        [[self tableView] deleteRowsAtIndexPaths:paths
                                withRowAnimation:UITableViewRowAnimationTop];
    } else {
        //[_eventList addObject:[[MeetEvent alloc]init]];
        [self.tableView beginUpdates];
        [[self tableView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    [self enableDisableMeetInfoFields:editing];
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
    meetCell.meetDateField.enabled = editing;
    if (editing)    {
        meetCell.meetLocationField.text = _swimMeet.location; //reset field, remove '@'
    }
    
    meetCell.meetInfoName.borderStyle = editing ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
    meetCell.meetLocationField.borderStyle = editing ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
}

#pragma mark - Text Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    TTGMeetInfoCell *infoCell = [self getMeetInfoCell];
    
    if ([textField isEqual:infoCell.meetDateField]) {
        infoCell.meetDatePicker = [[UIDatePicker alloc] init];
        infoCell.meetDatePicker.datePickerMode = UIDatePickerModeDate;
        [infoCell.meetDatePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
        textField.inputView = infoCell.meetDatePicker;
    }
}

- (void) datePickerValueChanged {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    TTGMeetInfoCell *cell = (TTGMeetInfoCell*) [self.tableView cellForRowAtIndexPath:indexPath];
    
    UIDatePicker *picker =  (UIDatePicker *) [cell.meetDateField inputView];
    cell.meetDateField.text = [TTGHelper formatDateMMDDYYYY:picker.date];
    newMeetDate = picker.date;
    
}

-(void) saveMeetInfo {
    TTGMeetInfoCell * meetCell = [self getMeetInfoCell];
    _swimMeet.name = meetCell.meetInfoName.text;
    _swimMeet.location = meetCell.meetLocationField.text;  // TODO * trim leading/trailing white space
    _swimMeet.meetType = [NSNumber numberWithInt:meetCell.meetType.selectedSegmentIndex];
    
    if (newMeetDate != nil) {
        _swimMeet.meetDate = newMeetDate;
    }
}

- (IBAction)addEventTapped:(id)sender {
    [self performSegueWithIdentifier:@"addMeetEvent" sender:sender];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"addMeetEvent"] || [segue.identifier isEqual:@"editMeetEvent"])
    {
        TTGEventEditTVC *foo = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        foo.detailObjectId = [segue.identifier isEqual:@"editMeetEvent"] ? [[self.eventList objectAtIndex:indexPath.row] objectID] : nil;
        foo.swimMeetId = self.swimMeet.objectID;
        
        foo.managedObjectContext = managedObjectContext;
    }

}


@end
