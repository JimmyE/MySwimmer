//
//  TTGSwimmerDetailVC.m
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

// "EDIT" swimmer details view controller

#import "TTGSwimmerDetailVC.h"
#import "Swimmer+SwimmerCatgy.h"

@interface TTGSwimmerDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthDateField;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderField;

@property (nonatomic, strong) Swimmer *swimmer;


@end

@implementation TTGSwimmerDetailVC

@synthesize swimmerId;
@synthesize managedObjectContext;


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.birthDateField.maximumDate = [NSDate date];

    NSString *title = @"New";
    if (swimmerId != nil) {
        _swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:swimmerId];
        [self loadSwimmer];
        title = _swimmer.lastName;
    }
    else{
        _swimmer = [NSEntityDescription insertNewObjectForEntityForName:@"Swimmer" inManagedObjectContext:self.managedObjectContext];
    }
}

- (IBAction)doneTapped:(id)sender {
    [self save];
    [self closePopup];
}

- (IBAction)cancelTapped:(id)sender {
    [self closePopup];
}

- (void) save
{
    /*
        * todo: remove 'new' swimmer before returning
    if (self.firstNameField.text.length == 0 && self.lastNameField.text.length == 0)
    {
        NSLog(@"No name!, skip save and close");
        return;
    }
     */
    
    NSLog(@"Save swimmer");
    
    _swimmer.firstName = self.firstNameField.text;
    _swimmer.lastName = self.lastNameField.text;
    _swimmer.gender = [NSNumber numberWithInt: [self.genderField selectedSegmentIndex]];
    
    // strip 'time' component from date field
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self.birthDateField.date];
    _swimmer.birthDate = [calendar dateFromComponents:components];
    
    self.birthDateLabel.text = _swimmer.birthDateMMDDYYY;
}

- (void) closePopup
{
    //[[self navigationController] popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) loadSwimmer
{
//    self.navigationItem.
    self.firstNameField.text = _swimmer.firstName;
    self.lastNameField.text = _swimmer.lastName;
    self.genderField.selectedSegmentIndex = [_swimmer.gender  integerValue];
    
    if (_swimmer.birthDate != nil )
    {
        self.birthDateField.date = _swimmer.birthDate;
        self.birthDateLabel.text = _swimmer.birthDateMMDDYYY;
    }
}

- (void) enableDisableFields:(BOOL) enableFields
{
    self.firstNameField.enabled = enableFields;
    self.lastNameField.enabled = enableFields;

    self.birthDateLabel.hidden = enableFields;
    self.birthDateField.hidden = !enableFields;
}

@end
