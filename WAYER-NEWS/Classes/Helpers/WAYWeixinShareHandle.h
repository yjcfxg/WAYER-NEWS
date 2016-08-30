//
//  WAYWeixinShareHandle.h
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-10-14.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"
@interface WAYWeixinShareHandle : NSObject<WXApiDelegate>

//@property (nonatomic ,assign) enum WXScene scene;

+ (WAYWeixinShareHandle *) sharedInstance;

- (BOOL)handleOpenURL:(NSURL *)url;

- (void)registerApp;



/**
 *@description 发送微信消息
 *@param message:文本消息 url:分享链接 weibotype:微信消息类型
 */
#pragma mark 发送内容给微信
- (void)sendAppContentWithMessage:(NSString *)appMessage WithUrl:(NSString *)appUrl WithDegist:(NSString *)degist WithImage:(NSString *)ImgUrl WithScene:(int)scene;
#pragma mark 发送消息给好友
- (void)sendWeChatMessage:(NSString*)message WithUrl:(NSString*)url WithDigest:(NSString *)digest WithImage:(NSString *)ImgUrl WithScene:(enum WXScene)scene;

@end
