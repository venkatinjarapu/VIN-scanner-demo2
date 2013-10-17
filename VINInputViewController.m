//
//  VINInputViewController.m
//  BlinkerMobileAppIOS
//
//  Created by Nabarun Banerjee on 01/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "VINInputViewController.h"
#import "AppDelegate.h"
#import "NXOAuth2.h"
#import "CarImage.h"
#import "AppDelegate.h"

@interface VINInputViewController ()

@end

@implementation VINInputViewController
@synthesize vin,inputVINNumberTextField,inputMileageTextField;

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
    self.inputVINNumberTextField.delegate = self;
    self.inputMileageTextField.delegate=self;
    self.inputConditionTextField.delegate=self;
    if(self.vin) self.inputVINNumberTextField.text = self.vin;
    self.title = @"Enter your VIN";
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc]init];
    myBackButton.title = @"Back";
    self.navigationItem.backBarButtonItem = myBackButton;
    self.view.backgroundColor = [UIColor colorWithRed:(22.0/255.0) green:(77.0/255.0) blue:(192.0/255.0) alpha:1.0];
    [self uploadCarImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
}

-(IBAction)backToPreviousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getDetails:(id)sender
{
//    if (([inputVINNumberTextField.text length] == 0)|| ([inputVINNumberTextField.text length] < 17)){
//        
//        
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid VIN " message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
//        
//    }
//    
//    else if([inputVINNumberTextField.text length] > 17){
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid VIN " message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
//        
//    }
//    
//    else{
    
        self.loadingIndicator.hidden = NO;
        
        [self.loadingIndicator startAnimating];
        
        [self getDetailsFromVIN:self.inputVINNumberTextField.text];
        
    
 //  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.inputVINNumberTextField resignFirstResponder];
    [self.inputMileageTextField resignFirstResponder];
    [self.inputConditionTextField resignFirstResponder];
    return YES;
}


- (void)showAlertWithTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil] show];
}

-(void)getDetailsFromVIN:(NSString *)vinOfCar{
  
  NSURL *apiURL = [NSURL URLWithString:[NSString stringWithFormat:
                                                     @"%@/api/v1/vehicles/%@", BASE_HOST, vinOfCar]];
    NSLog(@"url---%@",[NSString stringWithFormat:
                       @"%@/api/v1/vehicles/%@", BASE_HOST, vinOfCar]);
  AppDelegate *apd = [[UIApplication sharedApplication] delegate];
  
  NXOAuth2Account *account = [[NXOAuth2AccountStore sharedStore] accountWithIdentifier:apd.clientCredentialsAccountIdentifier];
  [NXOAuth2Request performMethod:@"GET"
                      onResource:apiURL
                 usingParameters:nil
                     withAccount:account
             sendProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                   
                   if(!error){
                     
                     NSError *error;
                     NSJSONSerialization *json  = [NSJSONSerialization
                                                   JSONObjectWithData:responseData
                                                   options:NSJSONReadingMutableContainers
                                                   error:&error];
                     
                     if(error){
                       [self showAlertWithTitle:@"Cannot get JSON response."];
                     }else{
                       NSDictionary *detailsDictionary = (NSDictionary *)json;
                         NSLog(@"Detail Dictionary ::::::::::::::::%@",detailsDictionary);
                       if(!detailsDictionary){
                         [self showAlertWithTitle:@"The VIN does not seems to be correct."];
                       }else{
                         
                         VehicleDetailsViewController *vehicleDetailsViewControllerObj =
                         [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]                                                                       instantiateViewControllerWithIdentifier:@"VehicleDetails"];
                         vehicleDetailsViewControllerObj.carBasicDetails = (NSDictionary *)json;
                                                  [self.navigationController pushViewController:vehicleDetailsViewControllerObj animated:YES];
                       }                
                     }
                     [self.loadingIndicator stopAnimating];
                     self.loadingIndicator.hidden = YES;
                   }
                 }];
}

-(void)uploadCarImages{
  AppDelegate *apd = [[UIApplication sharedApplication]delegate]; 
  for(CarImage *img in apd.carImagesArray)
  {
    [self postRequest:[NSDictionary dictionaryWithObjectsAndKeys:  img.imageData, @"image",
                       img.imageableId, @"image_type_id",
                       img.imageDescription, @"description", nil] url:
                       [NSURL URLWithString:[NSString stringWithFormat:
                                      @"%@/api/v1/images/%@",BASE_HOST,
                                             vin]]];
    
  }  
}
@end
