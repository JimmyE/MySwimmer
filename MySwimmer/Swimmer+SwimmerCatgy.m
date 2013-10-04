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
@end
