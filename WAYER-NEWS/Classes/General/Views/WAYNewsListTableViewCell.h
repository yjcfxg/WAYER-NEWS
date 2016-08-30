//
//  WAYNewsListTableViewCell.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WAYBaseNews;
@interface WAYNewsListTableViewCell : UITableViewCell

#pragma mark 声明属性

@property (nonatomic ,retain) UIImageView *mainimageView;
@property (nonatomic ,retain) UILabel *titleLabel;
@property (nonatomic ,retain) UILabel *digestLabel;

#pragma mark 声明新闻
//@property (nonatomic ,retain) WAYBaseNews *newList;
@end
