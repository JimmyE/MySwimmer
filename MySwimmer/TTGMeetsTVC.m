//
//  TTGMeetsTVC.m
//  MySwimmer
//
//  Created by Jim on 10/8/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGMeetsTVC.h"
#import "TTGMeetCell.h"
#import "SwimMeet.h"
#import "TTGISwimmerVC.h"
#import "TTGHelper.h"

@interface TTGMeetsTVC ()
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end

@implementation TTGMeetsTVC
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
}

- (void) viewDidAppear:(BOOL)animated
{
    [self loadTable];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI actions/events
- (IBAction)addMeetTapped:(id)sender {
    [self performSegueWithIdentifier:@"meetInfoSegue" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"(meets) numberOfRowsInSection: %lu", (unsigned long)[sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"meetCell";
    TTGMeetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    SwimMeet *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *meetType = @"";
    cell.nameField.text = info.name;
    cell.dateField.text = [TTGHelper formatDateMMDDYYYY:info.meetDate];
    switch (info.meetType.integerValue) {
        case 0:
            meetType = @"SCM";
            break;
        case 1:
            meetType = @"LCM";
            break;
        case 2:
            meetType = @"SCY";
            break;
        default:
            break;
    }
    cell.meetType.text = meetType;
    return cell;
}

#pragma mark - CoreData
- (NSFetchedResultsController *)fetchedResultsController {
    
    NSLog(@"fetchedResultsController");
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"SwimMeet" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"meetDate" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"RootMeets1"];
    self.fetchedResultsController = theFetchedResultsController;
    //_fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void) loadTable
{
    NSLog(@"loadTable");
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"meetInfoSegue"])
    {
        id<TTGISwimmerVC> foo = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        foo.detailObjectId = indexPath != nil ? [[_fetchedResultsController objectAtIndexPath:indexPath] objectID] : nil;
        foo.managedObjectContext = managedObjectContext;
    }
}


@end
