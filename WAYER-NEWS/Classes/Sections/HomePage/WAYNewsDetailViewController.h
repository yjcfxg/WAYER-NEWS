//
//  WAYNewsDetailViewController.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WAYBaseNews;
@class WAYDetailNews;
@interface WAYNewsDetailViewController : UIViewController

@property (nonatomic, retain) WAYBaseNews *news;
@property (nonatomic, retain) WAYDetailNews *detailNews;
//@property (nonatomic, copy) NSString *docid;

@end
