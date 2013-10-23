//
//  TTGEventEditTVC.m
//  MySwimmer
//
//  Created by Jim on 10/12/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGEventEditTVC.h"
#import "TTGDistanceOptionsTVC.h"

@interface TTGEventEditTVC ()
@property (weak, nonatomic) IBOutlet UILabel *meetNameField;
@property (weak, nonatomic) IBOutlet UITextField *eventNbrField;
@property (weak, nonatomic) IBOutlet UITextField *ageClassField;
@property (weak, nonatomic) IBOutlet UITextField *eventeTypeField; //todo: timed final, prelim, or final
@property (weak, nonatomic) IBOutlet UISegmentedControl *strokeField;
@property (weak, nonatomic) IBOutlet UILabel *distanceField;
@property (weak, nonatomic) IBOutlet UIStepper *eventNbrStepper;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)eventStepperValueChanged:(id)sender;
@property (strong, nonatomic) MeetEvent *meetEvent;
@property (strong, nonatomic) SwimMeet *swimMeet;

@property (strong, nonatomic) NSArray *meetAgeGroupOptions;
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
    
    self.meetAgeGroupOptions = @[ @"6 and under", @"8 and under", @"10 and under", @"12 and under"];
    
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
    self.ageClassField.text = [_meetEvent AgeClassDescription];
    self.eventeTypeField.text = @"timed final";
    self.distanceField.text = [NSString stringWithFormat:@"%@ %@", _meetEvent.distance, [_meetEvent.forMeet CourseTypeDescription]];
    self.strokeField.selectedSegmentIndex = [_meetEvent.strokeType intValue];
        
    self.eventNbrStepper.value = _meetEvent.number.intValue;
    self.meetNameField.text = _swimMeet.name;
 }

- (void) enableInputFields:(BOOL) enableFields
{
    self.eventNbrField.enabled = enableFields;
    self.ageClassField.enabled   = enableFields;
    self.strokeField.enabled    = enableFields;
    self.eventeTypeField.enabled = enableFields;
    self.distanceField.enabled = enableFields;
    
    self.eventNbrField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
    self.ageClassField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
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
    if ([textField isEqual:self.ageClassField]) {
        self.pickerView = [[UIPickerView alloc] init];
//        [self.pickerView  AddTarg]
        textField.inputView = self.pickerView;
        
//        infoCell.meetDatePicker = [[UIDatePicker alloc] init];
//        infoCell.meetDatePicker.datePickerMode = UIDatePickerModeDate;
//        [infoCell.meetDatePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
//        textField.inputView = infoCell.meetDatePicker;
    }
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

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    NSLog(@"pickerView.rows: %d", self.meetAgeGroupOptions.count);
    return self.meetAgeGroupOptions.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
    NSLog(@"titleForRow: %d  title: %@", row, [self.meetAgeGroupOptions objectAtIndex:row]);
    return [self.meetAgeGroupOptions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    
}

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


/*
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.pickerView reloadAllComponents];
}
 */

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
        TTGDistanceOptionsTVC *foo = segue.destinationViewController;
        foo.meetEvent = self.meetEvent;
    }
}

@end
