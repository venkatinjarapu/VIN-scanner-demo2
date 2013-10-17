//
//  PriceSliderTableViewCell.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 23/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "PriceSliderTableViewCell.h"
#import "PriceSliderViewController.h"
@implementation PriceSliderTableViewCell
@synthesize setPriceLabel,setPriceUISlider,lbl_blackcircle;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
     ;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setGroupingSeparator:@","];
    
    [numberFormatter setGroupingSize:3];
    
    [numberFormatter setUsesGroupingSeparator:YES];
    
    NSString *theString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:sender.value]];
    
    self.setPriceLabel.text= theString;
    
    self.lbl_blackcircle.text =  [NSString stringWithFormat:@"$%d", (((int)sender.value) + (((int)sender.value)*10/100))/60];
    
    
}

@end
