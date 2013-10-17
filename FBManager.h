//
//  FBManager.h
//  Candies With Friends
//
//  Created by Ajay Chaudhary on 18/03/13.
//  Copyright (c) 2013 Click-Labs Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FacebookSDK/FacebookSDK.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@protocol FBManagerDelegate <NSObject>

-(void)FB_Post_To_Wall_Request_Sent;
-(void)FB_Post_To_Wall_Successfully;

-(void)FB_Post_To_Friend_Wall_Request_Sent;
-(void)FB_Post_To_Friend_Wall_Successfully;

-(void)FB_Login_Request_Sent;
-(void)FB_Logged_In_Successfully;



@end

@interface FBManager : NSObject
{
 
    id<FBManagerDelegate>_Delegate;
}
@property(nonatomic,retain)id<FBManagerDelegate> Delegate;
@property (readwrite, nonatomic, retain) FBFrictionlessRecipientCache *friendCache;

+(FBManager *) facebookConnect;
-(void)fb_logout;
-(void)Call_FB;
-(void)Call_Share_Dialog;
-(void)User_FB_Friends;
-(void)PostToWall_WithMessage:(NSString*)Message WithLink:(UIImage *)Link ;
-(void)Post_To_Friend_Wall_WithMsg:(NSString*)InviteMsg  Friend_FBID:(NSString *)FBID  WithLink:(NSString*)Link;
@end
