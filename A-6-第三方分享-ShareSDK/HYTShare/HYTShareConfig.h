//
//  HYTShareConfig.h
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/9.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTShareInfo : NSObject

@property (nonatomic, copy) NSString *shareContent;

@property (nonatomic, copy) NSString *sharedefaultContent;

@property (nonatomic, copy) NSString *shareImagePath;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, copy) NSString *shareURL;

@property (nonatomic, copy) NSString *shareDescription;

@end


@interface HYTShareConfig : NSObject

+ (void)initializePlatfrom;


@end
