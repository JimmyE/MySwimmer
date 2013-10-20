//
//  TTGDistanceOptionsTVC.m
//  MySwimmer
//
//  Created by Jim on 10/19/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGDistanceOptionsTVC.h"

@interface TTGDistanceOptionsTVC ()
@property (strong, nonatomic) NSArray *distanceForEvents;
@end

@implementation TTGDistanceOptionsTVC

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

    self.distanceForEvents = self.meetEvent.forMeet.EventDistances;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.distanceForEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"distanceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    int distanceOption = [[self.distanceForEvents objectAtIndex:indexPath.row] intValue];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d  (%@)", distanceOption, self.meetEvent.forMeet.CourseTypeDescription];
    if (distanceOption == [self.meetEvent.distance integerValue])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSIndexPath *oldIndex = [self.tableView indexPathForSelectedRow];

//    [self.tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
//    [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;

    self.meetEvent.distance = [self.distanceForEvents objectAtIndex:indexPath.row] ;
    [self.tableView reloadData];
    [[self navigationController] popViewControllerAnimated:YES];

    return indexPath;
}

@end
