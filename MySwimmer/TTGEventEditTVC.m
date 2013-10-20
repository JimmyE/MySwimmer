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
- (IBAction)eventStepperValueChanged:(id)sender;
@property (strong, nonatomic) MeetEvent *meetEvent;
@property (strong, nonatomic) SwimMeet *swimMeet;
@end

@implementation TTGEventEditTVC
@synthesize detailObjectId;
@synthesize swimMeetId;
@synthesize managedObjectContext;

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
        [self enableDisableFields:NO];
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
    self.ageClassField.text = [_meetEvent AgeClassDescription];
    self.eventeTypeField.text = @"timed final";
    self.distanceField.text = [NSString stringWithFormat:@"%@ %@", _meetEvent.distance, [_meetEvent.forMeet CourseTypeDescription]];
    self.strokeField.selectedSegmentIndex = [_meetEvent.strokeType intValue];
        
    self.eventNbrStepper.value = _meetEvent.number.intValue;
    self.meetNameField.text = _swimMeet.name;
 }

- (void) enableDisableFields:(BOOL) enableFields
{
    self.eventNbrField.enabled = enableFields;
    self.ageClassField.enabled   = enableFields;
    self.strokeField.enabled    = enableFields;
    self.eventeTypeField.enabled = enableFields;
    self.distanceField.enabled = enableFields;
    
    self.eventNbrField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
    self.ageClassField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
//    self.strokeField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
    self.eventeTypeField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;
//    self.distanceField.borderStyle = enableFields ? UITextBorderStyleRoundedRect : UITextBorderStyleNone;

    self.eventNbrStepper.hidden = !enableFields;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    
    [self enableDisableFields:editing];
    
    if (!editing) {
        [self saveEvent];
        [self closePopup];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
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

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"distanceSegue" sender:nil];
}
 */

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"distanceSegue"] )
    {
        TTGDistanceOptionsTVC *foo = segue.destinationViewController;
//        foo.distance = [self.meetEvent.distance integerValue];
        foo.meetEvent = self.meetEvent;
    }
    
}

@end
