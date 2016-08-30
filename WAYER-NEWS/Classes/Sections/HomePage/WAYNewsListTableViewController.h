//
//  WAYNewsListTableViewController.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAYChannel;

@interface WAYNewsListTableViewController : UITableViewController

//接收新闻频道
@property (nonatomic, retain) WAYChannel *channel;
@end
