//
//  TTGEventEditTVC.m
//  MySwimmer
//
//  Created by Jim on 10/12/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGEventEditTVC.h"

@interface TTGEventEditTVC ()
@property (weak, nonatomic) IBOutlet UILabel *meetNameField;
@property (weak, nonatomic) IBOutlet UITextField *eventNbrField;
@property (weak, nonatomic) IBOutlet UITextField *ageClassField;
@property (weak, nonatomic) IBOutlet UITextField *eventeTypeField; //todo: timed final, prelim, or final
@property (weak, nonatomic) IBOutlet UISegmentedControl *strokeField;
@property (weak, nonatomic) IBOutlet UITextField *distanceField;
@property (strong, nonatomic) MeetEvent *meetEvent;
@end

@implementation TTGEventEditTVC
@synthesize detailObjectId;
@synthesize managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadMeetEventInfo];
}

- (void) loadMeetEventInfo
{
    if (self.detailObjectId != nil)
    {
        _meetEvent = (MeetEvent*) [managedObjectContext objectRegisteredForID:detailObjectId];
        self.meetNameField.text = _meetEvent.forMeet.name;
        self.eventNbrField.text = [NSString stringWithFormat:@"%@", _meetEvent.number];
        self.ageClassField.text = [_meetEvent AgeClassDescription];
        self.eventeTypeField.text = @"timed final";
        self.distanceField.text = [NSString stringWithFormat:@"%@ %@", _meetEvent.distance, [_meetEvent.forMeet CourseTypeDescription]];
        self.strokeField.selectedSegmentIndex = [_meetEvent.strokeType intValue];
    }
    
    [self enableDisableFields:NO];
}

- (void) enableDisableFields:(BOOL) enableFields
{
    self.eventNbrField.enabled = enableFields;
    self.ageClassField.enabled   = enableFields;
    self.strokeField.enabled    = enableFields;
    self.eventeTypeField.enabled = enableFields;
    self.distanceField.enabled = enableFields;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 4;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
