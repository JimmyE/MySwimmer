//
//  SwimMeet.h
//  MySwimmer
//
//  Created by Jim on 10/8/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SwimMeet : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * meetType;
@property (nonatomic, retain) NSDate * meetDate;
@property (nonatomic, retain) NSString * location;

@end
