//
//  PostAddViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 23/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "PostAddViewController.h"
#import "FacebookUserController.h"

@interface PostAddViewController ()

@end

@implementation PostAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self onProgressStarted:CGRectMake(250, 10, 50, 50)];
	self.view.backgroundColor = [UIColor colorWithRed:(22.0/255.0) green:(77.0/255.0) blue:(192.0/255.0) alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.row == 0){
        cell.textLabel.text = @"  Facebook";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"  Twitter";
    }else{
        cell.textLabel.text = @"  Craigslist";
    }
    cell.textLabel.font = [UIFont fontWithName:@"Helvatica" size:12.0];
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(260, 25, 16, 16)];
    arrowImageView.image = [UIImage imageNamed:@"arrow_right_grey.png"];
    [cell.contentView addSubview:arrowImageView];
    cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)fbshare
{
    /*
     FacebookUserController *facebookUser = [[FacebookUserController alloc]init];
     [facebookUser openSession:^{
     NSLog(@"post photo in facebook");      
     
     
     
     
     } onFailure:nil];*/
    [[[FBSession activeSession]accessTokenData ] accessToken];
    UIImage *imagename=[UIImage imageNamed:@"car.jpg"];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"This is what I say about kittens!", @"message",
                                   @"Kittens!", @"name",
                                   @"I'm feeling fuzzy", @"caption",
                                   @"You, too, can feel fuzzy, with FuzzyKitten™", @"description",
                                //   @"http://example.com/fuzzykitten.html", @"link",
                                   @"car.jpg", @"picture",
                                   nil];
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeFacebook];
    [composeController setInitialText:@"2007 Ford Edge"];
   // composeController set
    [composeController addImage:imagename];
    //composeController.description = @"Price - $10,695 /n Year/make  - 204 Ford Edge SEL /n Miles - 53,744/n Cylinders - 6";
    [self presentViewController:composeController
                       animated:YES completion:nil];
//    NSLog(@"%@",[FBSession activeSession]);
//    if([[FBSession activeSession] isOpen])
//    {
//        [FBRequestConnection startWithGraphPath:@"me/feed"
//                                     parameters:params
//                                     HTTPMethod:@"POST"
//                              completionHandler:^(FBRequestConnection *connection,
//                                                  id result,
//                                                  NSError *error) {
//                                  NSString *alertText;
//                                  if (error) {
//                                      alertText = [NSString stringWithFormat:
//                                                   @"error: domain = %@, code = %d",
//                                                   error.domain, error.code];
//                                  } else
//                                  {
//                                      alertText = [NSString stringWithFormat:
//                                                   @"Posted action, id: %@",
//                                                   [result objectForKey:@"id"]];
//                                  }
//                                  NSLog(@"%@",alertText);
//                              }];
//    }
//    else
//    {
//        NSArray *permissions =
//        [NSArray arrayWithObjects:@"publish_actions", nil];
//        
//        [FBSession  openActiveSessionWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:^(FBSession *session,
//                                                                                                                                                              FBSessionState state, NSError *error) {
//            [self sessionStateChanged:session state:state error:error];
//        }];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row == 0){
      [self fbshare];
//
//      [facebook dialog: @"feed"
//             andParams: params
//           andDelegate: self];
//      FBRequest *fbr =[FBRequest alloc]ini
//      [FBRequest requestForPostOpenGraphObjectWithType:@"me/feed" title:@"This is what I say about kittens!" image:@"http://placekitten.com/200/150" url:@"http://example.com/fuzzykitten.html" description:@"You, too, can feel fuzzy, with FuzzyKitten™" objectProperties:nil];
//      [FBRequest startWithGraphPath:@"me/feed"
//                         parameters:params
//                         HTTPMethod:@"POST"
//                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                      
//                      [self showAlert:message result:result error:error];
//                  }];
  }
}
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            [self fbshare];
            
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


@end
