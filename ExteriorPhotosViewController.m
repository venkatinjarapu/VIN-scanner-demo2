//
//  ExteriorPhotosViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 22/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "ExteriorPhotosViewController.h"

@interface ExteriorPhotosViewController ()

@end

@implementation ExteriorPhotosViewController

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

-(IBAction)takePhoto:(id)sender{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.editing = YES;    
    
    int buttonIndex = ((UIButton *)sender).tag;
    if(buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        //([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

@end
