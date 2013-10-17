//
//  SignInTableViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "SignInTableViewController.h"
#import "UserInputTableViewCell.h"
#import "LoginWithFacebookTableViewCell.h"
#import "FacebookUserController.h"
#import "SellMyCarViewController.h"
#import "NXOAuth2.h"
#import "AppDelegate.h"


@interface SignInTableViewController ()
{
  NSString *userName;
  NSString *password;
}
@end

@implementation SignInTableViewController
@synthesize signInButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [FBManager facebookConnect].Delegate = self;
    
    [super viewDidLoad];
    self.signInButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRow;
    if(section == 0)numberOfRow = 2;
    else numberOfRow = 1;
    
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"LoginCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if(cell == nil){
        
        if(indexPath.section == 0){
            
            cell = [[UserInputTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }else{
            
            cell = [[LoginWithFacebookTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
        }
        
        
        
    }
    
    UserInputTableViewCell *userInputCell = (UserInputTableViewCell *)cell;
    
    LoginWithFacebookTableViewCell *faceBookLoginCell = (LoginWithFacebookTableViewCell *)cell;
    
    
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            //userInputCell.loginInfoInputTextField.text = @"Email Address";
            
            userInputCell.loginInfoInputTextField.placeholder = @"Email Address";
            
            userInputCell.loginInfoInputTextField.textColor = [UIColor blackColor];
            
            userInputCell.loginInfoInputTextField.tag = 0;
            
            userInputCell.loginInfoInputTextField.delegate = self;
            
            userInputCell.loginInfoInputTextField.keyboardType=UIKeyboardTypeEmailAddress;
            
            userInputCell.loginInfoInputTextField.returnKeyType=UIReturnKeyDone;
            
            
            
        }else if (indexPath.row == 1){
            
            userInputCell.loginInfoInputTextField.placeholder = @"Password";
            
            userInputCell.loginInfoInputTextField.textColor = [UIColor blackColor];
            
            userInputCell.loginInfoInputTextField.tag = 1;
            
            [userInputCell.loginInfoInputTextField setSecureTextEntry:YES];
            
            userInputCell.loginInfoInputTextField.delegate = self;
            
        }
        
    }else{
        
        faceBookLoginCell.facebookLogoImageView.image = [UIImage imageNamed:@""];
        
    }
    
    
    
    return userInputCell;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectinTitle;
    if(section == 0)sectinTitle = @"Login";
    else if (section == 1)sectinTitle = @"Facebook";
    return sectinTitle;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.section == 1)[self loginFacebook];
  if(indexPath.section == 0){
    
  }
}

-(void)loginFacebook{
  //  [FBManager facebookConnect].Delegate = self;
    
//    [[FBManager facebookConnect] Call_FB];
    [self fbconnect];
    /*
  FacebookUserController *facebookUser = [[FacebookUserController alloc]init];
  [facebookUser openSession:^{
    NSLog(@"Success login");
   [self reloadTabBarAfterLogin];
  } onFailure:nil];    */
}

//-(void)FB_Logged_In_Successfully
//{
//    
//}
//-(void)FB_Login_Request_Sent
//{
//    
//}
//-(void)FB_Post_To_Friend_Wall_Request_Sent{
//    
//}
//-(void)FB_Post_To_Friend_Wall_Successfully
//{
//    [self reloadTabBarAfterLogin];
//}
//-(void)FB_Post_To_Wall_Request_Sent{
//    
//}
//-(void)FB_Post_To_Wall_Successfully
//{
//    
//}
-(void)reloadTabBarAfterLogin{
//  NSMutableArray *viewControllersArray = [[NSMutableArray alloc]init];  
//  UINavigationController *photoWizardNavigationController =
//  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
//   instantiateViewControllerWithIdentifier:@"navigation"];
//  
//  [viewControllersArray addObject:photoWizardNavigationController];  
//  self.tabBarController.viewControllers = viewControllersArray;
    AppDelegate *obj_app=(AppDelegate *)[[UIApplication sharedApplication]delegate];

        
        UITabBarController *tabBarController = (UITabBarController *)obj_app.window.rootViewController;
        tabBarController.selectedIndex = 0;

}

-(IBAction)signIn:(id)sender{
  NSLog(@"%@--%@", userName, password);
  [[NXOAuth2AccountStore sharedStore]
   requestAccessToAccountWithType:@"blinkerWebService"
   username:userName
   password:password];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(textField.tag == 0){
      userName = textField.text;
      
    
    }else if (textField.tag == 1){      
      password = textField.text;
    
    }
  return YES;

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  self.signInButton.enabled = YES;
    return YES;
}

#pragma mark - fb login 
-(void)fbconnect
{
   
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSString *str_accessToken = [[FBSession activeSession] accessToken];
        [self  reloadTabBarAfterLogin];
              
    } else {
        [self openSession];
        
    }
    
}


#pragma mark -- Facebook integeration
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            NSArray *permissions =
            [NSArray arrayWithObjects:@"publish_actions", nil];
            
            [[FBSession activeSession] reauthorizeWithPublishPermissions:permissions
                                                         defaultAudience:FBSessionDefaultAudienceEveryone
                                                       completionHandler:^(FBSession *session, NSError *error)
             {
             }];
           NSString *str_accessToken = [[FBSession activeSession] accessToken];
            [self  reloadTabBarAfterLogin];

        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    NSArray *permissions = [NSArray arrayWithObjects:@"email",@"user_birthday",@"user_location",@"friends_birthday",@"user_events",@"friends_events",@"friends_checkins",@"user_about_me", nil];
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session,
                                                                                                     FBSessionState state, NSError *error) {
        [self sessionStateChanged:session state:state error:error];
    }];
}

@end
