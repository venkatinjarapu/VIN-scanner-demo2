//
//  AppDelegate.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 06/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "FacebookUserController.h"
#import "NXOAuth2.h"
#import "TestFlight.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [TestFlight takeOff:@"d6fc0ad0-e374-4666-9432-82412c5ab292"];
  
    // Override point for customization after application launch.
   /*  [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:(170.0/255.0) green:(170.0/255) blue:(170.0/255) alpha:1]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:(0.0/255.0) green:(0.0/255) blue:(0.0/255) alpha:1]];*/
    self.carImagesArray = [[NSMutableArray alloc]init];
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:
          [UIImage imageNamed:@"tabbar_selected.png"]];
  
    [[NXOAuth2AccountStore sharedStore] setClientID:kCLIENTID
                                           secret:kSECRET
                                 authorizationURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", BASE_HOST]]
                                         tokenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/oauth/token", BASE_HOST]]
                                      redirectURL:nil
                                   forAccountType:@"blinkerWebService"];
  
  [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreAccountsDidChangeNotification
                                                    object:[NXOAuth2AccountStore sharedStore]
                                                     queue:nil
                                                usingBlock:^(NSNotification *aNotification){
                                                  NXOAuth2Account *account = [aNotification.userInfo objectForKey:NXOAuth2AccountStoreNewAccountUserInfoKey];
                                                   self.clientCredentialsAccountIdentifier = [account identifier];
                                                }];
  [[NXOAuth2AccountStore sharedStore] requestClientCredentialsAccessWithType:@"blinkerWebService"];
  
  return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  //FacebookUserController *facebookUser = [[FacebookUserController alloc]init];
  //[facebookUser logoutFromFacebook];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self checkPermissionSettings];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}
- (void)checkPermissionSettings
{
    NSLog(@"checkPermissionSettings: in NHOCAppDelegate");
    //
    // Now 'startForMeWithCompletionHandler' may return 'FBSessionStateClosed' (meaning that the user probably unauthorized the app in Settings).
    //
    // If that is the case:
    //
    //  - Hide the 'logged' View Controller
    //  - Remove it (NHOCLoggedVC) from the Notification Center
    //  - Show the 'login' View Controller
    //  - And finally add it (NHOCLoginVC) to the Notification Center, closing the loop
    //
    // Check the console for further info.
    //
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id<FBGraphUser> user, NSError *error) {
        
        if (!error) {
            //
            // Everything went fine... The app is in good shape.
            // Notice that 'user.location' requires user_location permission
            //
            NSLog(@"user.location: %@: ", [user.location objectForKey:@"name"]);
        }
    }];
}


@end
