//
//  MyProgressViewController.m
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 29/08/13.
//  Copyright (c) 2013 Kreeti Technologies. All rights reserved.
//

#import "MyProgressViewController.h"

@interface MyProgressViewController ()

@end

@implementation MyProgressViewController
@synthesize myProgressModalView;

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
    [self onProgressStarted:CGRectMake(135, 150, 50, 50)];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
