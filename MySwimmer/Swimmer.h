//
//  Swimmer.h
//  MySwimmer
//
//  Created by Jim on 10/4/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Swimmer : NSManagedObject

@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end
