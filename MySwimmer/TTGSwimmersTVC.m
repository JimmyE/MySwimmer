//
//  TTGSwimmersTVC.m
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimmersTVC.h"
#import "TTGSwimmerDetailVC.h"
#import "TTGSwimmerCell.h"
#import "Swimmer+SwimmerCatgy.h"

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
    NSLog(@"numberOfRowsInSection: %d", [sectionInfo numberOfObjects]);
    
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
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    // todo: pass flag/data for new swimmer
    [self performSegueWithIdentifier:@"swimmerDetailSegue" sender:self];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier  isEqual: @"swimmerDetailSegue"])
    {
        TTGSwimmerDetailVC *detailViewController = segue.destinationViewController;
        detailViewController.managedObjectContext = managedObjectContext;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (indexPath == nil )
        {
            detailViewController.swimmerId = 0;
        }
        else
        {
            Swimmer *info = [_fetchedResultsController objectAtIndexPath:indexPath];
            detailViewController.swimmerId = info.objectID;
        }
    }
}


@end
