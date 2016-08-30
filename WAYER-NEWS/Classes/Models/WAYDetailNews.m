//
//  WAYDetailNews.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-27.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYDetailNews.h"
#import "WAYImg.h"

@implementation WAYDetailNews



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.body forKey:@"body"];
    [aCoder encodeObject:self.docid forKey:@"docid"];
    [aCoder encodeObject:self.ptime forKey:@"ptime"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img forKey:@"img"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.body=[aDecoder decodeObjectForKey:@"body"];
        self.docid=[aDecoder decodeObjectForKey:@"docid"];
        self.ptime=[aDecoder decodeObjectForKey:@"ptime"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
    }
    return self;
}



#pragma mark - 重写

#pragma mark 重写img属性的setter
- (void)setImg:(NSArray *)img
{
    if (_img != img) {
        [_img release];
        _img = [img retain];
    }
    if ([[_img lastObject] isKindOfClass:[WAYImg class]]) {
        return;
    }
    NSMutableArray *imgArr = [NSMutableArray array];
    for (NSDictionary *dict in _img) {
        WAYImg *wayImg = [WAYImg new];
        [wayImg setValuesForKeysWithDictionary:dict];
        [imgArr addObject:wayImg];
    }
    
    _img = [imgArr retain];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

#pragma mark dealloc
- (void)dealloc
{
    [_body release];
    [_docid release];
    [_ptime release];;
    [_source release];
    [_title release];
    [_img release];
    
    [super dealloc];
}

@end
