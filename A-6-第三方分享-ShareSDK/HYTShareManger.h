//
//  HYTShareManger.h
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/9.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "HYTShareConfig.h"
#import "HYTShareView.h"

@interface HYTShareManger : NSObject

/**
 * 在新浪微博和腾迅微博的授权界面自动关注指定的微博帐号， 默认为nil时，自动关注指定账号功能关闭
 */
@property (nonatomic, copy) NSString *followAccounts;

/**
 *  分享管理对象
 */
+ (instancetype)manager;

/**
 *  自定义分享项的序列（默认为已连接平台列表）
 *
 *  @param shareType 分享类型
 */
- (void)customShareTypeLists:(ShareType)shareType, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  分享
 *
 *  @param shareInfo 分享信息模型
 */
- (void)shareWithShareInfo:(HYTShareInfo *)shareInfo;


+ (BOOL)mangerHandleOpenURL:(NSURL *)url wxDelegate:(id)wxDelegate;
+ (BOOL)mangerHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation wxDelegate:(id)wxDelegate;@end


