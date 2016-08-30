//
//  WAYImg.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-27.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYImg.h"

@implementation WAYImg

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.alt = [aDecoder decodeObjectForKey:@"alt"];
        self.pixel = [aDecoder decodeObjectForKey:@"pixel"];
        self.ref = [aDecoder decodeObjectForKey:@"ref"];
        self.src = [aDecoder decodeObjectForKey:@"src"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.alt forKey:@"alt"];
    [aCoder encodeObject:self.pixel forKey:@"pixel"];
    [aCoder encodeObject:self.ref forKey:@"ref"];
    [aCoder encodeObject:self.src forKey:@"src"];
}


#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_alt release];
    [_pixel release];
    [_ref release];
    [_src release];
    
    [super dealloc];
}

@end
