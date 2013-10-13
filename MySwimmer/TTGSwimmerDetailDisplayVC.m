//
//  TTGSwimmerDetailDisplayVC.m
//  MySwimmer
//
//  Created by Jim on 10/7/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimmerDetailDisplayVC.h"
#import "TTGSwimmerDetailVC.h"
#import "Swimmer.h"
#import "Swimmer+SwimmerCatgy.h"

@interface TTGSwimmerDetailDisplayVC ()
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *birthdayField;
@property (weak, nonatomic) IBOutlet UILabel *genderField;

@end

@implementation TTGSwimmerDetailDisplayVC
@synthesize detailObjectId;
@synthesize managedObjectContext;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    if (detailObjectId != nil)
    {
        [self loadSwimmerView];
    }
    
   // self.editing = NO;
}

- (void) loadSwimmerView
{
    Swimmer *swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:detailObjectId];
    self.nameField.text = swimmer.fullName;
    self.genderField.text = swimmer.boyOrGirl;
    self.birthdayField.text = [NSString stringWithFormat:@"%@  (%ld)", swimmer.birthDateMMDDYYY, (long)swimmer.age];
}

- (IBAction)editSwimmerTapped:(id)sender {
    [self editSwimmer];
}

- (void) editSwimmer
{
    [self performSegueWithIdentifier:@"editSwimmerSegue" sender:self];    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier  isEqual: @"editSwimmerSegue"])
    {
        NSLog(@"segue to edit-detail view");
        TTGSwimmerDetailVC *foo = segue.destinationViewController;
        foo.detailObjectId = detailObjectId;
        foo.managedObjectContext = managedObjectContext;
    }
}

@end
