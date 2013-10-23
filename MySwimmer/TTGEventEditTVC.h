//
//  TTGEventEditTVC.h
//  MySwimmer
//
//  Created by Jim on 10/12/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTGISwimmerVC.h"


@interface TTGEventEditTVC : UITableViewController  <TTGISwimmerVC, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic) NSManagedObjectID *swimMeetId;

@end
