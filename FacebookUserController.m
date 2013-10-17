//
//  FacebookUserController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 28/08/13.
//  Copyright (c) 2013 Kreeti Technologies. All rights reserved.
//

#import "FacebookUserController.h"

@implementation FacebookUserController

-(id)init
{
  return self;
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
                      onSuccess:(void (^)(void))successCallback
                      onFailure:(void (^)(void))failureCallback
{
    
  switch (state)
{
    case FBSessionStateOpen:
      if(successCallback) successCallback();
      break;
    case FBSessionStateClosed:
    case FBSessionStateClosedLoginFailed:
      if(failureCallback) failureCallback();
      break;    
    default:      
      break;
  }
  
  if (error)
  {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:error.localizedDescription
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
  }
}

- (void)openSession:(void (^)(void))successCallback
                   onFailure:(void (^)(void))failureCallback
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"email", nil];
  [FBSession openActiveSessionWithReadPermissions:permissions
                                     allowLoginUI:YES
                                completionHandler:
   ^(FBSession *session,
     FBSessionState state, NSError *error) {
     [self sessionStateChanged:session state:state error:error onSuccess:successCallback onFailure:failureCallback];
   }];
}

-(void)logoutFromFacebook{
  [FBSession.activeSession closeAndClearTokenInformation];
}

@end
