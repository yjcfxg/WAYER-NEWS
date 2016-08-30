//
//  WAYImageScrollView.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAYBaseNews;

@interface WAYHeaderPhotoView : UIView

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *iconNextToLabel;

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, retain)NSMutableArray *allDataArray;

@property (nonatomic, copy)void (^tapBlock) (NSInteger);


#pragma mark 添加要显示的新闻数据
- (void)addNewsArray:(NSArray *)arrayOfNews;

#pragma mark 重置UI
- (void)reloadUI;

#pragma mark 调整各控件frame
- (void)resetFrame;

#pragma mark 重载数据
- (void)reloadData;

#pragma mark 清空数据
- (void)clearData;

#pragma mark 开始滚动图片
- (void)startScroll;

#pragma mark 停止滚动图片
- (void)stopScroll;

@end
