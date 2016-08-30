//
//  WAYImageScrollView.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYHeaderPhotoView.h"
#import "WAYBaseNews.h"
#import "UIImageView+WebCache.h"

#define kFrameOfScrollView CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - kHeightOfLabel)

#define kFrameOfIcon CGRectMake(5, CGRectGetMaxY(_scrollView.frame), _size.width, _size.height)

#define kFrameOfTitleLabel CGRectMake(CGRectGetMaxX(_iconNextToLabel.frame), CGRectGetMinY(_iconNextToLabel.frame), (self.frame.size.width - CGRectGetMaxX(_iconNextToLabel.frame) - kWidthOfPageControl), _iconNextToLabel.frame.size.height)

#define kFrameOfPageControl CGRectMake(CGRectGetMaxX(_titleLabel.frame), CGRectGetMinY(_titleLabel.frame), kWidthOfPageControl, kHeightOfLabel)

#define kFrameOfImageView(index) CGRectMake(index * self.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)

@interface WAYHeaderPhotoView ()<UIScrollViewDelegate>

@property (nonatomic, assign)CGSize size;


@property (nonatomic, retain)NSTimer *scrollTimer;

@end

@implementation WAYHeaderPhotoView

#pragma mark 指定初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addAllViews];
        
        self.allDataArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark 添加所有视图
- (void)addAllViews
{
    // 1. scrollView
    self.scrollView = [[[UIScrollView alloc] initWithFrame:kFrameOfScrollView] autorelease];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeZero;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    // 2. icon
    self.iconNextToLabel = [[[UIImageView alloc] initWithFrame: kFrameOfIcon] autorelease];
    
    [self addSubview:_iconNextToLabel];
    
    // 3. titleLabel
    self.titleLabel = [[[UILabel alloc] initWithFrame:kFrameOfTitleLabel] autorelease];
    
    [self addSubview:_titleLabel];
    
    // 4. pageControl
    self.pageControl = [[[UIPageControl alloc] initWithFrame: kFrameOfPageControl] autorelease];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.currentPageIndicatorTintColor = kColorOfBlue;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [self addSubview:_pageControl];
    
//    // 5. big button
//    self.button = [UIButton buttonWithType:1];
//    _button.frame = self.bounds;
////    _button.backgroundColor = [UIColor blackColor];
//    [self addSubview:_button];
}


#pragma mark 显示新闻数据
- (void)showIconAndTitleWithNews:(WAYBaseNews *)news
{
    
    // 1. icon
    // 根据是否是广告显示不同图标
    UIImage *icon = [news.docid hasPrefix:kPrefixOfAdNews] ? kADIconImg:kNewsIconImg;
    
    // 按比例缩放，保持高度为规定值
    self.size = icon.size;
    _size.width *= kHeightOfLabel / _size.height;
    _size.height = kHeightOfLabel;
    
    CGRect frame = _iconNextToLabel.frame;
    frame.size = _size;
    
    _iconNextToLabel.frame = frame;
    _iconNextToLabel.image = icon;
    // 更新titleLabel的frame
    _titleLabel.frame = kFrameOfTitleLabel;

    // 2. 显示title
    _titleLabel.text = news.title;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    
    
}



#pragma mark 添加要新的新闻数据
- (void)addNewsArray:(NSArray *)arrayOfNews
{
    [_allDataArray addObjectsFromArray:arrayOfNews];
    [self reloadData];
    [self reloadUI];
}

#pragma mark 重载数据
- (void)reloadData
{
    // 清除之前添加的imageView
    for (UIView *subView in _scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    // 重新添加imageView
    [self addImageViewOnScrollViewAtIndex:0 withNews:[_allDataArray lastObject]];
    for (int i = 0; i < _allDataArray.count; i++) {
        // 拿到news
        WAYBaseNews *news = _allDataArray[i];
        
        [self addImageViewOnScrollViewAtIndex:i+1 withNews:news];
    }
    [self addImageViewOnScrollViewAtIndex:_allDataArray.count+1 withNews:_allDataArray[0]];
}

#pragma mark 清空数据
- (void)clearData
{
    [_allDataArray removeAllObjects];
}

#pragma mark 在指定offsetX创建ImageView并显示图片
- (UIImageView *)addImageViewOnScrollViewAtIndex:(NSInteger)index
                                          withNews:(WAYBaseNews *)news
{
    // 创建添加ImageView
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:kFrameOfImageView(index)] autorelease];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    [imageView addGestureRecognizer:tapGR];
    [tapGR release];
    [_scrollView addSubview:imageView];
    
    // 显示图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:kHeaderViewImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 调整图片比例
        if (image) {
            imageView.image = [self standardImageWithImage:image];
        }
    }];
    return imageView;
}

#pragma mark 将图片剪裁成16:9
- (UIImage *)standardImageWithImage:(UIImage *)image
{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGFloat radio = width / height;
    
    CGFloat standardRadio = 16 / 9.0;
    // 如果尺寸合适，不进行剪裁
    if (1.65 < radio && radio < 1.9)
    {
        return image;
    }
    
    
    if (radio >= 2) {
         standardRadio = 18/8.0;
    }
    
    // 先计算要剪裁的尺寸
    
    if (radio > standardRadio) {
        // 宽过长的情况
        // 计算剪裁后的宽度
        width = height * standardRadio;
        
    } else {
        // 高过长的情况
        // 剪裁后的高度
        height = width / standardRadio;
    }
    
    CGFloat diffOfHeight = size.height - height;
    CGFloat diffOfWidth = size.width - width;
    
    // 进行剪裁
    
    //定义myImageRect，截图的区域
    
    CGRect myImageRect = CGRectMake(diffOfWidth/2, diffOfHeight/2, width, height);
    
    CGImageRef imageRef = image.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    
    
    CGSize newSize = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(newSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, myImageRect, subImageRef);
    
    UIImage *newImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();
    
    
    return newImage;
    
}


#pragma mark tapGR
- (void)tapGRAction:(UITapGestureRecognizer *)sender
{
    NSInteger index = _scrollView.contentOffset.x / self.frame.size.width;
    if (_tapBlock){
        self.tapBlock(index - 1);
    }
}

#pragma mark 重置UI
- (void)reloadUI
{
    // 重置UI
    [self resetFrame];
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * (_allDataArray.count + 2), 0);
    _pageControl.numberOfPages = _allDataArray.count;
    _pageControl.currentPage = 0;
    [self showIconAndTitleWithNews:_allDataArray[0]];
    
    [self resetFrame];
}

#pragma mark 调整各控件frame
- (void)resetFrame
{
    _scrollView.frame = kFrameOfScrollView;
    _iconNextToLabel.frame = kFrameOfIcon;
    _titleLabel.frame = kFrameOfTitleLabel;
    _pageControl.frame = kFrameOfPageControl;
//    _button.frame = self.bounds;
    
    // scrollView subViews
    NSArray *subViewsArr = _scrollView.subviews;
    for (int i = 0; i < subViewsArr.count; i++) {
        UIImageView *imageView = subViewsArr[i];
        imageView.frame = kFrameOfImageView(i);
    }
}




#pragma mark 开始滚动图片
- (void)startScroll
{
    if (_scrollTimer) {
        return;
    }
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(scrollScrollView) userInfo:nil repeats:YES];
}

#pragma mark 滚动scrollView
- (void)scrollScrollView
{
    // 计算offset
    CGPoint newOffset = _scrollView.contentOffset;
    newOffset.x += self.frame.size.width;
    // 进行滚动
    [_scrollView setContentOffset:newOffset animated:YES];
    // 锁定控件
    _scrollView.userInteractionEnabled = NO;
    // 调用方法
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:_scrollView afterDelay:.5];
    [self performSelector:@selector(unlockUserInteraction:) withObject:_scrollView afterDelay:.51];
}

#pragma mark 解锁控件
- (void)unlockUserInteraction:(UIView *)view
{
    view.userInteractionEnabled = YES;
}

#pragma mark 停止滚动图片
- (void)stopScroll
{
    [_scrollTimer invalidate];
}

#pragma mark - UIScrollViewDelegateMethods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算出当前显示的News的index
    int index = scrollView.contentOffset.x / self.frame.size.width;
    
    // 如果向右滑回到了第一张
    if (index == _allDataArray.count + 1) {
        // 跳回到第一张
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        index = 1;
    }
    
    // 如果向左从第一张滑到了最后一张
    if (index == 0 || index > _allDataArray.count + 1) {

        _scrollView.contentOffset = CGPointMake((_allDataArray.count) * self.frame.size.width, 0);
        index = _allDataArray.count;
        
    }
    
    WAYBaseNews *news = _allDataArray[index - 1];
    
    // 更新UI
    
    [self showIconAndTitleWithNews:news];
    _pageControl.currentPage = index - 1;
    [self resetFrame];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_scrollTimer invalidate];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(scrollScrollView) userInfo:nil repeats:YES];
}


#pragma mark - 重写
#pragma mark frame setter
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resetFrame];
}

#pragma mark dealloc
- (void)dealloc
{
    [_scrollView release];
    [_iconNextToLabel release];
    [_titleLabel release];
    [_pageControl release];
    [_allDataArray release];
    [_scrollTimer release];
    Block_release(_tapBlock);
    
    
    [super dealloc];
}


@end
