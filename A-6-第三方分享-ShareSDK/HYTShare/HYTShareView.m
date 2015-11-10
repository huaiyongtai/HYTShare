//
//  HYTShareView.m
//  A-6-第三方分享-ShareSDK
//
//  Created by HelloWorld on 15/11/10.
//  Copyright (c) 2015年 HelloWorld. All rights reserved.
//

#import "HYTShareView.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation HYTShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setFrame:[UIScreen mainScreen].bounds];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        
        NSUInteger rowCount = 4;
        CGFloat shareItemWidth = 70;
        CGFloat shareItemHeight = 40;
        CGFloat shareItemPadding = (SCREEN_WIDTH-shareItemWidth*rowCount)/(rowCount-1);
        for (int index=0; index<10; index++) {
            CGFloat shareItemX = index%rowCount * (shareItemWidth + shareItemPadding);
            CGFloat shareItemY = index/rowCount * (shareItemHeight + shareItemPadding) + 300;
            UIButton *shareItem = [UIButton buttonWithType:UIButtonTypeCustom];
            [shareItem setBackgroundColor:[UIColor redColor]];
            [shareItem setTitle:[NSString stringWithFormat:@"%i", index] forState:UIControlStateNormal];
            [shareItem setFrame:CGRectMake(shareItemX, shareItemY, shareItemWidth, shareItemHeight)];
            [shareItem setTag:index];
            [shareItem addTarget:self action:@selector(shareIconDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:shareItem];
        }
        
        UIButton *cancelSharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelSharebtn setTitle:@"取消分享" forState:UIControlStateNormal];
        [cancelSharebtn setBackgroundColor:[UIColor orangeColor]];
        [cancelSharebtn setFrame:CGRectMake(0, SCREEN_HEIGHT-shareItemHeight, SCREEN_WIDTH, shareItemHeight)];
        [cancelSharebtn addTarget:self action:@selector(clickCannelBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelSharebtn];

    }
    return self;
}

- (void)shareIconDidClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(shareView:didSelectedShareIconIndex:)]) {
        [self.delegate shareView:self didSelectedShareIconIndex:btn.tag];
    }
}

- (void)clickCannelBtn {
    
    if ([self.delegate respondsToSelector:@selector(shareViewDidSelectedCancelShareItem:)]) {
        [self.delegate shareViewDidSelectedCancelShareItem:self];
    }
}

@end
