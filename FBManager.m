//
//  FBManager.m
//  Candies With Friends
//
//  Created by Ajay Chaudhary on 18/03/13.
//  Copyright (c) 2013 Click-Labs Pvt. Ltd. All rights reserved.
//

#import "FBManager.h"


@implementation FBManager

@synthesize Delegate=_Delegate;
@synthesize friendCache;

+(FBManager *) facebookConnect
{
    static FBManager * instance;
    
    if(instance == nil)
    {
        instance = [[FBManager alloc] init];
    }
    
    return instance;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
    
        {
            [_Delegate FB_Logged_In_Successfully];
             break;
        }
           
        case FBSessionStateClosed:
        {
         
            break;
        }
        case FBSessionStateClosedLoginFailed:
        {
            [FBSession.activeSession closeAndClearTokenInformation];
            
            //[self showLoginView];
            break;
        }
            
           
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

- (NSDictionary*)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}
-(void)showLoginView
{
    [FBSession openActiveSessionWithAllowLoginUI:[self openSessionWithAllowLoginUI:YES]];
}
-(void)Post_To_Friend_Wall_WithMsg:(NSString*)InviteMsg  Friend_FBID:(NSString *)FBID  WithLink:(NSString*)Link
{
    
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Candies With Friends", @"name",
     @"A amazing app", @"caption",
     @"Are you ready to play with candies? Then download app from this link and play with me", @"description",
     @"www.click-labs.com", @"link",
     //@"https://raw.github.com/fbsamples/ios-3.x-howtos/master/Images/iossdk_logo.png", @"picture",
     nil];
    
    // Invoke the dialog
  /* [ FBWebDialogs presentRequestsDialogModallyWithSession:nil message:@"AJAY" title:@"YES" parameters:params handler: ^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
    {
        if (error)
        {
            // Error launching the dialog or publishing a story.
            NSLog(@"Error publishing story.");
        }
        else
        {
            if (result == FBWebDialogResultDialogNotCompleted)
            {
                // User clicked the "x" icon
                NSLog(@"User canceled story publishing.");
            }
            else
            {
                // Handle the publish feed callback
                NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                if (![urlParams valueForKey:@"post_id"])
                {
                    // User clicked the Cancel button
                    NSLog(@"User canceled story publishing.");
                }
                else
                {
                    // User clicked the Share button
                    NSString *msg = [NSString stringWithFormat:
                                     @"Posted story, id: %@",
                                     [urlParams valueForKey:@"post_id"]];
                    NSLog(@"%@", msg);
                    // Show the result in an alert
                    [[[UIAlertView alloc] initWithTitle:@"Result"
                                                message:msg
                                               delegate:nil
                                      cancelButtonTitle:@"OK!"
                                      otherButtonTitles:nil]
                     show];
                }
            }
        }
    }];*/
    
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
    {
         if (error)
         {
             // Error launching the dialog or publishing a story.
             NSLog(@"Error publishing story.");
         }
         else
         {
             if (result == FBWebDialogResultDialogNotCompleted)
             {
                 // User clicked the "x" icon
                 NSLog(@"User canceled story publishing.");
             }
             else
             {
                 // Handle the publish feed callback
                 NSLog(@"%@",[resultURL query]);
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 NSLog(@"%@",urlParams);
                 if (![urlParams valueForKey:@"post_id"])
                 {
                     // User clicked the Cancel button
                     NSLog(@"User canceled story publishing.");
                 }
                 else
                 {
                     // User clicked the Share button
                     NSString *msg = [NSString stringWithFormat:
                                      @"Posted story, id: %@",
                                      [urlParams valueForKey:@"post_id"]];
                     NSLog(@"%@", msg);
                     // Show the result in an alert
                     [[[UIAlertView alloc] initWithTitle:@"Result"
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"OK!"
                                       otherButtonTitles:nil]
                      show];
                 }
             }
         }
     }];
    
    /*
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_stream", nil];
    
    [FBSession openActiveSessionWithPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session,FBSessionState status,NSError *error)
     {
         if (session.isOpen)
         {
             
             
             NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            InviteMsg          ,@"message",
                                            Link               , @"link",
                                            @"", @"picture",
                                            @"Candies With Friends",@"name",
                                            nil];
             
             
             [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"%@/feed",FBID] parameters:params HTTPMethod:@"POST"
                                   completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
                                    {
                                       NSString *alertText;
                                       if (error)
                                       {
                                           alertText = [NSString stringWithFormat: @"error: domain = %@, code = %d error.description = %@", error.domain, error.code,error.description];
                                       }
                                       else
                                       {
                                           alertText = [NSString stringWithFormat: @"Posted action, id: %@", [result objectForKey:@"id"]];
                                       }
                                       NSLog(@"%@",alertText);
                                   }];
             
             [_Delegate FB_Post_To_Friend_Wall_Request_Sent];
         }
     }];
    */
   // [FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorFBRequests, FBLoggingBehaviorFBURLConnections, nil]];
    
}


-(void)Call_FB
{
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        [self openSession];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
}

- (void)openSession
{
//    [FBSettings enableBetaFeature:FBBetaFeaturesOpenGraphShareDialog];
//    [FBSettings enableBetaFeature:FBBetaFeaturesShareDialog];
//    [FBSession openActiveSessionWithPublishPermissions:nil defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session,
//                                                                                                                                                FBSessionState state, NSError *error) {
//        [self sessionStateChanged:session state:state error:error];
//    }];
    
    
    /*
    [FBSession openActiveSessionWithPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session,
                                                                                        FBSessionState state, NSError *error) {
        [self sessionStateChanged:session state:state error:error];
    }];*/
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_stream", nil];
   /* NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"publish_actions",
                            nil];*/
    return [FBSession openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
    {
        if (session.isOpen)
        {
            FBRequest *me = [FBRequest requestForMe];
            [me startWithCompletionHandler: ^(FBRequestConnection *connection,
                                              
                                              NSDictionary<FBGraphUser> *my,
                                              
                                              NSError *error)
             {
                 NSLog(@"%@",my);
                 
                 [[NSUserDefaults standardUserDefaults]setValue:my.id forKey:@"fbid"];
                 [[NSUserDefaults standardUserDefaults]setValue:session.accessTokenData.accessToken forKey:@"fb_access_token"];
                 [[NSUserDefaults standardUserDefaults]setValue:my.first_name forKey:@"fb_first_name"];
                 [[NSUserDefaults standardUserDefaults]setValue:my.last_name forKey:@"fb_last_name"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 
                 [self sessionStateChanged:session state:state error:error];
             }];
        }
        else
        {
            NSLog(@"%@",error.description);
        }
    }];
    
    
    /*
    return [FBSession openActiveSessionWithPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session,FBSessionState status,NSError *error)
            {
                if (session.isOpen)
                {
                    FBRequest *me = [FBRequest requestForMe];
                    [me startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                      
                                                      NSDictionary<FBGraphUser> *my,
                                                      
                                                      NSError *error)
                    {
                        NSLog(@"%@",my);
                    
                        [[NSUserDefaults standardUserDefaults]setValue:my.id forKey:@"fbid"];
                        [[NSUserDefaults standardUserDefaults]setValue:session.accessToken forKey:@"fb_access_token"];
                        [[NSUserDefaults standardUserDefaults]setValue:my.first_name forKey:@"fb_first_name"];
                        [[NSUserDefaults standardUserDefaults]setValue:my.last_name forKey:@"fb_last_name"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                                               
                        [self sessionStateChanged:session state:status error:error];
                    }];
                }
                
                
            }];*/
}




- (void) fb_logout {
    
     NSLog(@"Hello i have loggedout");
    
    [FBSession.activeSession closeAndClearTokenInformation];
    
}

@end
