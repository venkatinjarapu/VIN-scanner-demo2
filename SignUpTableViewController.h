//
//  SignUpTableViewController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpTableViewController : UITableViewController <UITextFieldDelegate>
@property(nonatomic, strong)IBOutlet UIBarButtonItem *signUpButton;
-(IBAction)signUp:(id)sender;

@end
