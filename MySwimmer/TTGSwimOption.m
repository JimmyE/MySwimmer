//
//  TTGSwimOption.m
//  MySwimmer
//
//  Created by Jim on 10/27/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import "TTGSwimOption.h"

@implementation TTGSwimOption

- (id) initWithKey:(int)key andDescription:(NSString*) desc {
    self = [super init];

    if (self != nil ){
        self.key = key;
        self.description = desc;
    }
    return self;
}
@end
