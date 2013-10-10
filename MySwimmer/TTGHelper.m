//
//  TTGHelper.m
//  MySwimmer
//
//  Created by Jim on 10/9/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGHelper.h"

@implementation TTGHelper

// Returns date in mm-dd-yyyy format
+ (NSString*) formatDateMMDDYYYY:(NSDate*)fromDate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:fromDate];
}

+ (NSString*) GenderDescription:(TTGGenderType)genderType
{
    return genderType == Boy ? @"Boy" : @"Girl";
}

+ (NSString*) StrokeDescription:(TTGStrokeType)strokeType
{
    switch (strokeType) {
        case Free:
            return @"Free";
        case Back:
            return @"Back";
        case Breast:
            return @"Breast";
        case Fly:
            return @"Fly";
        default:
            break;
    }
    
    return @"";
}
@end
