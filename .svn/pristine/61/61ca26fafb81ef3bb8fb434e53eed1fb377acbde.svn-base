//
//  WAYChannelHeader.m
//  WAYER-NEWS
//
//  Created by 喵了个咪 on 14-9-26.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannelHeader.h"
#import "WAYHeaderPhotoView.h"

@interface WAYChannelHeader ()


@end

@implementation WAYChannelHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
//        scrollView.backgroundColor = [UIColor greenColor];
//        scrollView.pagingEnabled = YES;
//        scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame)*3, CGRectGetHeight(scrollView.frame));
//        [self addSubview:scrollView];

        
        
   
        
        
        // 添加headerPhotoView
        self.headerPhotoView = [[[WAYHeaderPhotoView alloc] initWithFrame:self.bounds]autorelease];
        [self addSubview:_headerPhotoView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

*/

#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_headerPhotoView release];
    
    [super dealloc];
}

@end
