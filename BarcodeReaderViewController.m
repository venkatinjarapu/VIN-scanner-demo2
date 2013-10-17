//
//  InformationViewController.m
//  BlinkerMobileAppIOS
//
//  Created by Nabarun Banerjee on 31/07/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "BarcodeReaderViewController.h"
#import "VINInputViewController.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>

@interface BarcodeReaderViewController (){
    UIImagePickerControllerCameraFlashMode * cameraFlashMode;

}

@end

@implementation BarcodeReaderViewController
{
    NSString *vin;
}

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
    self.title = @"Enter your VIN";
    UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc]init];
    myBackButton.title = @"Back";  
    
    self.navigationItem.backBarButtonItem = myBackButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)showAddPhotoOptions {
    UIActionSheet *actionSheet;
    id delegate = self;    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Barcode Image"
                                                  delegate:delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil                                         otherButtonTitles:@"Select Photo from Library",@"Take Photo",nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Barcode Image"
                                                  delegate:delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil                                         otherButtonTitles:@"Select Photo from Library",nil];
    }
	[actionSheet showInView:self.view];
    [self.view bringSubviewToFront:actionSheet];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark  Actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex > 1 || (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && buttonIndex > 0)) {
        return; //cancel button clicked
    }

    
	

    if(buttonIndex == 0) {
        ZBarReaderController *reader = [ZBarReaderController new];
        reader.readerDelegate = self;
        [reader.scanner setSymbology: ZBAR_I25
                              config: ZBAR_CFG_ENABLE
                                  to: 0];
        [reader.scanner setSymbology: ZBAR_QRCODE
                              config: ZBAR_CFG_ENABLE
                                  to: 0];
        
        
        reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;      
        [self presentViewController:reader animated:YES completion:nil];
        
    } else {
        
        NSError *error;
        ZBarReaderViewController *reader = [ZBarReaderViewController new];
        reader.readerDelegate = self;
        [reader.scanner setSymbology: ZBAR_I25
                              config: ZBAR_CFG_ENABLE
                                  to: 0];      
        [reader.scanner setSymbology: ZBAR_QRCODE
                              config: ZBAR_CFG_ENABLE
                                  to: 0];
       // cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
        [self presentViewController:reader animated:YES completion:nil];
        
        AVCaptureDevice *capDevice = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
        
        if (capDevice.hasTorch)
        {
            [capDevice lockForConfiguration: &error];
            
            if (capDevice.torchMode == AVCaptureTorchModeOff || [capDevice isTorchModeSupported: AVCaptureTorchModeOn])
            {
                capDevice.torchMode = AVCaptureTorchModeOn;
            }
            else
            {
                capDevice.torchMode = AVCaptureTorchModeOff;
            }
            [capDevice unlockForConfiguration];

        }
        
        
    
}
}

-(IBAction)takeBarcodeImage:(id)sender
{
    [self showAddPhotoOptions];
    
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];

    for(ZBarSymbol *symbol in results) {
        NSLog(@"BARCODE-->%@", symbol.data);
        vin = symbol.data;
        NSLog(@"vin1 length---%i",[vin length]);

        
    }    
    [reader dismissViewControllerAnimated:YES completion:nil];
    if(vin)
        [self enterVIN:nil];
}

- (IBAction)enterVIN:(id)sender
{    
    VINInputViewController *vinINputViewControllerObj = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"inputVIN"];
    if(!sender){
        vinINputViewControllerObj.vin = vin;
        NSLog(@"vin----%@",vin);
        NSLog(@"vin2 length---%i",[vinINputViewControllerObj.vin length]);
    }
    
    [self.navigationController pushViewController:vinINputViewControllerObj animated:YES];    
    
}

@end
