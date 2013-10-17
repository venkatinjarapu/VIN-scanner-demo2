//
//  MyListingViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 23/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "MyListingViewController.h"
#import "MyListingCarImagesTableViewCell.h"
#import "CarPriceTableViewCell.h"
#import "CarDetailsTableViewCell.h"
#import "PostAddViewController.h"

@interface MyListingViewController ()

@end

@implementation MyListingViewController

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
    NSInteger height;
    if(indexPath.row == 0)
    {
        height = 210;
    }else if (indexPath.row == 1){
        height = 49;
    }else{
        height = 132;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if(indexPath.row == 0){
        CellIdentifier = @"myListingCarImageCell";
    }else if (indexPath.row == 1){
        CellIdentifier = @"carPriceCell";
    }else if (indexPath.row == 2){
        CellIdentifier = @"cardetailsTableViewcell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        if(indexPath.row == 0){
            cell = [[MyListingCarImagesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }else if(indexPath.row == 1){
            cell = [[CarPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }else if (indexPath.row == 2){
            cell = [[CarDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }    
        if(indexPath.row == 0){
             MyListingCarImagesTableViewCell *myListingCarImagesCell = (MyListingCarImagesTableViewCell *)cell;
            [myListingCarImagesCell.takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:
                                                                                    UIControlEventTouchUpInside];
          
          
        }else if (indexPath.row == 1){
            // CarPriceTableViewCell *carPriceTableViewCell = (CarPriceTableViewCell *)cell;
        }    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(IBAction)postButtonTap:(id)sender{
    PostAddViewController *postAddViewControllerObj =
    [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
     instantiateViewControllerWithIdentifier:@"postAdd"];
    [self.navigationController pushViewController:postAddViewControllerObj animated:YES];
}

-(void)takePhoto
{
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
  imagePicker.delegate = self;
  imagePicker.editing = YES;
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  else
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
  [self presentViewController:imagePicker animated:YES completion:nil];
  
}

@end
