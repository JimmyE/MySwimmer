//
//  TTGEventEditTVC.m
//  MySwimmer
//
//  Created by Jim on 10/12/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGEventEditTVC.h"
#import "TTGDistanceOptionsTVC.h"
#import "TTGKeyValueOptionsTVC.h"

@interface TTGEventEditTVC ()
@property (weak, nonatomic) IBOutlet UILabel *meetNameField;
@property (weak, nonatomic) IBOutlet UITextField *eventNbrField;
@property (weak, nonatomic) IBOutlet UITextField *eventeTypeField; //todo: timed final, prelim, or final
@property (weak, nonatomic) IBOutlet UISegmentedControl *strokeField;
@property (weak, nonatomic) IBOutlet UILabel *distanceField;
@property (weak, nonatomic) IBOutlet UIStepper *eventNbrStepper;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *ageClassLabel;

- (IBAction)eventStepperValueChanged:(id)sender;
@property (strong, nonatomic) MeetEvent *meetEvent;
@property (strong, nonatomic) SwimMeet *swimMeet;

@end

@implementation TTGEventEditTVC
@synthesize detailObjectId;
@synthesize swimMeetId;
@synthesize managedObjectContext;

const int DistanceInfoCellSection = 1;
const int DistanceInfoCellRow = 2;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.detailObjectId != nil)
    {
        _meetEvent = (MeetEvent*) [managedObjectContext objectRegisteredForID:detailObjectId];
        _swimMeet = _meetEvent.forMeet;
        [self enableInputFields:NO];
    }
    else
    {
        _swimMeet = (SwimMeet*) [managedObjectContext objectRegisteredForID:swimMeetId];
        _meetEvent = [NSEntityDescription insertNewObjectForEntityForName:@"MeetEvent" inManagedObjectContext:self.managedObjectContext];
        
        [_swimMeet addHasEventsObject:_meetEvent];
        _meetEvent.forMeet = _swimMeet;
        self.meetNameField.text = _swimMeet.name;
        
        self.editing = YES;
    }
    
    [self loadMeetEventInfo];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self loadMeetEventInfo];
}

- (void) loadMeetEventInfo
{
    self.eventNbrStepper.stepValue = 1;
    self.eventNbrStepper.minimumValue = 0;
    
    self.eventNbrField.text = [NSString stringWithFormat:@"%@", _meetEvent.number];
    self.ageClassLabel.text = [_meetEvent AgeClassDescription];
    self.eventeTypeField.text = @"timed final";
    self.distanceField.text = [NSString stringWithFormat:@"%@ %@", _meetEvent.distance, [_meetEvent.forMeet CourseTypeDescription]];
    self.strokeField.selectedSegmentIndex = [_meetEvent.strokeType intValue];
        
    self.eventNbrStepper.value = _meetEvent.number.intValue;
    self.meetNameField.text = _swimMeet.name;
 }

- (void) enableInputFields:(BOOL) enableFields
{
    self.eventNbrField.enabled = enableFields;
    self.strokeField.enabled    = enableFields;
    self.eventeTypeField.enabled = enableFields;
//    self.distanceField.enabled = enableFields;
    
    self.eventNbrField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
    self.eventeTypeField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;

    self.eventNbrStepper.hidden = !enableFields;
}

/*
- (UITableViewCell*) getDistanceCell {
    return [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:DistanceInfoCellRow inSection:DistanceInfoCellSection] ];
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textfield delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    /*
    UITableViewCell *infoCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    */
//    if ([textField isEqual:self.ageClassField]) {
//        self.pickerView = [[UIPickerView alloc] init];
//        [self.pickerView  AddTarg]
//        textField.inputView = self.pickerView;
        
//        infoCell.meetDatePicker = [[UIDatePicker alloc] init];
//        infoCell.meetDatePicker.datePickerMode = UIDatePickerModeDate;
//        [infoCell.meetDatePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
//        textField.inputView = infoCell.meetDatePicker;
//    }
}

/*
- (void) datePickerValueChanged {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    TTGMeetInfoCell *cell = (TTGMeetInfoCell*) [self.tableView cellForRowAtIndexPath:indexPath];
    
    UIDatePicker *picker =  (UIDatePicker *) [cell.meetDateField inputView];
    cell.meetDateField.text = [TTGHelper formatDateMMDDYYYY:picker.date];
    newMeetDate = picker.date;
    
}
 */

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 4;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:animated];
    
    [self enableInputFields:editing];
    
    if (!editing) {
        [self saveEvent];
        [self closePopup];
    }
}
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
 */

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath   {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath  {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - Actions

- (void) saveEvent {
    NSLog(@"Save event");
    self.meetEvent.number = [NSNumber numberWithInt:[self.eventNbrField.text intValue]];
    self.meetEvent.strokeType = [NSNumber numberWithInt:self.strokeField.selectedSegmentIndex];
    
}

- (void) closePopup {
    //[self dismissViewControllerAnimated:YES completion:^{}];
    [[self navigationController] popViewControllerAnimated:YES];
}


- (IBAction)eventStepperValueChanged:(id)sender {
    self.eventNbrField.text = [NSString stringWithFormat:@"%.f", self.eventNbrStepper.value];
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.isEditing;
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"distanceSegue"] )
    {
        NSMutableArray *distances = [[NSMutableArray alloc] init];
        for (NSNumber *distance in self.swimMeet.EventDistances) {
            [distances addObject:[[TTGSwimOption alloc] initWithKey:[distance intValue]
                                                     andDescription:[NSString stringWithFormat:@"%@  (%@)", distance, self.swimMeet.CourseTypeDescription]]];
        }

        TTGKeyValueOptionsTVC * vc = segue.destinationViewController;
        vc.keyValueOptions = distances;
        vc.selectedKey = self.meetEvent.distance;
        vc.initialSegueId = segue.identifier;
    }
    else if ([segue.identifier isEqualToString:@"ageClassSegue"])
    {
        TTGKeyValueOptionsTVC * vc = segue.destinationViewController;
        NSMutableArray *ages = [[NSMutableArray alloc] init];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:6 andDescription:@"6 and under"]];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:8 andDescription:@"8 and under"]];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:10 andDescription:@"10 and under"]];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:12 andDescription:@"12 and under"]];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:14 andDescription:@"14 and under"]];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:18 andDescription:@"18 and under"]];
        [ages addObject:[[TTGSwimOption alloc] initWithKey:99 andDescription:@"open"]];

        vc.selectedKey = self.meetEvent.maxAge;
        vc.keyValueOptions = ages;
        vc.initialSegueId = segue.identifier;
    }
}

- (IBAction)done:(UIStoryboardSegue *)segue {
    TTGKeyValueOptionsTVC *cc = [segue sourceViewController];
    if ([cc.initialSegueId isEqualToString:@"distanceSegue"])
    {
        self.meetEvent.distance = cc.selectedKey;
    }
    else if ([cc.initialSegueId isEqualToString:@"ageClassSegue"])
    {
        self.meetEvent.maxAge = cc.selectedKey;
    }
}

@end
