//
//  WAYShareSubView.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-10-15.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYShareSubView.h"

#define kSpaceBetweenButtons 43
#define kSpaceLine 7
#define kSpaceLeftOfButtons 25
#define kSpaceTopOfButtons 35

#define kWidthOfButtons 60
#define kHeightOfButtons 90

#define kHeightOfCancelButton 46

@implementation WAYShareSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.allButtonArray = [NSMutableArray array];
        [self addAllViews];
        
    }
    return self;
}

#pragma mark 添加所有视图
- (void)addAllViews
{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(kSpaceNormal, self.bounds.size.height - kHeightOfCancelButton - kSpaceLittle, [UIScreen mainScreen].bounds.size.width - 2*kSpaceNormal, kHeightOfCancelButton);
    cancelButton.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:cancelButton];
    [_allButtonArray addObject:cancelButton];
}

#pragma mark 设置按钮数量方法
- (void)setButtonNumber:(NSInteger)number
{
    for (int i = 0; i < number; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        // 计算列
        int n = i%3;
        // 计算行
        int m = n/3;
        
        button.frame = CGRectMake(kSpaceLeftOfButtons + n*kWidthOfButtons + n*kSpaceBetweenButtons, kSpaceTopOfButtons + m*kWidthOfButtons + m*kSpaceLine, kWidthOfButtons, kHeightOfButtons);
//        button.backgroundColor = [UIColor colorWithRed:(arc4random() % 256 / 255.0) green:(arc4random() % 256 / 255.0) blue:(arc4random() % 256 / 255.0) alpha:1.0];
        [self addSubview:button];
        [_allButtonArray addObject:button];
    }
    
    
}



#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_allButtonArray release];
    
    [super dealloc];
}

@end
