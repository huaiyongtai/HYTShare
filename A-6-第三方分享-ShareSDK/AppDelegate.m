//
//  AppDelegate.m
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/6.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import "AppDelegate.h"
#import "HYTViewController.h"
#import "HYTShareManger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[[HYTViewController alloc] init]];
    [self.window setRootViewController:navVC];
    [self.window makeKeyAndVisible];
    
    [HYTShareManger manager];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [HYTShareManger mangerHandleOpenURL:url
                                    wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [HYTShareManger mangerHandleOpenURL:url
                             sourceApplication:sourceApplication
                                    annotation:annotation
                                    wxDelegate:self];
    
}

@end
