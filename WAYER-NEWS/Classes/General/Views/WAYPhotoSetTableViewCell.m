//
//  WAYPhotoSetTableViewCell.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-26.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYPhotoSetTableViewCell.h"
#import "WAYBaseNews.h"

@implementation WAYPhotoSetTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addAllViews];
    }
    return self;
}
#pragma mark 添加所有视图
- (void)addAllViews
{
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kSpaceInCell, kSpaceLittleInCell, kWidthOfScreen - 2*kSpaceLittleInCell, kHeightOfTitleInCell)]autorelease];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines= 1;
    [self addSubview:_titleLabel];
    
    self.mainImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame)+kSpaceInCell, kWidthOfImageInPhotoSet, kHeightOfImageInPhotoSet)]autorelease];
    [self addSubview:_mainImageView];
    
    
    self.imagextraView = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_mainImageView.frame)+5, CGRectGetMinY(_mainImageView.frame), kWidthOfImageInPhotoSet, kHeightOfImageInPhotoSet)]autorelease];
    [self addSubview:_imagextraView];
    
    self.imagextraView1 = [[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imagextraView.frame)+5, CGRectGetMinY(_imagextraView.frame), kWidthOfImageInPhotoSet, kHeightOfImageInPhotoSet)]autorelease];
    [self addSubview:_imagextraView1];
    
}

#pragma mark 新闻setter方法重写
- (void)setNew:(WAYBaseNews *)news
{
    if (_news != news) {
        [_news release];
        _news = [news retain];
    }
    
    
    _titleLabel.text=[NSString stringWithFormat:@"%@%ld跟贴",news.title,news.replyCount];
    

    
}
- (void)awakeFromNib
{
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
