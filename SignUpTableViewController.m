//
//  SignUpTableViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 20/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "UserInputTableViewCell.h"
#import "NXOAuth2.h"
#import "AppDelegate.h"

@interface SignUpTableViewController ()
{
  NSString *userName;
  NSString *password;
  NSString *repeat_Password;
}
@end

@implementation SignUpTableViewController
@synthesize signUpButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.signUpButton.enabled = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"SignUpCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if(cell == nil){
        
        cell = [[UserInputTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    UserInputTableViewCell *userInputCell = (UserInputTableViewCell *)cell;
    
    userInputCell.loginInfoInputTextField.textColor = [UIColor blackColor];
    
    
    
    if(indexPath.row == 0){
        
        // userInputCell.loginInfoInputTextField.text = @"Email Address";
        
        userInputCell.loginInfoInputTextField.placeholder = @"Email Address";
        
        userInputCell.loginInfoInputTextField.tag = 0;
        
        userInputCell.loginInfoInputTextField.delegate = self;
        
        userInputCell.loginInfoInputTextField.keyboardType=UIKeyboardTypeEmailAddress;
        
        userInputCell.loginInfoInputTextField.returnKeyType=UIReturnKeyDone;
        
    }else if (indexPath.row == 1){
        
        userInputCell.loginInfoInputTextField.placeholder = @"Create Password";
        
        userInputCell.loginInfoInputTextField.tag = 1;
        
        userInputCell.loginInfoInputTextField.delegate = self;
        
        [userInputCell.loginInfoInputTextField setSecureTextEntry:YES];
        
    }else{
        
        userInputCell.loginInfoInputTextField.placeholder = @"Repeat Password";
        
        userInputCell.loginInfoInputTextField.tag = 2;
        
        userInputCell.loginInfoInputTextField.delegate = self;
        
        [userInputCell.loginInfoInputTextField setSecureTextEntry:YES];
        
    }
    
    
    
    return userInputCell;
    
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return @"New User";
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(IBAction)signUp:(id)sender{  
  
  //USER_SIGNUP
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  userName, @"email",
                                                  password, @"password",
                                                  repeat_Password, @"password_confirmation",
                                                  [NSString nxoauth2_stringWithUUID], @"uid", nil];
  
  NSURL *apiURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/users", BASE_HOST]];
  AppDelegate *apd = [[UIApplication sharedApplication] delegate];
  
  NXOAuth2Account *account = [[NXOAuth2AccountStore sharedStore] accountWithIdentifier:apd.clientCredentialsAccountIdentifier];
 [NXOAuth2Request performMethod:@"POST"
                    onResource:apiURL
                   usingParameters:params
                       withAccount:account
               sendProgressHandler:nil
                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                     
                     if(!error){
                       NSString *errorDescription = nil;
                       NSPropertyListFormat format;
                       NSDictionary *jsonDictionary = [NSPropertyListSerialization propertyListFromData:responseData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&errorDescription];
                       
                       NSLog(@"jsonObject is %@", jsonDictionary);
                       NSLog(@"response %@", response);
                     }
                   }];    
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  self.signUpButton.enabled = YES;
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
  if(textField.tag == 0)
    userName = textField.text;
  else if (textField.tag == 1)
    password = textField.text;
  else
    repeat_Password = textField.text;
  return YES;
}


@end
