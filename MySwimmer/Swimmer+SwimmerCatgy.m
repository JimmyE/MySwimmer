//
//  Swimmer+SwimmerCatgy.m
//  MySwimmer
//
//  Created by Jim on 10/4/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "Swimmer+SwimmerCatgy.h"

@implementation Swimmer (SwimmerCatgy)

-(NSString*) fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

-(NSInteger) age
{
    if (self.birthDate == nil) {
        return 0;
    }
    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:self.birthDate
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    return age;
}

- (NSString*) birthDateMMDDYYY
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    return [dateFormatter stringFromDate:self.birthDate];
}

- (NSString*) boyOrGirl
{
    return [self.gender integerValue] == 0 ? @"boy" : @"girl";
}

@end
