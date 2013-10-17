//
//  SignInTableViewController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBManager.h"

@interface SignInTableViewController : UITableViewController <UITextFieldDelegate,FBManagerDelegate>

@property(nonatomic, strong)IBOutlet UIBarButtonItem *signInButton;
-(void)loginFacebook;
-(void)reloadTabBarAfterLogin;
-(IBAction)signIn:(id)sender;
@end
