//
//  WAYChannel.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-10-6.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannel.h"

@implementation WAYChannel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_title release];
    [_image release];
    
    [super dealloc];
}

@end
