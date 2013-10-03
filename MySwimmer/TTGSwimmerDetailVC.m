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
//@synthesize swimmer;
@synthesize swimmerId;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    self.navigationItem.rightBarButtonItem.action = @selector(save);

//    if (swimmer.objectID == nil)
    if (swimmerId == 0)
    {
        [self setEditing:YES animated:NO];  // new swimmer
    }
    else
    {
        [self setEditing:NO animated:NO];
    }
}

- (void) save
{
    NSLog(@"Save swimmer");
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

- (IBAction)cancelTapped:(id)sender {
}

- (IBAction)doneTapped:(id)sender {
    // save data
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) enableDisableFields:(BOOL) enableFields
{
    self.firstNameField.enabled = enableFields;
    self.lastNameField.enabled = enableFields;
    self.birthDateField.enabled = enableFields;
}

@end
