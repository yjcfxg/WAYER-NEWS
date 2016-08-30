//
//  WAYScrollPhotoTableViewCell.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-26.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYScrollPhotoTableViewCell.h"
#import "WAYHeaderPhotoView.h"

#define kSpace 10
@implementation WAYScrollPhotoTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addAllViews];
    }
    return self;
}
#pragma mark 添加视图
- (void)addAllViews
{
//    self.mainView = [[[UIImageView alloc] initWithFrame:CGRectMake(kSpace, kSpace, 300, 180)]autorelease];
//    [self addSubview:_mainView];
//    
//    
//    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_mainView.frame), CGRectGetMaxY(_mainView.frame)+kSpace, CGRectGetWidth(_mainView.frame), 20)]autorelease];
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_titleLabel];
    
    
    // 添加headerPhotoView
    self.headerPhotoView = [[[WAYHeaderPhotoView alloc] initWithFrame:self.bounds]autorelease];
    [self addSubview:_headerPhotoView];
    
    self.backgroundColor = kColorOfWhite;
}

#pragma mark setter重写
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _headerPhotoView.frame = self.bounds;
}

#pragma mark dealloc方法重写
- (void)dealloc
{
//    [_mainView release];
//    [_titleLabel release];
    
    [_headerPhotoView release];
    [super dealloc];
}
@end
