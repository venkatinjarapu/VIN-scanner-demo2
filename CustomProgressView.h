//
//  CustomProgressView.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 29/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomProgressView : UIView
{
  float current_value;
  float new_to_value;
  
  UILabel *ProgressLbl;
  
  id delegate;
  
  BOOL IsAnimationInProgress;
}
@property (nonatomic, retain)UILabel *ProgressLbl;
@property id delegate;
@property float current_value;

- (id)initWithFrame:(CGRect)frame;
- (void)setProgress:(NSNumber*)value withColor:(UIColor *)color;

@end

@protocol CustomProgressViewDelegate
- (void)didFinishAnimation:(CustomProgressView*)progressView;
@end
