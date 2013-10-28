//
//  TTGKeyValueOptionsTVC.h
//  MySwimmer
//
//  Created by Jim on 10/27/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGSwimOption.h"

@interface TTGKeyValueOptionsTVC : UITableViewController
@property (strong, nonatomic) NSArray *keyValueOptions;  // array of TTGSwimOptions
@property (strong, nonatomic) NSNumber* selectedKey;
@property (strong, nonatomic) NSString* initialSegueId;
@end
