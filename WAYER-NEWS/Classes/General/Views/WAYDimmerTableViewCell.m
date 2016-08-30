//
//  WAYDimmerTableViewCell.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-10-4.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYDimmerTableViewCell.h"

@implementation WAYDimmerTableViewCell

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
    // 调节亮度滑杆
    self.dimmerSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 0, 280, 44)];
    _dimmerSlider.value = 1;
    _dimmerSlider.minimumValue = .2;
    
    _dimmerSlider.tintColor = kColorOfBlue;
    
    _dimmerSlider.maximumValueImage = kSunImg;
    _dimmerSlider.minimumValueImage = kMoonImg;
    
    [self addSubview:_dimmerSlider];
    [_dimmerSlider release];

}



#pragma mark - 重写
#pragma mark dealloc
- (void)dealloc
{
    [_dimmerSlider release];
    
    [super dealloc];
}


@end
