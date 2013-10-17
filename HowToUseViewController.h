//
//  HowToUseViewController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 22/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HowToUseViewController : BaseViewController
{
  UIImageView *midImageView;
  UIImageView *leftImageView;
  UIImageView *rightImageView;
  UIImageView *leftArrowImageView;
  UIImageView *rightArrowImageView;
  UILabel *titleLabel;
  UILabel *messageLabel;
  int index;
  
}

@property(nonatomic, retain)IBOutlet UIImageView *midImageView;
@property(nonatomic, retain)IBOutlet UIImageView *leftImageView;
@property(nonatomic, retain)IBOutlet UIImageView *rightImageView;
@property(nonatomic, retain)IBOutlet UIImageView *leftArrowImageView;
@property(nonatomic, retain)IBOutlet UIImageView *rightArrowImageView;
@property(nonatomic, retain)IBOutlet UILabel *titleLabel;
@property(nonatomic, retain)IBOutlet UILabel *messageLabel;
@property(nonatomic, assign)int index;

@end
