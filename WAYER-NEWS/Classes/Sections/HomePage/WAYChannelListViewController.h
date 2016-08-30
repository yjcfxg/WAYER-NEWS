//
//  WAYChannelListViewController.h
//  WAYER-NEWS
//
//  Created by 喵了个咪 on 14-9-30.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAYChannelListViewController : UIViewController

//用于存放button的数组
@property (retain, nonatomic) NSMutableArray *itemArray1;
@property (retain, nonatomic) NSMutableArray *itemArray2;
@property (nonatomic ,retain) NSMutableArray *subArr;

// 记录顺序的数组
@property (nonatomic, retain)NSMutableArray *positionArray;

@end
