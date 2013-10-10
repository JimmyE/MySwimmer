//
//  TTGHelper.h
//  MySwimmer
//
//  Created by Jim on 10/9/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>

//Constants
typedef enum  {
    Boy = 0,
    Girl = 1
} TTGGenderType;

typedef enum  {
    Free = 0,
    Back = 1,
    Breast = 2,
    Fly = 3
} TTGStrokeType;

enum TTGMeetType {
    SCM = 0,
    LCM = 1,
    SCY = 2
};


@interface TTGHelper : NSObject
+ (NSString*) formatDateMMDDYYYY:(NSDate*)fromDate;
+ (NSString*) GenderDescription:(TTGGenderType)genderType;
+ (NSString*) StrokeDescription:(TTGStrokeType)strokeType;
@end


