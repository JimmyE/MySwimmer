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
    self.navigationItem.rightBarButtonItem = [self editButtonItem];

    if (swimmerId == nil)
    {
        NSLog(@"New swimmer");
        self.editing = YES;
        _swimmer = [NSEntityDescription insertNewObjectForEntityForName:@"Swimmer" inManagedObjectContext:self.managedObjectContext];
    }
    else
    {
        _swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:swimmerId];
        [self loadSwimmer];
        self.editing = NO;
    }
}

- (void) save
{
    NSLog(@"Save swimmer");
    _swimmer.firstName = self.firstNameField.text;
    _swimmer.lastName = self.lastNameField.text;
    self.editing = NO;
}

- (void) enterEditMode
{
    [self setEditing:YES animated:YES];
}

- (void) cancel
{
    [self loadSwimmer];
    self.editing = NO;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
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
}

- (void) enableDisableFields:(BOOL) enableFields
{
    self.firstNameField.enabled = enableFields;
    self.lastNameField.enabled = enableFields;
    self.birthDateField.enabled = enableFields;
}

@end
