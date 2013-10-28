//
//  TTGKeyValueOptionsTVC.m
//  MySwimmer
//
//  Created by Jim on 10/27/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGKeyValueOptionsTVC.h"
#import "TTGSwimOption.h"

@interface TTGKeyValueOptionsTVC ()

@end

@implementation TTGKeyValueOptionsTVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keyValueOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"keyValueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    TTGSwimOption *swimOption = [self.keyValueOptions objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [swimOption description]];
    if (swimOption.key == [self.selectedKey intValue])
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
    
    TTGSwimOption *option = [self.keyValueOptions objectAtIndex:indexPath.row];
    self.selectedKey = [NSNumber numberWithInt:option.key];
    [self.tableView reloadData];
    [[self navigationController] popViewControllerAnimated:YES];
    
    return indexPath;
}


@end
