//
//  WAYFileHandle.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Port.h"

@class WAYDetailNews;
@class WAYBaseNews;
@interface WAYFileHandle : NSObject


#pragma mark - 方法声明
#pragma mark 得到默认排序频道数据模型数组
+ (NSArray *)defaultChannelArray;

#pragma mark 得到排序过的频道数据模型数组
+ (NSArray *)orderedChannelArray;

#pragma mark 保存顺序数组
+ (void)saveChannelOrder:(NSArray *)positionArray;

#pragma mark 读取顺序数组
+ (NSArray *)loadChannelOrder;

#pragma mark 根据下标和刷新计数得到对应频道的新闻列表接口
+ (NSString *)urlStringWithIndex:(NSInteger)index
                    refreshCount:(NSInteger)refreshCount;

#pragma mark 根据下标得到广告型新闻
+ (WAYBaseNews *)adNewsWithIndex:(NSInteger)index;
#pragma mark 直接得到广告型新闻的数组
+ (NSArray *)adNewsArray;
#pragma mark 随机得到一个广告型新闻
+ (WAYBaseNews *)randomAdNews;


#pragma mark 根据detailNews拼接要显示的html代码

+ (NSString *)htmlStrWithDetailNews:(WAYDetailNews *)detailNews fromLocal:(BOOL)fromLocal;



#pragma mark 对数据库的存储操作
#pragma mark 缓存文件夹
+ (NSString *)cachesPath;
#pragma mark 数据库存储路径
+ (NSString *)databaseFilePath:(NSString *)databaseName;

#pragma mark --归档、反归档
//将对象归档
+ (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;
//反归档
+ (id)unarchiveObject:(NSData *)data forKey:(NSString *)key;


#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
+ (NSString *)imageFilePathWithUrl:(NSString *)imageUrl;
#pragma mark 保存图片缓存
+ (void)saveDownloadImage:(UIImage *)image fielPath:(NSString *)path;

#pragma mark 计算缓存文件大小
+ (CGFloat)checkTmpSize;

#pragma mark 存储缓存路径
+(NSString *)downloadCachePath;

#pragma mark 清除所有缓存
+(void)cleanCachePath;

//-(void)clearDiskOnCompletion:^(void)completion;


#pragma mark - 从数据库取值
#pragma mark 从数据库读取新闻数据源
+ (NSArray *)setupNewsDataSource;
#pragma mark 获取新闻的个数
+ (NSInteger)countOfNews;

#pragma mark 获取某个新闻对象
+ (WAYBaseNews *)newsForRow:(NSInteger)row;
#pragma mark   删除某个新闻对象
+ (void)deleteNewsForRow:(NSInteger)row;





#pragma mark 从数据库读取新闻数据源
+ (NSArray *)setupDetailNewsDataSource;
#pragma mark 获取某个新闻详情对象
+ (WAYDetailNews *)DetailnewsForRow:(NSInteger)row;
#pragma mark 删除某个新闻详情
+ (void)deleteDetailNewsForRow:(NSInteger)row;

@end
