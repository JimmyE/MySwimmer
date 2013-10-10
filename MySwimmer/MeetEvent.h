//
//  MeetEvent.h
//  MySwimmer
//
//  Created by Jim on 10/9/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SwimMeet;

@interface MeetEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * strokeType;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * isRelay;
@property (nonatomic, retain) NSNumber * maxAge;
@property (nonatomic, retain) NSNumber * isOpen;
@property (nonatomic, retain) SwimMeet *forMeet;

@end
