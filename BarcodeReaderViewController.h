//
//  InformationViewController.h
//  BlinkerMobileAppIOS
//
//  Created by Nabarun Banerjee on 31/07/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "BaseViewController.h"

@interface BarcodeReaderViewController : BaseViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate, ZBarReaderDelegate>

- (IBAction)takeBarcodeImage:(id)sender;
- (IBAction)enterVIN:(id)sender;

@end
