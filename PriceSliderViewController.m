//
//  PriceSliderViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 23/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "PriceSliderViewController.h"
#import "PriceSliderTableViewCell.h"
#import "SetPriceTableViewCell.h"

@interface PriceSliderViewController ()

@end

@implementation PriceSliderViewController


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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height;
    if(indexPath.row == 0){
        height = 49;
    }else{
        height = 190;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if(indexPath.row == 0)CellIdentifier = @"setPriceCell";
    else CellIdentifier = @"priceSliderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        if(indexPath.row == 0){
            cell = [[SetPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }else{
            cell = [[PriceSliderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }        
    }
    PriceSliderTableViewCell *priceSliderCell = (PriceSliderTableViewCell *)cell;
    SetPriceTableViewCell *setPriceCell = (SetPriceTableViewCell *)cell;    
    
        if(indexPath.row == 0){
            setPriceCell.tradeInValueLabel.text = @"$ 12,860";
            setPriceCell.privatePartyValuelabel.text = @"$ 14,280";
            cell = setPriceCell;
        }else if (indexPath.row == 1){
            priceSliderCell.setPriceLabel.text = @"13,460";
            cell = priceSliderCell;
           priceSliderCell.lbl_blackcircle.text = @"$244";
        }   
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)backButtonTap:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
