//
//  SellMyCarViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 21/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import "SellMyCarViewController.h"
#import "PhotoWizardTableViewCell.h"
#import "PhotoWizardHomeViewController.h"
#import "HowToUseViewController.h"
#import "PriceSliderViewController.h"
#import "MyListingViewController.h"
#import "MyProgressViewController.h"
#import "DetailViewController.h"
UIPageViewController *howToUsePageViewController;


@interface SellMyCarViewController ()

@end

@implementation SellMyCarViewController

@synthesize viewControllers;
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
    [self addPageViewController:nil viewRect:CGRectMake(0, 0, 320, 480)];
    
    [self onProgressStarted:CGRectMake(250, 10, 50, 50)];
    self.title = @"Sell My Car";
    self.navigationController.navigationBar.hidden = YES;    
    self.view.backgroundColor = [UIColor colorWithRed:(22.0/255.0) green:(77.0/255.0) blue:(192.0/255.0) alpha:1.0];
}

-(void)addHowToUseView{
     HowToUseViewController *howToUseViewControllerObj = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"howToUse"];
    [howToUseViewControllerObj.view setFrame:CGRectMake(10, 10, 300, 460)];
    [self.view addSubview:howToUseViewControllerObj.view];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        cell.titleLabel.text = @"Describe your car";
        cell.imageView.image = [UIImage imageNamed:@"green_tick.png"];
    }else if (indexPath.row == 1){
        cell.titleLabel.text = @"Take some photos";
        cell.imageView.image = [UIImage imageNamed:@"time_icon.png"];
    }else if (indexPath.row == 2){
        cell.titleLabel.text = @"Set your price";
        cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    }else if (indexPath.row == 3){
        cell.titleLabel.text = @"Post sale ad";
        cell.imageView.image = [UIImage imageNamed:@"grey_circle.png"];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        DetailViewController *detailviewObj =
        [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
         instantiateViewControllerWithIdentifier:@"DetailViewController"];
        [self.navigationController pushViewController:detailviewObj animated:YES];
    
    }else if(indexPath.row == 1){
        PhotoWizardHomeViewController *photoWizardHomeViewControllerObj =
                                [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                 instantiateViewControllerWithIdentifier:@"PhotoWizardHome"];
        [self.navigationController pushViewController:photoWizardHomeViewControllerObj animated:YES];
    }else if (indexPath.row == 2){
        PriceSliderViewController *priceSliderviewControllerObj =
                                [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                 instantiateViewControllerWithIdentifier:@"priceSliderViewContoller"];
        [self.navigationController pushViewController:priceSliderviewControllerObj animated:YES];        
    }else if (indexPath.row == 3){
        MyListingViewController *myListingViewControllerObj =
                                [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                 instantiateViewControllerWithIdentifier:@"myListing"];
        [self.navigationController pushViewController:myListingViewControllerObj animated:YES];
    }
}

-(void)addPageViewController:(UIImage *)image viewRect:(CGRect)rect
{
  [self setUpHowToUseViews];
  howToUsePageViewController = [[UIPageViewController alloc]
                                         initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                         options:nil];
  
  howToUsePageViewController.dataSource = self;  
  HowToUseViewController *howToUseViewController = [viewControllers objectAtIndex:0];
  howToUseViewController.index = 0;
  
  [howToUsePageViewController setViewControllers:@[howToUseViewController]
                                                direction:UIPageViewControllerNavigationDirectionForward
                                                 animated:NO
                                               completion:NULL]; 
  
  [self presentViewController:howToUsePageViewController animated:YES completion:nil]; 
  
}

#pragma mark - pageViewController dataSource

- (HowToUseViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(HowToUseViewController *)vc
{
  
  NSInteger ind = [viewControllers indexOfObject:vc];  
  HowToUseViewController *prevView = nil;
  if(ind > 0)
  {   
    prevView = [viewControllers objectAtIndex:ind - 1];    
    
  }else{
    if(ind == 0)return nil;    
    prevView = [viewControllers objectAtIndex:ind];   
  }
  return prevView;
  
}

- (HowToUseViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(HowToUseViewController *)vc
{  
  NSInteger ind = [viewControllers indexOfObject:vc];
  NSLog(@"A index-->%d", ind);
  HowToUseViewController *nextView = nil;
  if(ind + 1  < viewControllers.count)
  {   
    nextView = [viewControllers objectAtIndex:ind + 1];
    NSLog(@"< index-->%d", ind + 1);
    
  }else{
    return nil;   
    nextView = [viewControllers objectAtIndex:ind];
    NSLog(@"!< index-->%d", ind);
    
  }
  
  return nextView;
}

-(void)setUpHowToUseViews{
  viewControllers = [[NSMutableArray alloc]init];
  HowToUseViewController *howToUseViewControlleObj = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                                      instantiateViewControllerWithIdentifier:@"howToUse"];
  [viewControllers addObject:howToUseViewControlleObj];
  
  
  HowToUseViewController *howToUseViewControlleObj1 = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                                      instantiateViewControllerWithIdentifier:@"howToUse"];
  howToUseViewControlleObj1.index = 1;
  [viewControllers addObject:howToUseViewControlleObj1];
  
  
  HowToUseViewController *howToUseViewControlleObj2 = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]
                                                      instantiateViewControllerWithIdentifier:@"howToUse"];
  howToUseViewControlleObj2.index = 2;
  [viewControllers addObject:howToUseViewControlleObj2];  
  
}

@end
