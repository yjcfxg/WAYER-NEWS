//
//  WAYNetWorkHandle.h
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-9-26.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WAYNetWorkHandle;
@protocol WAYNetWorkHandleDelegate <NSObject>

- (void)WAYDataDownLoad:(WAYNetWorkHandle *)dataDownLoad didFinishLoading:(NSData *)data;

@end

@interface WAYNetWorkHandle : NSObject

#pragma mark 初始化 提供一个url字符串得到一个data
- (instancetype)initWithStringUrl:(NSString *)url
                         delegate:(id<WAYNetWorkHandleDelegate>)delegate;
#pragma mark 便利构造器
+ (instancetype)dataDownLoadWithStringUrl:(NSString *)url
                                 delegate:(id<WAYNetWorkHandleDelegate>)delegate;

#pragma mark 判断当前网络是否可用
+(BOOL) isConnectionAvailable;
@end
