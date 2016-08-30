//
//  WAYChannelCell.m
//  WAYER-NEWS
//
//  Created by 喵了个咪 on 14-9-26.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannelCell.h"

@implementation WAYChannelCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}


-(void)addAllViews
{
    
    self.label = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))] autorelease] ;
    _label.backgroundColor = kColorOfWhite;
    [self.contentView addSubview:_label];
    
    
    self.imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    [self addSubview:_imageView];

    
}


#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_label release];
    [_imageView release];
    
    [super dealloc];
}


@end
