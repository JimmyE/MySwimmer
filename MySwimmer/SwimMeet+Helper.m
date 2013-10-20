//
//  SwimMeet+Helper.m
//  MySwimmer
//
//  Created by Jim on 10/12/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "SwimMeet+Helper.h"

@implementation SwimMeet (Helper)

-(NSString*) CourseTypeDescription
{
    switch ([self.meetType intValue]) {
        case 0:
            return @"SCM";
        case 1:
            return @"LCM";
        case 2:
            return @"SCY";
            
        default:
            break;
    }
    
    return @"?";
}

- (NSArray*) EventDistances {
    NSArray* scmDistances = @[@25, @50, @100, @200, @400, @800, @1500];
    NSArray* scyDistances = @[@25, @50, @100, @200, @500, @1000, @1650];
    NSArray* lcmDistances = @[@50, @100, @200, @400, @800, @1500];

    switch ([self.meetType intValue]) {
        case 0:
            return scmDistances;
        case 1:
            return lcmDistances;
        case 2:
            return scyDistances;
            
        default:
            break;
    }

    return [[NSArray init] alloc];
}
@end
