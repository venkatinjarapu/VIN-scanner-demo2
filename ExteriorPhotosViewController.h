//
//  ExteriorPhotosViewController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 22/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ExteriorPhotosViewController : BaseViewController<UIImagePickerControllerDelegate,
                                                           UINavigationControllerDelegate>

-(IBAction)takePhoto:(id)sender;
@end
