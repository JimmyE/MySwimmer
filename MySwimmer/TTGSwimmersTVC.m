//
//  TTGSwimmersTVC.m
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimmersTVC.h"
#import "TTGSwimmerDetailVC.h"
#import "TTGSwimmerDetailDisplayVC.h"
#import "TTGSwimmerCell.h"
#import "Swimmer+SwimmerCatgy.h"
#import "TTGISwimmerVC.h"

@interface TTGSwimmersTVC ()
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TTGSwimmersTVC
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

  //  [self loadTable];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewDidAppear:(BOOL)animated
{
    /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Swimmer" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;

    NSLog(@"query database - viewWillAppear");
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"name"]);
    }
    */
    [self loadTable];
    [self.tableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    NSLog(@"numberOfRowsInSection: %lu", (unsigned long)[sectionInfo numberOfObjects]);
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SwimCell";
    TTGSwimmerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Swimmer *info = [_fetchedResultsController objectAtIndexPath:indexPath];

    cell.nameField.text = [info fullName];
    cell.ageField.text = [@([info age]) description];
    
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
                                   entityForName:@"Swimmer" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"lastName" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root3"];
    self.fetchedResultsController = theFetchedResultsController;
    //_fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Navigation

- (IBAction)addNewSwimmer:(id)sender {
    [self performSegueWithIdentifier:@"swimmerDetailSegue" sender:self];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

   if ([segue.identifier  isEqual: @"swimmerDetailSegue"] || [segue.identifier isEqual:@"addSwimmerSegue"])
    {
        id<TTGISwimmerVC> foo = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        foo.detailObjectId = indexPath != nil ? [[_fetchedResultsController objectAtIndexPath:indexPath] objectID] : nil;
        foo.managedObjectContext = managedObjectContext;
    }
}


@end
