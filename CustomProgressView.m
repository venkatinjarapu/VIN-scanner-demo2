//
//  CustomProgressView.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 29/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "CustomProgressView.h"

@implementation CustomProgressView

@synthesize current_value;
@synthesize delegate, ProgressLbl;

- (id)initWithFrame:(CGRect)frame
{  
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    current_value = 0.0;
    new_to_value = 0.0;
    IsAnimationInProgress = NO;
    
    self.alpha = 0.95;
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
   // ProgressLbl = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-70)/2, self.frame.size.height/2-50, 70, 13.0)];
    ProgressLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    ProgressLbl.font = [UIFont fontWithName:@"Helvatica" size:15.0];
    ProgressLbl.text = @"0%";
    ProgressLbl.backgroundColor = [UIColor clearColor];
    ProgressLbl.textColor = [UIColor whiteColor];
    ProgressLbl.textAlignment = NSTextAlignmentCenter ;
    ProgressLbl.alpha = self.alpha;
    [self addSubview:ProgressLbl];
  }
  return self;
}

-(void)UpdateLabelsWithValue:(NSString*)value
{
  ProgressLbl.text = value;
}

-(void)setProgressValue:(float)to_value withAnimationTime:(float)animation_time
{
  float timer = 0;
  
  float step = 0.1;
  
  float value_step = (to_value-self.current_value)*step/animation_time;
  int final_value = self.current_value*100;
  
  while (timer<animation_time-step) {
    final_value += floor(value_step*100);
    [self performSelector:@selector(UpdateLabelsWithValue:) withObject:[NSString stringWithFormat:@"%i%%", final_value] afterDelay:timer];
    timer += step;
  }
  
  [self performSelector:@selector(UpdateLabelsWithValue:) withObject:[NSString stringWithFormat:@"%.0f%%", to_value*100] afterDelay:animation_time];
}

-(void)SetAnimationDone:(UIColor *)color
{
  IsAnimationInProgress = NO;
  if (new_to_value>self.current_value)
    [self setProgress:[NSNumber numberWithFloat:new_to_value]withColor:color];
}

- (void)setProgress:(NSNumber*)value withColor:(UIColor *)color{
  
  float to_value = [value floatValue];
  NSLog(@"%@", color);
  
  if (to_value<=self.current_value)
    return;
  else if (to_value>1.0)
    to_value = 1.0;
  
  if (IsAnimationInProgress)
  {
    new_to_value = to_value;
    return;
  }
  
  IsAnimationInProgress = YES;
  
  float animation_time = to_value-self.current_value;
  
  [self performSelector:@selector(SetAnimationDone:) withObject:color afterDelay:animation_time];
  
  
  if (to_value == 1.0 && delegate && [delegate respondsToSelector:@selector(didFinishAnimation:)])
    [delegate performSelector:@selector(didFinishAnimation:) withObject:self afterDelay:animation_time];
  
  [self setProgressValue:to_value withAnimationTime:animation_time];
  
  float start_angle = 2*M_PI*self.current_value + M_PI_2;
  float end_angle = 2*M_PI*to_value + M_PI_2;
  
  float radius = 25.0;
  
  CAShapeLayer *circle = [CAShapeLayer layer];
  
  // Make a circular shape
  
  circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)
                                               radius:radius startAngle:start_angle endAngle:end_angle clockwise:YES].CGPath;
  
  // Configure the apperence of the circle
  circle.fillColor = [UIColor clearColor].CGColor;
  circle.strokeColor = color.CGColor;
  circle.lineWidth = 5;
  
  // Add to parent layer
  [self.layer addSublayer:circle];
  
  // Configure animation
  CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  
  drawAnimation.duration            = animation_time;
  drawAnimation.repeatCount         = 0.0;  // Animate only once..
  drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
  
  // Animate from no part of the stroke being drawn to the entire stroke being drawn
  drawAnimation.fromValue = [NSNumber numberWithFloat:0.0];
  drawAnimation.toValue   = [NSNumber numberWithFloat:1.0];
  
  // Experiment with timing to get the appearence to look the way you want
  drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  
  // Add the animation to the circle
  [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
  self.current_value = to_value;
}

@end
