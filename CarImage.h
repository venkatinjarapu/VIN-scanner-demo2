//
//  CarImage.h
//  BlinkerMobileIOS
//
//  Created by Nabarun Banerjee on 09/09/13.
//  Copyright (c) 2013 Blinker Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarImage : NSObject
{
  NSString *imageId;
  NSString *imageableId;
  NSString *imageabletype;
  NSString *imageTypeId;
  NSString *imageFileName;
  NSString *imageContentType;
  NSString *imageFileSize;
  NSString *imageUpdatedAt;
  NSString *imageDescription;  
  NSData  *imageData;
}
@property(nonatomic, strong) NSString *imageId;
@property(nonatomic, strong) NSString *imageableId;
@property(nonatomic, strong) NSString *imageabletype;
@property(nonatomic, strong) NSString *imageTypeId;
@property(nonatomic, strong) NSString *imageFileName;
@property(nonatomic, strong) NSString *imageContentType;
@property(nonatomic, strong) NSString *imageFileSize;
@property(nonatomic, strong) NSString *imageUpdatedAt;
@property(nonatomic, strong) NSString *imageDescription;
@property(nonatomic, strong) NSData  *imageData;


@end
