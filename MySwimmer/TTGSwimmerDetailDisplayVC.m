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

@end

@implementation TTGSwimmerDetailDisplayVC
@synthesize swimmerId;
@synthesize managedObjectContext;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (swimmerId != nil)
    {
        [self loadSwimmerView];
    }
    
    self.editing = NO;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) loadSwimmerView
{
    Swimmer *swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:swimmerId];
    self.nameField.text = swimmer.fullName;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //[super setEditing:editing animated:animated];
    // View-only page- don't trigger 'edit' mode
    
    if (editing)
    {
        [self performSegueWithIdentifier:@"editSwimmerSegue" sender:self];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier  isEqual: @"editSwimmerSegue"])
    {
        NSLog(@"segue to edit-detail view");
        TTGSwimmerDetailVC *foo = segue.destinationViewController;
        foo.swimmerId = swimmerId;
        foo.managedObjectContext = managedObjectContext;
    }
}

@end
