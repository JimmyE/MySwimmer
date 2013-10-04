//
//  TTGSwimmerDetailVC.m
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimmerDetailVC.h"

@interface TTGSwimmerDetailVC ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthDateField;

@property (nonatomic, strong) Swimmer *swimmer;


@end

@implementation TTGSwimmerDetailVC

@synthesize swimmerId;
@synthesize managedObjectContext;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    self.navigationItem.rightBarButtonItem.action = @selector(save);

    if (swimmerId == nil)
    {
        NSLog(@"New swimmer");
        [self setEditing:YES animated:NO];  // new swimmer
        _swimmer = [NSEntityDescription insertNewObjectForEntityForName:@"Swimmer" inManagedObjectContext:self.managedObjectContext];
    }
    else
    {
        NSLog(@"Edit swimmer.id: %ld", (long)swimmerId);
        [self setEditing:NO animated:NO];
        _swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:swimmerId];
        [self loadSwimmer];
    }
}

- (void) save
{
    NSLog(@"Save swimmer");
    _swimmer.firstName = self.firstNameField.text;
    _swimmer.lastName = self.lastNameField.text;
    
}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
    [super setEditing:flag animated:animated];
    
    [self enableDisableFields:flag]	;

    
    if (flag == YES){
        // Change views to edit mode.
    }
    else {
        // Save the changes if needed and change the views to noneditable.
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)textFieldDidEndEditing:(UITextField*)textField    {
    /*
    if( textField == self.firstNameField )
        _swimmer.name = textField.text;
    else if( textField == self.lastNameField  )
        _swimmer.name = textField.text;
    
    NSLog(@"swimmer.name %@", _swimmer.name);
    
    [self becomeFirstResponder];
     */
}

- (void) loadSwimmer
{
    self.firstNameField.text = _swimmer.firstName;
    self.lastNameField.text = _swimmer.lastName;
}

- (void) enableDisableFields:(BOOL) enableFields
{
    self.firstNameField.enabled = enableFields;
    self.lastNameField.enabled = enableFields;
    self.birthDateField.enabled = enableFields;
}

@end
