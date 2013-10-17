//
//  LoginWithFacebookTableViewCell.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "LoginWithFacebookTableViewCell.h"

@implementation LoginWithFacebookTableViewCell
@synthesize titleLabel, facebookLogoImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 250, 35)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = @"Login with Facebook";
        
        self.facebookLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 55, 20)];       
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.facebookLogoImageView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
