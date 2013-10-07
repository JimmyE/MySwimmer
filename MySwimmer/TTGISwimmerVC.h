//
//  TTGISwimmerVC.h
//  MySwimmer
//
//  Created by Jim on 10/7/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTGISwimmerVC <NSObject>

@property (nonatomic) NSManagedObjectID *swimmerId;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
