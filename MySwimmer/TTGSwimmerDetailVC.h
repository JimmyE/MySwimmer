//
//  TTGSwimmerDetailVC.h
//  MySwimmer
//
//  Created by Jim on 10/2/13.
//  Copyright (c) 2013 TangoTiger. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Swimmer.h"

@interface TTGSwimmerDetailVC : UIViewController  <UITextFieldDelegate>

//@property (nonatomic, weak) Swimmer *swimmer;
@property (nonatomic) NSManagedObjectID *swimmerId;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
