//
//  WAYDBHandle.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYDBHandle.h"
#import "WAYBaseNews.h"
#import "WAYDetailNews.h"
#import <sqlite3.h>
#import "WAYFileHandle.h"
#define kDatabaseName   @"BaseNews.sqlite"
@implementation WAYDBHandle


#pragma mark 创建单例对象
static WAYDBHandle *handle=nil;
+ (WAYDBHandle *)shareInstance
{
    if (handle == nil) {
        handle=[[[self class] alloc] init];
        [handle openDB];
    }
    return handle;
    
}

#pragma mark 对数据库的更删改查操作
static sqlite3 *db=nil;
#pragma mark openDB
- (void)openDB
{
    if (db != nil) {
        return;
    }
    
    //数据库存储在沙盒中的caches文件夹下
    NSString * dbPath = [WAYFileHandle databaseFilePath:kDatabaseName];
    int result = sqlite3_open([dbPath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        //创建表的sql语句
        NSString *createSql=@"CREATE TABLE NewsList (ID TEXT PRIMARY KEY , title TEXT, imageUrl TEXT, digest Text ,replyCount TEXT ,data BLOB);CREATE TABLE NewsDetailList (ID TEXT PRIMARY KEY, title TEXT,body TEXT, ptime TEXT,source TEXT, data BLOB)";
        //执行sql语句
        sqlite3_exec(db, [createSql UTF8String], NULL, NULL, NULL);
    }
}

//关闭数据库
- (void)closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        
        NSLog(@"数据库关闭成功");
        db = nil;
    }
}

#pragma mark 添加新的新闻
- (void)insertNewNews:(WAYBaseNews *)news
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"insert into NewsList (ID,title,imageUrl,digest,replyCount,data) values (?,?,?,?,?,?)";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [news.docid UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [news.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [news.imgsrc UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [news.digest UTF8String], -1, NULL);
        
        sqlite3_bind_int64(stmt, 5, news.replyCount);
        NSString * archiverKey = [NSString stringWithFormat:@"%@%@", kNewsArchiverKey, news.docid];
        NSData * data = [WAYFileHandle dataOfArchiverObject:news forKey:archiverKey];
        
        sqlite3_bind_blob(stmt, 6, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
    }
    NSLog(@"插入数据成功！");
    
    sqlite3_finalize(stmt);
}

#pragma mark 删除某个新闻
- (void)deleteNew:(WAYBaseNews *)news
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from NewsList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [news.docid UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    
}

#pragma mark 获取某个新闻对象
- (WAYBaseNews *)selectNewsWithID:(NSString *)ID
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from NewsList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    WAYBaseNews * news = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kNewsArchiverKey,ID];
            news = [WAYFileHandle unarchiveObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return news;
}

#pragma mark 获取所有新闻
- (NSArray *)selectAllNews
{
    
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from NewsList";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    NSMutableArray * newsArray = [NSMutableArray arrayWithCapacity:40];
    
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kNewsArchiverKey,ID];
            
            WAYBaseNews * news = [WAYFileHandle unarchiveObject:data forKey:archiverKey];
            [newsArray addObject:news];
        }
        
    }
    
    sqlite3_finalize(stmt);
    return newsArray;
}
#pragma mark 删除所有的新闻
- (void)deleteAllNews
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from NewsList";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
//        sqlite3_bind_text(stmt, 1, [news.docid UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);

    
}
#pragma mark 判断新闻是否被下载
- (BOOL)isDownLoadNewsWithID:(NSString *)ID
{
    WAYBaseNews * news = [self selectNewsWithID:ID];
    if (news == nil) {
        return NO;
    }
    
    return YES;
}
#pragma mark  - 对新闻详情数据的操作
#pragma mark  - 添加新的新闻详情
- (void)insertNewNewsDetail:(WAYDetailNews *)Detailnews
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    
    NSString * sql = @"insert into NewsDetailList (ID,title,body,ptime,source,data) values (?,?,?,?,?,?)";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [Detailnews.docid UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [Detailnews.title UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [Detailnews.body UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [Detailnews.ptime UTF8String], -1, NULL);
        
        sqlite3_bind_text(stmt, 5, [Detailnews.source UTF8String], -1, NULL);
        NSString * archiverKey = [NSString stringWithFormat:@"%@%@", kNewsDetailArchiverKey, Detailnews.docid];
        NSData * data = [WAYFileHandle dataOfArchiverObject:Detailnews forKey:archiverKey];
        
        sqlite3_bind_blob(stmt, 6, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
    }
    NSLog(@"插入数据成功！");
    
    sqlite3_finalize(stmt);
    
}
#pragma mark    删除某个新闻详情
- (void)deleteNewsDetail:(WAYDetailNews *)Detailnews
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from NewsDetailList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [Detailnews.docid UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
}
#pragma mark    获取某个新闻详情
- (WAYDetailNews *)selectNewsDetail:(NSString *)ID
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select data from NewsDetailList where ID = ?";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    WAYDetailNews * news = nil;
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, [ID UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kNewsDetailArchiverKey,ID];
            news = [WAYFileHandle unarchiveObject:data forKey:archiverKey];
        }
        
    }
    
    sqlite3_finalize(stmt);
    
    return news;
    
}
#pragma mark    获取所有新闻详情
- (NSArray *)selectAllNewsDetail
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"select ID,data from NewsDetailList";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    NSMutableArray * newsArray = [NSMutableArray arrayWithCapacity:40];
    
    if (result == SQLITE_OK)
    {
        
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            
            NSString * ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            
            NSString * archiverKey = [NSString stringWithFormat:@"%@%@",kNewsDetailArchiverKey,ID];
            
            WAYDetailNews * news = [WAYFileHandle unarchiveObject:data forKey:archiverKey];
            [newsArray addObject:news];
        }
        
    }
    return newsArray;
    
}
#pragma mark 删除全部新闻详情
- (void)deleteAllNewsDetail
{
    [self openDB];
    
    sqlite3_stmt * stmt = nil;
    
    NSString * sql = @"delete from NewsDetailList";
    
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        //        sqlite3_bind_text(stmt, 1, [news.docid UTF8String], -1, NULL);
        
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    
}

@end
