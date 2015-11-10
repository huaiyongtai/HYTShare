//
//  HYTShareView.h
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/10.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYTShareView;

@protocol HYTShareViewDelegate <NSObject>

@optional

- (void)shareView:(HYTShareView *)shareView didSelectedShareIconIndex:(NSInteger)shareIconIndex;

- (void)shareViewDidSelectedCancelShareItem:(HYTShareView *)shareView;

@end

@interface HYTShareView : UIView

@property (nonatomic, weak) id <HYTShareViewDelegate> delegate;

@end
