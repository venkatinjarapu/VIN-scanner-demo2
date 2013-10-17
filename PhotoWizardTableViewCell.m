//
//  PhotoWizardTableViewCell.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 21/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "PhotoWizardTableViewCell.h"

@implementation PhotoWizardTableViewCell
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 250, 35)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(260, 14, 16, 16)];
        arrowImageView.image = [UIImage imageNamed:@"arrow_right_grey.png"];
        [self.contentView addSubview:arrowImageView];                
        [self.contentView addSubview:self.titleLabel];        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
