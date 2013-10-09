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

@end
