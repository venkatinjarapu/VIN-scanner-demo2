//
//  BaseViewController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 29/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProgressView.h"

@interface BaseViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
  CustomProgressView *customProgressView;
  NSMutableArray *carImagesArray;
}
@property(nonatomic, strong)CustomProgressView *customProgressView;

- (void)onProgressStarted:(CGRect)rect;
- (void)setProgress:(NSNumber*)value;
- (IBAction)backButtonTap:(id)sender;
- (void)myProgressButtonTap;
- (IBAction)dismissModalViewController:(id)sender;
- (void)postRequest:(NSDictionary *)params url:(NSURL *)apiURL;
@end
