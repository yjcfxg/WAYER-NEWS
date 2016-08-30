//
//  WAYWeixinShareHandle.m
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-10-14.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYWeixinShareHandle.h"

#define kWeChatAppId @"wx140c2d8775b08338"

@implementation WAYWeixinShareHandle


static WAYWeixinShareHandle *weixinhandle = nil;

#pragma mark 初始化单例
+ (WAYWeixinShareHandle *) sharedInstance
{
    if (weixinhandle == nil)
    {
        weixinhandle = [[[self class] alloc] init];
    }
    
    return weixinhandle;
}
#pragma mark 处理打开网址
- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark 注册微信app
- (void)registerApp
{
    //向微信注册
    [WXApi registerApp:kWeChatAppId];
    
}
//#pragma mark - wechat delegate
//- (void)weChatPostStatus:(NSString*)message
//{
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = YES;
//    req.text = message;
//    req.scene = WXSceneSession;
//    
//    [WXApi sendReq:req];
//}
//
//- (void)weChatFriendPostStatus:(NSString*)message
//{
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = YES;
//    req.text = message;
//    req.scene = WXSceneTimeline;
//    
//    [WXApi sendReq:req];
//}
//- (void)weChatFavoritePostStatus:(NSString*)message
//{
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = YES;
//    req.text = message;
//    req.scene = WXSceneFavorite;
//    
//    [WXApi sendReq:req];
//}

#pragma mark 发送内容给微信
- (void)sendAppContentWithMessage:(NSString *)appMessage WithUrl:(NSString *)appUrl WithDegist:(NSString *)degist WithImage:(NSString *)ImgUrl WithScene:(int)scene
{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    if (WXSceneTimeline == scene)
    {
        message.title = appMessage;
    }
    else if(WXSceneSession == scene)
    {
        message.title = appMessage;
        
    }else{
        message.title = appMessage;
    }
    message.description = degist;
    [message setThumbImage:kAppIcon];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = appUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq  * req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

#pragma mark 给微信发送消息
//给微信发送消息
- (void)sendWeChatMessage:(NSString *)message WithUrl:(NSString *)url WithDigest:(NSString *)digest WithImage:(NSString *)ImgUrl WithScene:(enum WXScene)scene
{
    if(WXSceneSession == scene)
    {
        [self sendAppContentWithMessage:message WithUrl:url WithDegist:digest WithImage:ImgUrl WithScene:WXSceneSession];
        return;
    }
    else if(WXSceneTimeline == scene)
    {
        [self sendAppContentWithMessage:message WithUrl:url WithDegist:digest WithImage:ImgUrl WithScene:WXSceneTimeline];
        return;
    }else{
        [self sendAppContentWithMessage:message WithUrl:url WithDegist:digest WithImage:ImgUrl WithScene:WXSceneFavorite];
        return;
    }
}
#pragma mark 通过微信发送信息，返回app
-(void) onSentTextMessage:(BOOL) bSent
{
    // 通过微信发送消息后， 返回本App
    NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
    NSString *strMsg = [NSString stringWithFormat:@"发送文本消息结果:%u", bSent];
   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
  
}


-(void) onRequestAppMessage
{
    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
}
#pragma mark WXApi代理方法
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        [self onRequestAppMessage];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        
    }
    
}

-(void) onResp:(BaseResp*)resp
{
//    if([resp isKindOfClass:[SendMessageToWXResp class]])
//    {
//      
//           NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
//            NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
//   
//       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//             [alert show];
//              [alert release];
//    }
//   else if([resp isKindOfClass:[SendAuthResp class]])
//     {
//          NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
//          NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
//   
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//       [alert show];
//        [alert release];
//   }
}


@end
