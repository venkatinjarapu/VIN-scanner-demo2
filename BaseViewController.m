//
//  BaseViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 29/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "BaseViewController.h"
#import "MyProgressViewController.h"
#import "CarImage.h"
#import "NXOAuth2.h"
#import "AppDelegate.h"
#import "CarImage.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize customProgressView;

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
    [self.tabBarController setModalPresentationStyle:UIModalPresentationCurrentContext];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onProgressStarted:(CGRect)rect
{ 
  CustomProgressView *backgroundCircle = [[CustomProgressView alloc]initWithFrame:rect];
  backgroundCircle.ProgressLbl.hidden = YES;
  backgroundCircle.delegate = self;
  backgroundCircle.backgroundColor = [UIColor clearColor];
  [self.view addSubview:backgroundCircle];
  [backgroundCircle performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:1.0] withObject:[UIColor colorWithRed:23/255 green:16/255 blue:59/255 alpha:1.0]];
  
  customProgressView = [[CustomProgressView alloc] initWithFrame:rect];
  customProgressView.backgroundColor = [UIColor clearColor];
  
  customProgressView.delegate = self;
  [self.view addSubview:customProgressView];
  UIColor *color = [UIColor blueColor];
  
  [customProgressView performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:0.2] withObject:color];
  [customProgressView performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:0.4] withObject:color];
  [customProgressView performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:0.6] withObject:color];
  [customProgressView performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:0.67] withObject:color];
  UIButton *pogressModalButton = [[UIButton alloc]initWithFrame:rect];
  [pogressModalButton addTarget:self action:@selector(myProgressButtonTap) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:pogressModalButton];
}

-(void)drawBackgroundCircle{
  CustomProgressView *backgroundCircle = [[CustomProgressView alloc]initWithFrame:CGRectMake(250, 10, 50, 50)];
  backgroundCircle.ProgressLbl.hidden = YES;
  backgroundCircle.delegate = self;
  backgroundCircle.backgroundColor = [UIColor clearColor];
  [self.view addSubview:backgroundCircle];
  [backgroundCircle performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:1.0] withObject:[UIColor colorWithRed:23/255 green:16/255 blue:59/255 alpha:1.0]];
}

-(void)setProgress:(NSNumber*)value withColor:(UIColor *)color
{  
  [self performSelector:@selector(setProgress:withColor:) withObject:[NSNumber numberWithFloat:1.0] withObject:color];
}

-(IBAction)backButtonTap:(id)sender{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)myProgressButtonTap{
  MyProgressViewController *myProgressViewControllerObj = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProgressView"];
  [self presentViewController:myProgressViewControllerObj animated:YES completion:nil];
}

-(IBAction)dismissModalViewController:(id)sender{
  [self dismissViewControllerAnimated:NO completion:Nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
                          didFinishPickingImage:(UIImage *)image
                          editingInfo:(NSDictionary *)editingInfo{
  [self dismissViewControllerAnimated:YES completion:nil];  
  
  CarImage *carImageObj = [[CarImage alloc]init];
  carImageObj.imageData = UIImagePNGRepresentation(image);
  carImageObj.imageableId = [NSString stringWithFormat:@"%@", carImageObj.imageData];
  carImageObj.imageDescription = @"niceImage";
  AppDelegate *apd = [[UIApplication sharedApplication]delegate];
  [apd.carImagesArray addObject:carImageObj];
 
  
  
 /* [self postRequest:[NSDictionary dictionaryWithObjectsAndKeys:  carImageObj.imageData, @"image",
                                                                 carImageObj.imageableId, @"image_type_id",
                                                                 carImageObj.imageDescription, @"description", nil]
                                                                 url:
                                                                 [NSURL URLWithString:
                                                                  [NSString stringWithFormat:@"%@/api/v1/images/%@",BASE_HOST,
                                                                   @"JTEBU17R848028574"]]];*/
  
}

-(void)postRequest:(NSDictionary *)params url:(NSURL *)apiURL{
 
  AppDelegate *apd = [[UIApplication sharedApplication] delegate];
  
  NXOAuth2Account *account = [[NXOAuth2AccountStore sharedStore] accountWithIdentifier:apd.clientCredentialsAccountIdentifier];
  [NXOAuth2Request performMethod:@"POST"
                      onResource:apiURL
                 usingParameters:params
                     withAccount:account
             sendProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                   
                   if(!error){                     
                     NSLog(@"response %@", responseData);
                   }
                 }];
}

-(void)resizeImage:(UIImage *)image{
  float hfactor = image.size.width / 960;
  float vfactor = image.size.height / 960;
  float factor = fmax(hfactor, vfactor);
  factor = fmax(factor, 1);
  
  float newWidth = image.size.width / factor;
  float newHeight = image.size.height / factor;
  
  CGRect imageRect = CGRectMake(0, 0, newWidth, newHeight);
  UIGraphicsBeginImageContext(imageRect.size);
  [image drawInRect:imageRect];
  UIGraphicsEndImageContext();
  NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
}

@end
