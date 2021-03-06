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
//@property (weak, nonatomic) IBOutlet UIDatePicker *birthDateField;
//@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;

@property (nonatomic, strong) Swimmer *swimmer;
//@property (nonatomic,strong) NSManagedObjectContext *moc;

@end

@implementation TTGSwimmerDetailVC

@synthesize detailObjectId;
@synthesize managedObjectContext;
bool isNewSwimmer = NO;


- (void)viewDidLoad
{
    [super viewDidLoad];

    //.birthDateField.maximumDate = [NSDate date];
    
    NSDate *birthDate;
    NSString *title = @"New";
    if (detailObjectId != nil) {
        self.swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:detailObjectId];
        [self loadSwimmer];
        title = self.swimmer.lastName;
        birthDate = self.swimmer.birthDate;
    }
    else{
       // self.moc = [[self managedObjectContext] initWithConcurrencyType:NSConfinementConcurrencyType];
        //self.moc.undoManager = [[NSUndoManager alloc] init];
        //[self.moc.undoManager beginUndoGrouping];

        self.swimmer = [NSEntityDescription insertNewObjectForEntityForName:@"Swimmer" inManagedObjectContext:self.managedObjectContext];
        isNewSwimmer = YES;
        birthDate = [NSDate date];
    }
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.date = birthDate;

    [datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    self.birthDateTextField.inputView = datePicker;

}

- (IBAction)doneTapped:(id)sender {
    [self save];
    [self closePopup];
}

- (void) undoChanges {
    //[self.moc.undoManager endUndoGrouping];
    //[self.moc.undoManager undo];
    //[self.managedObjectContext undo];
    
    if (isNewSwimmer == YES) {  //delete/remove newly added swimmer
        [managedObjectContext refreshObject:self.swimmer mergeChanges:NO];
    }
}

- (IBAction)cancelTapped:(id)sender {
    [self undoChanges];
    [self closePopup];
}

- (void) save {
//        * todo: remove 'new' swimmer before returning
    if (self.firstNameField.text.length == 0 && self.lastNameField.text.length == 0)
    {
        NSLog(@"No name!, skip save and close");
        [self undoChanges];
        return;
    }
    
    NSLog(@"Save swimmer");
    
    self.swimmer.firstName = self.firstNameField.text;
    self.swimmer.lastName = self.lastNameField.text;
    self.swimmer.gender = [NSNumber numberWithInt: [self.genderField selectedSegmentIndex]];

    // strip 'time' component from date field
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    UIDatePicker *picker =  (UIDatePicker *) [self.birthDateTextField inputView];
    NSDateComponents* components = [calendar components:flags fromDate:picker.date];
    self.swimmer.birthDate = [calendar dateFromComponents:components];
}

- (void) closePopup {
    //[[self navigationController] popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)genderTapped:(id)sender {
    [[self view] endEditing:YES];  //close keyboard
}

- (void) datePickerValueChanged {
    UIDatePicker *picker =  (UIDatePicker *) [self.birthDateTextField inputView];
    self.birthDateTextField.text = [TTGHelper formatDateMMDDYYYY:picker.date];
}

- (void) loadSwimmer {
    self.firstNameField.text = self.swimmer.firstName;
    self.lastNameField.text = self.swimmer.lastName;
    self.genderField.selectedSegmentIndex = [self.swimmer.gender  integerValue];
    
    if (_swimmer.birthDate != nil )
    {
//        self.birthDateField.date = self.swimmer.birthDate;
        self.birthDateTextField.text = self.swimmer.birthDateMMDDYYY;
    }
}

@end
