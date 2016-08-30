//
//  WAYShareViewController.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-10-8.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYShareViewController.h"
#import "WAYShareSubView.h"
#import "WAYWeixinShareHandle.h"
#import "ColorAndScale.h"

#define kBaseTagOfButtons 200

#define height 208
#define kFrameBefore CGRectMake(0, kHeightOfScreen, kWidthOfScreen, height)
#define kFrameAfter CGRectMake(0, kHeightOfScreen - height, kWidthOfScreen, height)

@interface WAYShareViewController ()

@property (nonatomic, retain) WAYShareSubView *subView;
@property (nonatomic, retain) UIButton *backgroundButton;


@end

@implementation WAYShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    // 背景button
    self.backgroundButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backgroundButton.frame = [UIScreen mainScreen].bounds;
    _backgroundButton.backgroundColor = [UIColor blackColor];
    _backgroundButton.alpha = 0;
    _backgroundButton.userInteractionEnabled = NO;
    
    [_backgroundButton addTarget:self action:@selector(backgroundButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backgroundButton];
    
    // 子视图（放置button的视图）
    self.subView = [[[WAYShareSubView alloc] initWithFrame: kFrameBefore] autorelease];
    [_subView setButtonNumber:2] ;
    _subView.backgroundColor = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
    [self.view addSubview:_subView];
    
    [self addActionToButtons];
}
- (void)addActionToButtons
{
    for (int i = 0; i < _subView.allButtonArray.count; i++) {
        UIButton *button = _subView.allButtonArray[i];
        
        if (i == 0) {
            [button setBackgroundImage:[UIImage imageNamed:@"cancelButton.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 1) {
            [button setBackgroundImage:[UIImage imageNamed:@"sendToFriend.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareToFriend:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 2) {
            [button setBackgroundImage:[UIImage imageNamed:@"shareToCircle"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareToTimeLine:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 3) {
            
        }
    }
}


#pragma mark button绑定事件
- (void)cancelButtonAction:(UIButton *)sender
{
    [self dismissInDuration:.4];
}


#pragma mark 把应用分享给好友
- (void)shareToFriend:(UIButton *)sender
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        [[WAYWeixinShareHandle sharedInstance] sendWeChatMessage:@"最炫新闻app" WithUrl:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",  @"930027626"] WithDigest:@"WAYER资讯，快速，便捷，高效,由胡竞尘，琚增辉，徐光三人开发" WithImage:nil WithScene:WXSceneSession];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，您的微信客户端未安装，请先安装后再操作！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }

}

#pragma mark 把应用分享给朋友圈
- (void)shareToTimeLine:(UIButton *)sender
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
    [[WAYWeixinShareHandle sharedInstance] sendWeChatMessage:@"最炫新闻app" WithUrl:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",  @"930027626"] WithDigest:@"WAYER资讯，快速，便捷，高效,由胡竞尘，琚增辉，徐光三人开发" WithImage:nil WithScene:WXSceneTimeline];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，您的微信客户端未安装，请先安装后再操作！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }

}


#pragma mark 背景button触发方法
- (void)backgroundButtonAction:(UIButton *)sender
{
    [self dismissInDuration:.4];
}

#pragma mark 消失
- (void)dismissInDuration:(CGFloat)durantion
{
    // 关掉button交互
    _backgroundButton.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:durantion delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // 动画
        // 背景button颜色渐变
        _backgroundButton.alpha = 0;
        
        // 子视图弹回下方
        _subView.frame = kFrameBefore;
        
        
    } completion:^(BOOL finished) {
        // 完成后
        
        // 隐藏
        self.view.window.hidden = YES;
        // tabBar出现
//        UITabBar *tabbar = self.parentViewController.navigationController.tabBarController.tabBar;
//        tabbar.alpha = 0;
//        tabbar.hidden = NO;
//        [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            tabbar.alpha = 1;
//        } completion:^(BOOL finished) {
//            
//        }];
    }];
    

}

#pragma mark 出现时调用
- (void)show
{
    // 出现
    self.view.window.hidden = NO;
    // tabbar隐藏
//    [self.parentViewController.navigationController.tabBarController.tabBar setHidden:YES];
    
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // 动画
        // 背景button颜色渐变
        _backgroundButton.alpha = .5;
        
        // 子视图从下弹出
        _subView.frame = kFrameAfter;
        
        
    } completion:^(BOOL finished) {
        // 完成后
        // 开启backgroundButton交互
        _backgroundButton.userInteractionEnabled = YES;
        

    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_backgroundButton release];
    [_subView release];
    
    [super dealloc];
}


@end
