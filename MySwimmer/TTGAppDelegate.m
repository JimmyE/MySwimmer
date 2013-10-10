//
//  TTGAppDelegate.m
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGAppDelegate.h"
#import "TTGSwimmersTVC.h"
#import "TTGMeetsTVC.h"

@implementation TTGAppDelegate

@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navController = tabBarController.viewControllers[0];
    TTGSwimmersTVC *swimmerTVC = navController.childViewControllers[0];
    swimmerTVC.managedObjectContext = context;

    navController = tabBarController.viewControllers[1];
    TTGMeetsTVC *meetsTVC = navController.childViewControllers[0];
    meetsTVC.managedObjectContext = context;
    
    [self loadTestData];  // TEMP ***
    return YES;
}

- (void) loadTestData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-yyyy";

    Swimmer *swimmer = [NSEntityDescription insertNewObjectForEntityForName:@"Swimmer" inManagedObjectContext:self.managedObjectContext];
    swimmer.birthDate = [dateFormatter dateFromString:@"05-29-1991"];
    swimmer.firstName = @"Bubby";
    swimmer.lastName = @"Jones";
    swimmer.gender = [NSNumber numberWithInt:0];  //boy
    
    Swimmer *swimmer2 = [NSEntityDescription insertNewObjectForEntityForName:@"Swimmer" inManagedObjectContext:self.managedObjectContext];
    swimmer2.birthDate = [dateFormatter dateFromString:@"04-22-1996"];
    swimmer2.firstName = @"Daisy";
    swimmer2.lastName = @"May";
    swimmer2.gender = [NSNumber numberWithInt:1];  //girl

    SwimMeet *meet1 = [self createMeet:@"Tyr Classic" atLocation:@"St X Natorium" withType:0 onDate:@"08-01-2013"];
    SwimMeet *meet2 =[self createMeet:@"Summer Classic" atLocation:@"Mason" withType:1 onDate:@"06-12-2013"];
    [self createMeet:@"Milford Invitational" atLocation:@"Milford High School" withType:2 onDate:@"10-01-2013"];
    
    [meet1 addHasEventsObject:[self createEvent:20 forMeet:meet1 forStroke:Free forDistance:100 forAgeLimit:12 forGender:Boy]];
    [meet1 addHasEventsObject:[self createEvent:26 forMeet:meet1 forStroke:Fly forDistance:50 forAgeLimit:12 forGender:Boy]];
    [meet1 addHasEventsObject:[self createEvent:36 forMeet:meet1 forStroke:Breast forDistance:50 forAgeLimit:12 forGender:Boy]];
    [meet1 addHasEventsObject:[self createEvent:46 forMeet:meet1 forStroke:Back forDistance:50 forAgeLimit:12 forGender:Boy]];
    
    [meet2 addHasEventsObject:[self createEvent:2 forMeet:meet1 forStroke:Free forDistance:50 forAgeLimit:12 forGender:Boy]];
}

-(SwimMeet*)createMeet:(NSString*)name
            atLocation:(NSString*)location
              withType:(NSInteger) meetType
                onDate:(NSString*) meetDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-yyyy";

    SwimMeet *meet1 = [NSEntityDescription insertNewObjectForEntityForName:@"SwimMeet" inManagedObjectContext:self.managedObjectContext];
    meet1.name = name;
    meet1.location = location;
    meet1.meetType = [NSNumber numberWithInt:meetType];  // todo: enum
    meet1.meetDate = [dateFormatter dateFromString:meetDate];

    return meet1;
}

- (MeetEvent*) createEvent:(NSInteger)eventNbr
                   forMeet:(SwimMeet*) forMeet
                 forStroke:(TTGStrokeType) strokeType
               forDistance:(NSInteger)distance
               forAgeLimit:(NSInteger)maxAge
                 forGender:(TTGGenderType)gender
{
    MeetEvent *event = [NSEntityDescription insertNewObjectForEntityForName:@"MeetEvent" inManagedObjectContext:self.managedObjectContext];

    event.number = [NSNumber numberWithInt:eventNbr];
    event.strokeType = [NSNumber numberWithInt:strokeType];
    event.forMeet = forMeet;
    event.isRelay = NO;
    event.isOpen = NO;
    event.distance = [NSNumber numberWithInteger:distance];
    event.maxAge = [NSNumber numberWithInteger:maxAge];
    event.gender = [NSNumber numberWithInteger:gender];
    
    return event;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SwimmerModel" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SwimmerModel.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];  // DELETE old database, rerun app and should be ok
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
