//
//  WAYNewsListTableViewCell.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYNewsListTableViewCell.h"
#import "WAYBaseNews.h"



@implementation WAYNewsListTableViewCell



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
   
    self.mainimageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kSpaceInCell, kSpaceInCell, kWidthOfImage, kHeightOfListCell - 2*kSpaceInCell)] autorelease];
    [self addSubview:_mainimageView];
    
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_mainimageView.frame) + kSpaceLittleInCell, CGRectGetMinY(_mainimageView.frame), kWidthOfScreen - kSpaceInCell - 2*kSpaceLittleInCell - kWidthOfImage, kHeightOfTitleInCell)] autorelease];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_titleLabel];
    
    
    self.digestLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_mainimageView.frame) - CGRectGetHeight(_titleLabel.frame))] autorelease];
    _digestLabel.numberOfLines = 2;
    _digestLabel.font = [UIFont systemFontOfSize:13];
    _digestLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_digestLabel];
    
    
}


//
//#pragma mark 重写新闻setter方法
//- (void)setNewList:(WAYBaseNews *)newList
//{
//    if (_newList != newList) {
//        [_newList release];
//        _newList=[newList retain];
//    }
//    
////    _titleLabel.text=newList.title;
////    _digestLabel.text=[NSString stringWithFormat:@"%@%ld跟贴",newList.digest,newList.replyCount];
//    
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark dealloc方法的重写
- (void)dealloc
{
    [_mainimageView release];
    [_titleLabel release];
    [_digestLabel release];
    [super dealloc];
}@end
