//
//  SwimMeet.h
//  MySwimmer
//
//  Created by Jim on 10/9/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MeetEvent;

@interface SwimMeet : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * meetDate;
@property (nonatomic, retain) NSNumber * meetType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *hasEvents;
@end

@interface SwimMeet (CoreDataGeneratedAccessors)

- (void)addHasEventsObject:(MeetEvent *)value;
- (void)removeHasEventsObject:(MeetEvent *)value;
- (void)addHasEvents:(NSSet *)values;
- (void)removeHasEvents:(NSSet *)values;

@end
