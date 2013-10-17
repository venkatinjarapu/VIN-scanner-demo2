//
//  PriceSliderTableViewCell.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 23/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceSliderViewController.h"
@interface PriceSliderTableViewCell : UITableViewCell{
    
}
@property (nonatomic, strong) NSString *str_lbltext;
@property (nonatomic, weak)IBOutlet UISlider *setPriceUISlider;
@property (nonatomic, weak)IBOutlet UILabel *setPriceLabel;
@property (nonatomic, strong) NSString *str_forLable;
@property(nonatomic,strong)IBOutlet UILabel *lbl_blackcircle;

- (IBAction)sliderValueChanged:(UISlider *)sender;
@end

