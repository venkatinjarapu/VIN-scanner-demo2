//
//  SellMyCarViewController.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 21/08/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SellMyCarViewController : BaseViewController<UIPageViewControllerDataSource, UINavigationControllerDelegate>
{
  NSMutableArray *viewControllers;
}
@property(nonatomic, retain)NSMutableArray *viewControllers;
@end
