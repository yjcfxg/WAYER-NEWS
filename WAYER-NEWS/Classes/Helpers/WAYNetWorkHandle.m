//
//  WAYNetWorkHandle.m
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-9-26.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYNetWorkHandle.h"
#import "Reachability.h"
@implementation WAYNetWorkHandle
- (instancetype)initWithStringUrl:(NSString *)url
                         delegate:(id<WAYNetWorkHandleDelegate>)delegate
{
    self = [super init];
    //
    if (self) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];


//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

        //        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

//        //        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        //
//        //        }];
//        if (delegate != nil && [delegate respondsToSelector:@selector(WAYDataDownLoad:didFinishLoading:)]) {
//            [delegate WAYDataDownLoad:self didFinishLoading:data];
//        }

//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (delegate != nil && [delegate respondsToSelector:@selector(WAYDataDownLoad:didFinishLoading:)]) {
                [delegate WAYDataDownLoad:self didFinishLoading:data];
            }
        }];

    }
    return self;
}

+ (instancetype)dataDownLoadWithStringUrl:(NSString *)url delegate:(id<WAYNetWorkHandleDelegate>)delegate
{
    
    return [[[WAYNetWorkHandle alloc] initWithStringUrl:url delegate:delegate] autorelease];
}

#pragma mark 判断当前网络是否可用
+(BOOL) isConnectionAvailable
{
    
    BOOL isExistenceNetwork;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络为WIFI状态" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            alert.hidden=NO;
//            [alert show];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [alert dismissWithClickedButtonIndex:0 animated:YES];
//            });
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前网络不可用，请检查网络连接！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    
    return isExistenceNetwork;
}

@end
