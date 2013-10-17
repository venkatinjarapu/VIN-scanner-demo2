//
//  PhotoWizardHomeViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 21/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "PhotoWizardHomeViewController.h"
#import "PhotoWizardTableViewCell.h"
#import "SellMyCarViewController.h"
#import "BarcodeReaderViewController.h"
#import "ExteriorPhotosViewController.h"

@interface PhotoWizardHomeViewController ()

@end

@implementation PhotoWizardHomeViewController

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
    self.title = @"Photo Wizard";
    self.view.backgroundColor = [UIColor colorWithRed:(22.0/255.0) green:(77.0/255.0) blue:(192.0/255.0) alpha:1.0];
    self.navigationController.navigationBar.hidden = YES;    
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PhotoWizardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){        
            cell = [[PhotoWizardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.row == 0){
        cell.titleLabel.text = @"Exterior";
        cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    }else if (indexPath.row == 1){
        cell.titleLabel.text = @"Interior";
        cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"Scan License plate";
        cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    }else if (indexPath.row == 3){
        cell.titleLabel.text = @"Scan VIN";
        cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3){
        [self loadPhotoWizard];
    }else if (indexPath.row == 0){
        ExteriorPhotosViewController *exteriorPhotoViewControllerObj =
                                        [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                         instantiateViewControllerWithIdentifier:@"exteriorPhotoView"];
        [self.navigationController pushViewController:exteriorPhotoViewControllerObj animated:YES];        
    }else{
        [self showAddPhotoOptions];
    }
}

-(void)loadPhotoWizard{     
    
    BarcodeReaderViewController *barcodereaderViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"barcode"];
    
    [self.navigationController pushViewController:barcodereaderViewController animated:YES];
       
}

- (void)showAddPhotoOptions {
    UIActionSheet *actionSheet;
    id delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Image"
                                                  delegate:delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                         otherButtonTitles:@"Select Photo from Library",@"Take Photo",nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Image"
                                                  delegate:delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                         otherButtonTitles:@"Select Photo from Library",nil];
    }
	[actionSheet showInView:self.view];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark  Actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 1 || (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && buttonIndex > 0)) {
        return; //cancel button clicked
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.editing = YES;    
    
    if(buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if (buttonIndex==1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
        [self presentViewController:imagePicker animated:YES completion:nil];
}

@end
