//
//  UserInputTableViewCell.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInputTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    UILabel *headerLabel;
    UITextField *loginInfoInputTextField;
}
@property (nonatomic, strong)UILabel *headerLabel;
@property (nonatomic, strong)UITextField *loginInfoInputTextField;

@end
