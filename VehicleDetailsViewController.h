//
//  VehicleDetailsViewController.h
//  BlinkerMobileAppIOS
//
//  Created by Nabarun Banerjee on 01/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VehicleDetailsViewController : BaseViewController
{
    NSDictionary *carDetails;
    NSDictionary *carBasicDetails;
}

@property (nonatomic, retain) NSDictionary *carDetails;
@property (nonatomic, retain) NSDictionary *carBasicDetails;
@property (nonatomic, weak) IBOutlet UILabel *makerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *modelNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *transmissionTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *fuelTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *vehicleStyleLabel;
@property (nonatomic, weak) IBOutlet UILabel *milesLabel;
@property (nonatomic, weak) IBOutlet UILabel *cylindersLabel;
@property (nonatomic, weak) IBOutlet UILabel *engineSizeLabel;
@property (nonatomic, weak) IBOutlet UILabel *drivenWheelsLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UILabel *mpgLabel;
@property (nonatomic, weak) IBOutlet UILabel *tradeInValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *askingLabel;
@property (nonatomic, weak) IBOutlet UILabel *privatePartyLabel;
@property (nonatomic, weak) IBOutlet UILabel *conditionLabel;

- (IBAction)backToPreviousView:(id)sender;
- (void)CarInfo;

@end
