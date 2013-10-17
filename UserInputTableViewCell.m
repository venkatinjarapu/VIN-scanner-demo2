//
//  UserInputTableViewCell.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "UserInputTableViewCell.h"

@implementation UserInputTableViewCell
@synthesize loginInfoInputTextField, headerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 250, 15)];
        self.headerLabel.textColor = [UIColor clearColor];
        self.headerLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.headerLabel.backgroundColor = [UIColor clearColor];
        
        self.loginInfoInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 290, 20)];
        [self.loginInfoInputTextField setClearsOnBeginEditing:YES];
        self.loginInfoInputTextField.textColor = [UIColor grayColor];
        self.loginInfoInputTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
        self.loginInfoInputTextField.backgroundColor = [UIColor clearColor];        
        [self.loginInfoInputTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        //[self.contentView addSubview:self.headerLabel];
        [self.contentView addSubview:self.loginInfoInputTextField];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //self.loginInfoInputTextField.delegate = self;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
