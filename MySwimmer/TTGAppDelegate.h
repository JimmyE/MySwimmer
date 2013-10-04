//
//  TTGAppDelegate.h
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
