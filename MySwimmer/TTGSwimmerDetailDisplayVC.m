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
    if (swimmerId != nil)
    {
        [self loadSwimmerView];
    }
}

- (void) loadSwimmerView
{
    Swimmer *swimmer = (Swimmer*) [managedObjectContext objectRegisteredForID:swimmerId];
    self.nameField.text = swimmer.fullName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier  isEqual: @"editSwimmerSegue"])
    {
        TTGSwimmerDetailVC *foo = segue.destinationViewController;
        foo.swimmerId = swimmerId;
        foo.managedObjectContext = managedObjectContext;
    }
}

@end
