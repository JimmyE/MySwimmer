//
//  TTGMeetInfoCell.h
//  MySwimmer
//
//  Created by Jim on 10/8/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTGMeetInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *meetInfoName;
@property (weak, nonatomic) IBOutlet UITextField *meetLocationField;
@property (weak, nonatomic) IBOutlet UITextField *meetDateField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *meetType;

@end
