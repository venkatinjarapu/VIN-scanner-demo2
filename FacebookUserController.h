//
//  FacebookUserController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 28/08/13.
//  Copyright (c) 2013 Kreeti Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookUserController : NSObject

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
                      onSuccess:(void (^)(void))successCallback
                      onFailure:(void (^)(void))failureCallback;

- (void)openSession:(void (^)(void))successCallback
          onFailure:(void (^)(void))failureCallback;
- (void)logoutFromFacebook;

@end
