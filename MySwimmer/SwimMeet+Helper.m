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
@end
