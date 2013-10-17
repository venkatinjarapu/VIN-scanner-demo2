//
//  HowToUseViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 22/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "HowToUseViewController.h"

@interface HowToUseViewController ()

@end

@implementation HowToUseViewController
@synthesize midImageView, leftImageView, rightImageView,leftArrowImageView, rightArrowImageView, titleLabel, messageLabel, index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    if(index == 0){
        
        self.titleLabel.text = @"Take Photos";
        
        self.messageLabel.text = @"Take photos of your vehicle and archive them to help identify your vehicle and its condition";
        
        self.midImageView.image = [UIImage imageNamed:@"camera_icon.png"];
        
        self.rightImageView.image = [UIImage imageNamed:@"car_icon_sml.png"];
        
        
        
    }else if (index == 1){
        
        self.titleLabel.text = @"Review & Price";
        
        
        
        self.messageLabel.text = @"Learn what your vehicle is worth with direct access to Kelley Blue Book   Using the price slider, set the price you want to sell your vehicle.";
        
        self.midImageView.image = [UIImage imageNamed:@"car_icon.png"];
        
        self.leftImageView.image = [UIImage imageNamed:@"camera_icon_sml.png"];
        
        self.rightImageView.image = [UIImage imageNamed:@"star_stick_sml.png"];
        
        self.leftImageView.hidden = NO;
        
        
        
        UILabel *tmLabel = [[UILabel alloc] initWithFrame:CGRectMake(253, 260, 20, 20)];
        
        [tmLabel setBackgroundColor:[UIColor clearColor]];
        
        tmLabel.text = @"TM";
        
        tmLabel.textColor = [UIColor whiteColor];
        
        tmLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        
        [tmLabel sizeToFit];
        
        [self.view addSubview:tmLabel];
        
        
        
    }else if (index == 2){
        
        self.titleLabel.text = @"Post it Anywhere";
        
        self.messageLabel.text = @"Publishing tools help you post to your social networks while also offering payment options.";
        
        self.midImageView.image = [UIImage imageNamed:@"star_white.png"];
        
        self.leftImageView.image = [UIImage imageNamed:@"car_icon_sml.png"];    
        
        self.rightArrowImageView.hidden = YES;
        
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
