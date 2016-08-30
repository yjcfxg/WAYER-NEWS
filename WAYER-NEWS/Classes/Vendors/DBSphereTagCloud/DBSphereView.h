//
//  DBSphereView.h
//  sphereTagCloud
//
//  Created by Xinbao Dong on 14/8/31.
//  Copyright (c) 2014年 Xinbao Dong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DBSphereView : UIView

- (void)setCloudTags:(NSArray *)array;
- (void)timerStart;
- (void)timerStop;

#pragma mark tags回归零位
- (void)goBackToZeroAnimateCompletion:(void (^)())completion;

@end
