//
//  HYtViewController.m
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/6.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import "HYTViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "HYTShareManger.h"

@interface HYTViewController ()

@end

@implementation HYTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第三方分享测试";
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(startShare)];
    
    
}

- (void)startShare {
    NSLog(@"开始分享");
    
    HYTShareManger *manger = [[HYTShareManger alloc] init];
    
    
    HYTShareInfo *shareInfo = [[HYTShareInfo alloc] init];
    shareInfo.shareContent = @"内容";
    shareInfo.shareTitle = @"内容";
    shareInfo.shareURL = @"http://m.baidu.com";
    shareInfo.shareDescription = @"内容";
    shareInfo.sharedefaultContent = @"内容";
    shareInfo.shareImagePath = [[NSBundle mainBundle] pathForResource:@"Apple_2.png" ofType:nil];
    [manger shareWithShareInfo:shareInfo];

}

- (void)test {
//    //分享本地图片 设置路径 (图片要拷贝到项目里)
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Apple_2" ofType:@"png"];
//
//    //1、构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:@"永太-要分享的内容"
//                                       defaultContent:@"永太-默认内容"
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"永太-ShareSDK测试"
//                                                  url:@"http://www.baidu.com"
//                                          description:@"永太-这是一条演示信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    //1+创建弹出菜单容器（iPad必要）
//    id<ISSContainer> container = [ShareSDK container];
////    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
//
//
//    //2.1分享菜单的社交平台顺序
//    NSArray *shareList = [ShareSDK getShareListWithType:
//                          ShareTypeSinaWeibo,   //新浪
//                          ShareTypeQQ,
//                          ShareTypeQQSpace, //QQ空间
//                          ShareTypeWeixiSession,    //微信好友
//                          ShareTypeWeixiTimeline,   //微信朋友圈
//                          ShareTypeWeixiFav,   //微信收藏
//                          ShareTypeCopy,
//                          ShareTypeMail, nil];
//
//    //2.2在授权页面中添加关注官方微博
//    //通过这个接口里的scopes来设置，然后把声明的authOptions对象传进分享或者登陆方法里的authOptions参数中，另外如果用户已经关注了，那么客户端授权时那个关注选项是会被隐藏掉的
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES  //自动授权标志
//                                                         allowCallback:NO   //是否允许授权后回调到服务器
//                                                                scopes:@{@(ShareTypeSinaWeibo): @[@"follow_app_official_microblog"]} // 授权权限列表
//                                                         powerByHidden:YES  ////版权信息隐藏标识 去掉授权界面Powered by ShareSDK的标志
//                                                        followAccounts:nil
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup   //授权视图样式
//                                                          viewDelegate:nil  //授权视图协议委托
//                                               authManagerViewDelegate:nil];    //授权管理器视图协议委托
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"无法修盖"],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"无法修盖"],
//                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                    nil]];
//
//    //2、弹出分享菜单
//    [ShareSDK showShareActionSheet:container
//                         shareList:shareList  //nil默认注册序列，可以传入指定的分享顺序序列
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:authOptions  //授权选项, 传入nil时在授权时不进行任何操作
//                      shareOptions:nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//
//                                //可以根据回调提示用户。
//                                if (state == SSResponseStateSuccess) {
//                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                    message:nil
//                                                                                   delegate:self
//                                                                          cancelButtonTitle:@"OK"
//                                                                          otherButtonTitles:nil, nil];
//                                    [alert show];
//                                } else if (state == SSResponseStateFail) {
//                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                    message:[NSString stringWithFormat:@"失败描述：%@",[error errorDescription]]
//                                                                                   delegate:self
//                                                                          cancelButtonTitle:@"OK"
//                                                                          otherButtonTitles:nil, nil];
//                                    [alert show];
//                                }
//                            }];
    
}

@end
