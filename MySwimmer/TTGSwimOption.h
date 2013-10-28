//
//  TTGSwimOption.h
//  MySwimmer
//
//  Created by Jim on 10/27/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTGSwimOption : NSObject
@property (assign) int key;
@property (strong, nonatomic) NSString* description;

-(id) initWithKey:(int) key andDescription:(NSString*) desc;

@end
