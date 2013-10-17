//
//  VINInputViewController.h
//  BlinkerMobileAppIOS
//
//  Created by Nabarun Banerjee on 01/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleDetailsViewController.h"
#import "BaseViewController.h"

@interface VINInputViewController : BaseViewController <UITextFieldDelegate>

@property (weak, nonatomic)IBOutlet UITextField *inputVINNumberTextField;
@property (nonatomic, retain)NSString *vin;
@property (nonatomic, retain)IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UITextField *inputMileageTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputConditionTextField;

- (IBAction)backToPreviousView:(id)sender;
- (IBAction)getDetails:(id)sender;

@end
