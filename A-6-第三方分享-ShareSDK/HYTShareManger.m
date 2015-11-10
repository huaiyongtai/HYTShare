//
//  HYTShareManger.m
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/9.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import "HYTShareManger.h"


@interface HYTShareManger () <HYTShareViewDelegate>

/**
 *  分享菜单视图
 */
@property (nonatomic, strong) UIView *shareView;

/**
 *  分享信息
 */
@property (nonatomic, strong) HYTShareInfo *shareInfo;

/**
 *  分享平台列表 默认注册序列(你应该将ShareType类型的枚举值包装成对象)
 */
@property (nonatomic, strong) NSArray *shareTypeList;

@end

@implementation HYTShareManger

/**
 *  初始化各个平台信息
 */
+ (void)initialize {
    [HYTShareConfig initializePlatfrom];
}

#pragma mark - 创建代理
static HYTShareManger *_instanceShare = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceShare = [super allocWithZone:zone];
    });
    return _instanceShare;
}

+ (instancetype)manager {
    if (_instanceShare == nil) {
        _instanceShare = [[self alloc] init];
        _instanceShare.shareTypeList = [ShareSDK connectedPlatformTypes];
    }
    return _instanceShare;
}

#pragma mark - 自定义分享序列
- (void)customShareTypeLists:(ShareType)shareType, ... {
    
    NSMutableArray *shareList = [NSMutableArray array];
    ShareType eachObject;
    va_list argumentList;
    if (shareType) {                                   // so we'll handle it separately.
        [shareList addObject:@(shareType)];
        va_start(argumentList, shareType); // Start scanning for arguments after firstObject.
        while ((eachObject = va_arg(argumentList, ShareType))) // As many times as we can get an argument of type "id"
            [shareList addObject: @(eachObject)]; // that isn't nil, add it to self's contents.
        va_end(argumentList);
    }
    self.shareTypeList = shareList;
}


#pragma mark -
/**
 *  直接分享
 *
 *  @param shareInfo 要分享的数据
 */
- (void)shareWithShareInfo:(HYTShareInfo *)shareInfo {
    
    NSAssert(shareInfo, @"王八蛋，你给shareInfo传nil是想干嘛");
    //1. 存储分享信息
    self.shareInfo = shareInfo;
    
    //2. 弹出选择平台视图
    HYTShareView *shareView = [[HYTShareView alloc] init];
    shareView.delegate = self;
    self.shareView = shareView;
    UIWindow *keyWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [keyWindow addSubview:shareView];
}

/**
 *  分享到相应的平台
 *
 *  @param platformType 对应的平台类型
 */
- (void)shareToPlatformType:(NSUInteger)platformType {
    
    //1、构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.shareInfo.shareContent
                                       defaultContent:self.shareInfo.sharedefaultContent
                                                image:[ShareSDK imageWithPath:self.shareInfo.shareImagePath]
                                                title:self.shareInfo.shareTitle
                                                  url:self.shareInfo.shareURL
                                          description:self.shareInfo.shareDescription
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //2、在授权页面中添加关注官方微博
    //通过这个接口里的scopes来设置，然后把声明的authOptions对象传进分享或者登陆方法里的authOptions参数中，另外如果用户已经关注了，那么客户端授权时那个关注选项是会被隐藏掉的
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES  //自动授权标志
                                                         allowCallback:NO   //是否允许授权后回调到服务器
                                                                scopes:@{@(ShareTypeSinaWeibo): @[@"follow_app_official_microblog"]} // 授权权限列表
                                                         powerByHidden:YES  ////版权信息隐藏标识 去掉授权界面Powered by ShareSDK的标志
                                                        followAccounts:nil
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup   //授权视图样式
                                                          viewDelegate:nil  //授权视图协议委托
                                               authManagerViewDelegate:nil];    //授权管理器视图协议委托
    //2.1、是否加入自动关注
    if (self.followAccounts) {
        [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:self.followAccounts],
                                        SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:self.followAccounts],
                                        SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                        nil]];
    }
    
    //3、分享
    [ShareSDK shareContent:publishContent
                      type:platformType
               authOptions:authOptions
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        //可以根据回调提示用户。
                        if (state == SSResponseStateSuccess) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                            message:nil
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil, nil];
                            [alert show];
                        } else if (state == SSResponseStateFail) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                            message:[NSString stringWithFormat:@"失败描述：%@",[error errorDescription]]
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        
                    }];
}

/**
 *  移除分享
 */
- (void)dismissShareView {
    [self.shareView removeFromSuperview];
}

#pragma mark - HYTShareViewDelegate
//- (void)shareToSomePlatform:(HYTShareItemView *)platformItem {}
- (void)shareView:(HYTShareView *)shareView didSelectedShareIconIndex:(NSInteger)shareIconIndex {
    
    //1. 分享
    [self shareToPlatformType:[self.shareTypeList[shareIconIndex] integerValue]];
    
    //2. 移除shareView视图
    [self dismissShareView];
}
- (void)shareViewDidSelectedCancelShareItem:(HYTShareView *)shareView {

    [self dismissShareView];
}

#pragma mark - 处理AppDelegate中SSO授权
+ (BOOL)mangerHandleOpenURL:(NSURL *)url
                 wxDelegate:(id)wxDelegate {
    return [ShareSDK handleOpenURL:url
                        wxDelegate:wxDelegate];
}

+ (BOOL)mangerHandleOpenURL:(NSURL *)url
          sourceApplication:(NSString *)sourceApplication
                 annotation:(id)annotation
                 wxDelegate:(id)wxDelegate {
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:wxDelegate];
}

@end
