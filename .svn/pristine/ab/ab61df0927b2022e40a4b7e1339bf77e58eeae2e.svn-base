//
//  WAYBaseNews.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYBaseNews.h"

@interface WAYBaseNews ()

@end

@implementation WAYBaseNews

#pragma mark 实现没有找到key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//- (id)copyWithZone:(NSZone *)zone
//{
//    WAYBaseNews *baseNews = [WAYBaseNews new];
//    baseNews.title = self.title;
//    baseNews.imgsrc = self.imgsrc;
//    baseNews.digest = self.digest;
//    
//    return baseNews;
//}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.imgsrc forKey:@"imgsrc"];
    [aCoder encodeObject:self.digest forKey:@"digest"];
    [aCoder encodeInteger:self.replyCount forKey:@"replyCount"];
    [aCoder encodeObject:self.imgextra forKey:@"imgextra"];
    [aCoder encodeObject:self.docid forKey:@"docid"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.ptime forKey:@"ptime"];
    [aCoder encodeObject:self.adTitle forKey:@"adTitle"];
    [aCoder encodeObject:self.hasAD forKey:@"hasAD"];
    [aCoder encodeObject:self.lmodify forKey:@"lmodify"];
    [aCoder encodeObject:self.priority forKey:@"priority"];
    [aCoder encodeObject:self.myTemplate forKey:@"myTemplate"];
    [aCoder encodeObject:self.timeConsuming forKey:@"timeConsuming"];
    [aCoder encodeObject:self.tname forKey:@"tname"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.url_3w forKey:@"url_3w"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        self.title=[aDecoder decodeObjectForKey:@"title"];
        self.imgsrc=[aDecoder decodeObjectForKey:@"imgsrc"];
        self.digest=[aDecoder decodeObjectForKey:@"digest"];
        self.replyCount=[aDecoder decodeIntForKey:@"replyCount"];
        self.imgextra=[aDecoder decodeObjectForKey:@"imgextra"];
        self.docid=[aDecoder decodeObjectForKey:@"docid"];
        self.source=[aDecoder decodeObjectForKey:@"source"];
        self.ptime=[aDecoder decodeObjectForKey:@"ptime"];
        self.adTitle=[aDecoder decodeObjectForKey:@"adTitle"];
        self.hasAD=[aDecoder decodeObjectForKey:@"hasAD"];
        self.lmodify=[aDecoder decodeObjectForKey:@"lmodify"];
        self.priority=[aDecoder decodeObjectForKey:@"priority"];
        self.myTemplate=[aDecoder decodeObjectForKey:@"myTemplate"];
        self.timeConsuming=[aDecoder decodeObjectForKey:@"timeConsuming"];
        self.tname=[aDecoder decodeObjectForKey:@"tname"];
        self.url=[aDecoder decodeObjectForKey:@"url"];
        self.url_3w=[aDecoder decodeObjectForKey:@"url_3w"];
    }
    return self;
}
#pragma mark dealloc方法的实现
- (void)dealloc
{
    [_title release];
    [_imgsrc release];
    [_digest release];
    [_imgextra release];
    [_hasAD release];
    [_adTitle release];
    [_docid release];
    [_lmodify release];
    [_priority release];
    [_ptime release];
    [_source release];
    [_myTemplate release];
    [_timeConsuming release];
    [_tname release];
    [_url release];
    [_url_3w release];
    [super dealloc];
}

@end
