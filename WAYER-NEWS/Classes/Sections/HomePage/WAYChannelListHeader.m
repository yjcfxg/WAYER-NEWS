//
//  WAYChannelListHeader.m
//  WAYER-NEWS
//
//  Created by 喵了个咪 on 14-9-30.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannelListHeader.h"

@implementation WAYChannelListHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.label = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))]autorelease];
        _label.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        //_label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    
    [_label release];
    [super dealloc];
}

@end
