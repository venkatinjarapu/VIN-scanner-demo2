//
//  LoginWithFacebookTableViewCell.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginWithFacebookTableViewCell : UITableViewCell
{
    UILabel *titleLabel;
    UIImageView *facebookLogoImageView;
}
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *facebookLogoImageView;

@end
