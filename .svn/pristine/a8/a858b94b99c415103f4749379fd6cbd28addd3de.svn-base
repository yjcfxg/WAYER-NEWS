//
//  WAYFileHandle.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYFileHandle.h"
#import "WAYDetailNews.h"
#import "WAYImg.h"
#import "WAYDBHandle.h"
#import "WAYBaseNews.h"
#import "WAYChannel.h"

#define kPositionArrayKey @"positionArray"

@interface WAYFileHandle ()



@end


@implementation WAYFileHandle

#pragma mark 得到默认排序频道数据模型数组
+ (NSArray *)defaultChannelArray
{
    // 创建可变数组
    NSMutableArray *channelArray = [NSMutableArray array];
    
    // 读取plist文件，转化成模型，加入数组
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"Channel-List" withExtension:@"plist"];
    
    NSArray *array = [NSArray arrayWithContentsOfURL:plistUrl];
    
    for (NSDictionary *dict in array) {
        WAYChannel *channel = [WAYChannel new];
        [channel setValuesForKeysWithDictionary:dict];
        [channelArray addObject:channel];
        [channel release];
    }
    return channelArray;
}

#pragma mark 得到排序过的频道数据模型数组
+ (NSArray *)orderedChannelArray
{
    // 读取默认顺序数组
    NSArray *channelArray = [self defaultChannelArray];
    
    
    // 读取用户设定
    NSArray *positionArray = [self loadChannelOrder];
    
    if (positionArray) {
        // 如果有设定，返回按设定排序的频道数组
        
        NSMutableArray *orderedArray = [NSMutableArray array];
        
        for (int i = 0; i < positionArray.count; i++) {
            int index = [positionArray[i] intValue];
            [orderedArray addObject:channelArray[index]];
        }
        
        return orderedArray;
        
        
    } else {
        // 如果没有用户设定，读取默认顺序的频道数组并返回
        return channelArray;
    }
}

#pragma mark 保存顺序数组
+ (void)saveChannelOrder:(NSArray *)positionArray
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPositionArrayKey];
    [[NSUserDefaults standardUserDefaults] setObject:positionArray forKey:kPositionArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 读取顺序数组
+ (NSArray *)loadChannelOrder
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:kPositionArrayKey];
}


#pragma mark 根据下标得到频道接口
+ (NSString *)urlStringWithIndex:(NSInteger)index
                    refreshCount:(NSInteger)refreshCount
{
    NSArray *urlStringArray = @[kNewsUrl(refreshCount), kEntertainmentUrl(refreshCount), kFianceUrl(refreshCount), kSportsUrl(refreshCount), kTechnologyUrl(refreshCount), kCarUrl(refreshCount), kMilitaryUrl(refreshCount), kHistoryUrl(refreshCount), kFashionUrl(refreshCount), kNBAUrl(refreshCount), kInternationalFootballUrl(refreshCount), kChinaFootballUrl(refreshCount), kGameUrl(refreshCount), kTravelUrl(refreshCount), kMobileInternetUrl(refreshCount), kRelaxedTimeUrl(refreshCount)];
    
    return urlStringArray[index];
}

#pragma mark 根据下标得到广告型新闻
+ (WAYBaseNews *)adNewsWithIndex:(NSInteger)index
{
    NSArray *adNewsArray = [self adNewsArray];
    if (index < adNewsArray.count) {
        return adNewsArray[index];
    }
    NSLog(@"超出数组下标");
    NSLog(@"%s  -----  %d", __FUNCTION__, __LINE__);
    return nil;
}

#pragma mark 直接得到广告型新闻的数组
+ (NSArray *)adNewsArray
{
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"Ad-List" withExtension:@"plist"];
    
    NSArray *array = [NSArray arrayWithContentsOfURL:plistUrl];
    
    NSMutableArray *adNewsArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        WAYBaseNews *news = [[WAYBaseNews new]autorelease];
        [news setValuesForKeysWithDictionary:dict];
        [adNewsArray addObject:news];
    }
    return adNewsArray;
}

#pragma mark 随机得到一个广告型新闻
+ (WAYBaseNews *)randomAdNews
{
    NSArray *adNewsArray = [self adNewsArray];
    NSInteger index = arc4random() % adNewsArray.count;
    return adNewsArray[index];
}


#pragma mark 根据detailNews拼接要显示的html代码
+ (NSString *)htmlStrWithDetailNews:(WAYDetailNews *)detailNews fromLocal:(BOOL)fromLocal
{
    //  图片代码替换占位符
    NSString *newString = detailNews.body;
    
    newString = [self handleImgsWithDetailNews:detailNews htmlString:newString fromLocal:fromLocal];
    
    // 拼接设置背景和文字颜色的代码
    NSString *backgroundColorOfWeb = kColorOfWhiteWeb;
    NSString *textColorOfWeb = @"#000000";
    
    NSString *setBackgroundColor = [NSString stringWithFormat:@"<style type=\"text/css\"><!--body {background-color:%@;}a:link { text-decoration: none;color: white;}a:active { text-decoration:blink; test:expression(target=\"_blank\");}a:hover { text-decoration:underline;color: red}a:visited { text-decoration: none;color: green}a.current level_1:active{ test:expression(target=\"_self\");}a.level_1:active{ test:expression(target=\"_self\");}--></style> ", backgroundColorOfWeb];
    
    
    
    // 拼接设置标题、文章信息的代码
    NSString *titleCode = [NSString stringWithFormat: @"<p><FONT color=\"%@\" style=\"FONT-WEIGHT: bolder; FONT-SIZE: 22px\"> %@ </FONT></p>", textColorOfWeb, detailNews.title];
    
    NSString *infoCode = [NSString stringWithFormat: @"<p><FONT color=\"%@\" style=\" FONT-SIZE: 13px\"> %@     %@ </FONT></p>", kColorOfGrayWeb, detailNews.source, detailNews.ptime];
    
    // 拼接
    newString = [NSString stringWithFormat:@"%@ %@ %@ <font color=\"%@\" style=\"FONT-SIZE:17px\"> %@ </font>", setBackgroundColor, titleCode, infoCode, textColorOfWeb, newString];
    
    return newString;

}

#pragma mark 拼接代码循环替换图片占位符
+ (NSString *)handleImgsWithDetailNews:(WAYDetailNews *)detailNews htmlString:(NSString *)newString fromLocal:(BOOL)fromLocal
{
    for (WAYImg *wayImg in detailNews.img) {
        // 计算图片大小（宽高）
        NSArray *sizeArray = [wayImg.pixel componentsSeparatedByString:@"*"];
        NSInteger width = [sizeArray[0] integerValue];
        NSInteger height = [sizeArray[1] integerValue];
        
        CGFloat scale = width / 300.0;
        width /= scale;
        height /= scale;
        
        // 拼接要换成的string
        
        // 加图片
        NSString *addImage =  [NSString stringWithFormat:@"<p></p><p></p> <img src=\"%@\" width=\"%ld\" height=\"%ld\" />", wayImg.src, width, height];
        // 加图片注解信息
        // 字体颜色
        NSString *textColorOfImageInfo = kColorOfGrayWeb;
        
        NSString *addImageInfo = [NSString stringWithFormat:@"</p><p>  <font style=\"FONT-SIZE:11pt\" color=\"%@\"> %@ </font>", textColorOfImageInfo, wayImg.alt];
        
        
        
        // 拼接到一起
        NSString *holeImageCodeString = [NSString stringWithFormat:@"%@%@", addImage, addImageInfo];
        
        
        // 替换占位符
        newString = [newString stringByReplacingOccurrencesOfString:wayImg.ref withString:holeImageCodeString];
    }
    return newString;
}

#pragma mark - 数据库
#pragma mark 缓存文件夹
+ (NSString *)cachesPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark 数据库存储路径
+ (NSString *)databaseFilePath:(NSString *)databaseName
{
    NSLog(@"%@",[[self cachesPath] stringByAppendingPathComponent:databaseName]);
    return [[self cachesPath] stringByAppendingPathComponent:databaseName];
}


#pragma mark - 归档、反归档
#pragma mark 将对象归档
+ (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key
{
    NSMutableData  * data=[NSMutableData data];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    [archiver release];
    return data;
}

#pragma mark 反归档
+ (id)unarchiveObject:(NSData *)data forKey:(NSString *)key
{
    if (data == nil) {
        return nil;
    }
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object=[unarchiver decodeObjectForKey:key];
    
    [unarchiver finishDecoding];
    
    [unarchiver release];
    return object;
}

#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
+ (NSString *)imageFilePathWithUrl:(NSString *)imageUrl
{
    //根据图片的url，创建保存图片时的文件名
    NSString *imageName=[imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return [[self downloadImageManagerFilePath] stringByAppendingPathComponent:imageName];
}

#pragma mark 将下载的图片保存到沙盒中
+ (void)saveDownloadImage:(UIImage *)image fielPath:(NSString *)path
{
    NSData * data= UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:path atomically:YES];
    
}

#pragma mark 存储下载图片的路径
+ (NSString *)downloadImageManagerFilePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"DownloadImages"];
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
        //如果沙盒中没有存储图片的文件夹，就创建
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return imageManagerPath;
}
#pragma mark - 清除缓存文件夹操作
//#pragma mark 清除缓存
//+ (void)cleanDownloadImages
//{
//    NSString * imageManagerPath=[self downloadImageManagerFilePath];
//    NSFileManager * fielManager=[NSFileManager defaultManager];
//    [fielManager removeItemAtPath:imageManagerPath error:nil];
//    //创建路径
//    [self downloadImageManagerFilePath];
//}

#pragma mark 计算缓存Cache文件大小
+ (CGFloat)checkTmpSize
{
    NSString *cachePath = [self downloadCachePath];
    
    CGFloat size = [self folderSizeAtPath:cachePath];

    return size;
}
#pragma mark 计算单个文件大小
+ (long long) fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
#pragma mark - 遍历文件夹获得文件夹大小，返回多少M
+ (CGFloat) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/1024.0/1024.0;
}


#pragma mark 存储缓存路径
+(NSString *)downloadCachePath
{
    NSString * cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;

    return cachePath;
}

#pragma mark 清除所有缓存
+(void)cleanCachePath
{
    NSString *cachePath=[self downloadCachePath];
//    NSFileManager * fileManager=[NSFileManager defaultManager];
//    [fileManager removeItemAtPath:cachePath error:nil];
//    
//    
//    //创建路径
//    if (NO == [fileManager fileExistsAtPath:cachePath]) {
//        //如果沙盒中没有存储图片的文件夹，就创建
//        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:cachePath]) return ;
//    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:cachePath] objectEnumerator];
//    NSString* fileName;
//    while ((fileName = [childFilesEnumerator nextObject]) != nil){
//        NSString* fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
//        NSLog(@"%@", fileAbsolutePath);
//        [manager removeItemAtPath:fileAbsolutePath error:nil];
//    }
    NSArray *array = [manager subpathsAtPath:cachePath];
    for (NSString *fileName in array) {
        NSString *path = [cachePath stringByAppendingPathComponent:fileName];
        [manager removeItemAtPath:path error:nil];
    }
}
#pragma mark - 从数据库取值
#pragma mark 从数据库读取新闻数据源
+ (NSArray *)setupNewsDataSource
{
    
    return [[WAYDBHandle shareInstance] selectAllNews];
}
#pragma mark 获取新闻的个数
+ (NSInteger)countOfNews
{
    return [[self setupNewsDataSource] count];
}
#pragma mark 获取某个新闻对象
+ (WAYBaseNews *)newsForRow:(NSInteger)row
{
    return [self setupNewsDataSource][row];
}
#pragma mark 删除某个新闻对象
+ (void)deleteNewsForRow:(NSInteger)row
{
    [[WAYDBHandle shareInstance] deleteNew:[self newsForRow:row]];
    
}

#pragma mark - 对新闻详情的数据库操作
#pragma mark 从数据库读取新闻详情数据源
+ (NSArray *)setupDetailNewsDataSource
{
    return [[WAYDBHandle shareInstance] selectAllNewsDetail];
}
#pragma mark 获取某个新闻详情对象
+ (WAYDetailNews *)DetailnewsForRow:(NSInteger)row
{
    return [self setupDetailNewsDataSource][row];
}
#pragma mark 删除某个新闻详情
+ (void)deleteDetailNewsForRow:(NSInteger)row
{
    [[WAYDBHandle shareInstance] deleteNewsDetail:[self DetailnewsForRow:row]];
}
#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    
    
    [super dealloc];
}
@end
