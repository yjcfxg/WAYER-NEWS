//
//  WAYDBHandle.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WAYBaseNews;
@class WAYDetailNews;
@interface WAYDBHandle : NSObject

#pragma mark 初始化对象
+ (WAYDBHandle *)shareInstance;

#pragma mark 打开数据库
- (void)openDB;
#pragma mark 关闭数据库
- (void)closeDB;

#pragma mark   WAYBaseNews 数据库操作
#pragma mark   添加新的新闻
- (void)insertNewNews:(WAYBaseNews *)news;
#pragma mark   删除某个新闻
- (void)deleteNew:(WAYBaseNews *)news;

#pragma mark   获取某个新闻
- (WAYBaseNews *)selectNewsWithID:(NSString *)ID;
#pragma mark   获取所有新闻
- (NSArray *)selectAllNews;
#pragma mark   删除全部新闻
- (void)deleteAllNews;

#pragma mark 判断新闻是否被下载
- (BOOL)isDownLoadNewsWithID:(NSString *)ID;

#pragma mark  - 添加新的新闻详情
- (void)insertNewNewsDetail:(WAYDetailNews *)Detailnews;
#pragma mark    删除某个新闻详情
- (void)deleteNewsDetail:(WAYDetailNews *)Detailnews;
#pragma mark    获取某个新闻详情
- (WAYDetailNews *)selectNewsDetail:(NSString *)ID;
#pragma mark    获取所有新闻详情
- (NSArray *)selectAllNewsDetail;
#pragma mark    删除全部详情
- (void)deleteAllNewsDetail;

@end
