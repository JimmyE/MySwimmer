//
//  TTGSwimmerDetailVC.m
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimmerDetailVC.h"
#import "Swimmer+SwimmerCatgy.h"

@interface TTGSwimmerDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthDateField;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;

@property (nonatomic, strong) Swimmer *swimmer;


@end

@implementation TTGSwimmerDetailVC

@synthesize swimmerId;
@synthesize managedObjectContext;


- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.navigationItem.rightBarButtonItem = [self editButtonItem];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    cancelButtonItem = nil;

    self.birthDateField.maximumDate = [NSDate date];

    _swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:swimmerId];
   // self.editing = YES;

    [self loadSwimmer];
}

- (IBAction)doneTapped:(id)sender {
    [self save];
    [[self navigationController] popViewControllerAnimated:YES];

}

- (void) save
{
    NSLog(@"Save swimmer");
    _swimmer.firstName = self.firstNameField.text;
    _swimmer.lastName = self.lastNameField.text;
    
    // strip 'time' component from date field
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self.birthDateField.date];
    _swimmer.birthDate = [calendar dateFromComponents:components];
    
    self.birthDateLabel.text = _swimmer.birthDateMMDDYYY;

    //self.editing = NO;
}

- (void) enterEditMode
{
    [self setEditing:YES animated:YES];
}

- (void) cancel
{
    [[self navigationController] popViewControllerAnimated:YES];

}
     
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    /*
    [self enableDisableFields:editing];
    
    self.navigationItem.rightBarButtonItem.action = editing ? @selector(save) : @selector(enterEditMode);
    
    if (!editing)
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
    else
    {
        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        self.navigationItem.leftBarButtonItem = cancelButtonItem;
        cancelButtonItem = nil;
    }
     */
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)textFieldDidEndEditing:(UITextField*)textField    {
}

- (void) loadSwimmer
{
    self.firstNameField.text = _swimmer.firstName;
    self.lastNameField.text = _swimmer.lastName;
    
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
