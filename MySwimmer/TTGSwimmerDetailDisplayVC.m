//
//  TTGSwimmerDetailDisplayVC.m
//  MySwimmer
//
//  Created by Jim on 10/7/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimmerDetailDisplayVC.h"
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
@end
