//
//  MeetEvent+MeetEventCatgy.m
//  MySwimmer
//
//  Created by Jim on 10/9/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "MeetEvent+MeetEventCatgy.h"

@implementation MeetEvent (MeetEventCatgy)

- (TTGStrokeType) StrokeTypeAlt  //todo: rename
{
    switch ([self.strokeType intValue]) {
        case 0:
            return Free;
        case 1:
            return Back;
        case 2:
            return Breast;
        case 3:
            return Fly;
        default:
            break;
    }
    
    return Free;
}

- (NSString*) StrokeDescription
{
    switch ([ self StrokeTypeAlt ]) {
        case Free:
            return @"Free";
        case Back:
            return @"Backstroke";
        case Breast:
            return @"Breast";
        case Fly:
            return @"Fly";
            
        default:
            break;
    }
    return @"";
}

- (NSString*) AgeClassDescription
{
    if (self.maxAge > 0)
    {
        return [NSString stringWithFormat:@"%@ and under", self.maxAge];
    }
    return @"";
}

- (NSString*) GenderDescription
{
    return self.gender.intValue == 0 ? @"Boy" : @"Girl";
}

- (TTGGenderType) GenderTypeAlt
{
    
    return self.gender.intValue == 0 ? Boy : Girl;
}

-(NSString*) EventDescription
{
    
    NSString *relay = self.isRelay ? @"Relay" : @"";
    return [NSString stringWithFormat:@"#%@ %@ %@ %@ %@", self.number,
            [TTGHelper GenderDescription:(self.GenderTypeAlt)],
            self.distance,
            [TTGHelper StrokeDescription:(self.StrokeTypeAlt)], relay  ];
}
@end
