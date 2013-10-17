//
//  DetailViewController.h
//  BlinkerMobileIOS
//
//  Created by ankit gupta on 9/16/13.
//  Copyright (c) 2013 Kreeti Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>

{
    
    IBOutlet UITextView *txt_view;

    IBOutlet UIScrollView *scrollview;
    IBOutlet UITextField *txt_vin;
    IBOutlet UITextField *txt_accident;
    IBOutlet UITextField *txt_condition;
    IBOutlet UITextField *txt_description;
    IBOutlet UITextField *txt_first_owner;
    IBOutlet UITextField *txt_garage_kept;
    IBOutlet UITextField *txt_private_value;
    IBOutlet UITextField *txt_retail_value;
    IBOutlet UITextField *txt_trade_value;
    IBOutlet UITextField *txt_licence_plate;
    IBOutlet UITextField *txt_mileage;
    IBOutlet UITextField *txt_status;
      IBOutlet UITextField *txt_owner;
}
- (IBAction)TapBackButton:(id)sender;
-(IBAction)submitCarDescription:(UIButton *) sender;
@end
