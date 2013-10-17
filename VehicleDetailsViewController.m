//
//  VehicleDetailsViewController.m
//  BlinkerMobileAppIOS
//
//  Created by Nabarun Banerjee on 01/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "VehicleDetailsViewController.h"

@interface VehicleDetailsViewController ()

@end

@implementation VehicleDetailsViewController
@synthesize carDetails, carBasicDetails;

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
    [self CarInfo];
    self.title = @"Vehicle details";
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc]init];
    myBackButton.title = @"Back";    
    self.navigationItem.backBarButtonItem = myBackButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(IBAction)backToPreviousView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)CarInfo
{  
   NSDictionary *detaildictionary = (NSDictionary *)[self.carBasicDetails objectForKey:@"raw_data_full"];
   self.makerNameLabel.text = [NSString stringWithFormat:@"%@ %@",
                              [detaildictionary  objectForKey:@"makeName"],
                              [detaildictionary objectForKey:@"modelName"]];
  
  self.engineSizeLabel.text = [NSString stringWithFormat:@"%@",
                               [detaildictionary objectForKey:@"engineSize"]];
  
  self.transmissionTypeLabel.text = [NSString stringWithFormat:@"%@",
                                     [detaildictionary objectForKey:@"transmissionType"]];
  
  self.yearLabel.text = [NSString stringWithFormat:@"%@",
                         [detaildictionary objectForKey:@"year"]];
  
  if([detaildictionary objectForKey:@"engineCylinder"])
    self.cylindersLabel.text = [NSString stringWithFormat:@"%@",
                                [detaildictionary objectForKey:@"engineCylinder"]];
  
  if([detaildictionary objectForKey:@"engineFuelType"])
    self.fuelTypeLabel.text = [NSString stringWithFormat:@"%@",
                               [detaildictionary objectForKey:@"engineFuelType"]];
  
  if([detaildictionary objectForKey:@"publicationState"])
    self.conditionLabel.text = [NSString stringWithFormat:@"%@",
                                [detaildictionary objectForKey:@"publicationState"]];
  
  
  detaildictionary = [detaildictionary objectForKey:@"price"];
  
  if([detaildictionary objectForKey:@"usedTradeIn"])
    self.tradeInValueLabel.text = [NSString stringWithFormat:@"$ %@",
                                   [detaildictionary objectForKey:@"usedTradeIn"]];
  
  if([detaildictionary objectForKey:@"baseMSRP"])
    self.askingLabel.text = [NSString stringWithFormat:@"$ %@",
                             [detaildictionary objectForKey:@"usedTmvRetail"]];
  
  if([detaildictionary objectForKey:@"usedPrivateParty"])
    self.privatePartyLabel.text = [NSString stringWithFormat:@"$ %@",
                                   [detaildictionary objectForKey:@"usedPrivateParty"]]; 
  
  
  
}


@end
