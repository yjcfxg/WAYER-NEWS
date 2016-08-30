//
//  WAYChannelSphereViewController.m
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-10-11.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannelSphereViewController.h"
#import "DBSphereView.h"
#import "WAYChannel.h"
#import "WAYFileHandle.h"
#import "WAYNewsListTableViewController.h"

#define kBaseButtonTag 250

@interface WAYChannelSphereViewController ()


@end

@implementation WAYChannelSphereViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    _sphereView.backgroundColor = [UIColor clearColor];
    
    self.sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(kXOfSphereViewFrame, kYOfSphereViewFrame, kWidthOfSphereViewFrame, kWidthOfSphereViewFrame)];
    
    //    NSArray *allDataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Channel-List" ofType:@"plist"]];
    NSArray *allDataArray = [WAYFileHandle defaultChannelArray];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:50];
    for (int i = 0; i < 15; i++) {
        
        WAYChannel *channel = allDataArray[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        //        [button setTitle:[NSString stringWithFormat:@"%@",[allDataArray objectAtIndex:i][@"title"]] forState:UIControlStateNormal];
        button.exclusiveTouch =YES;
        button.frame = CGRectMake(0, 0, 80, 80);
        button.tag = kBaseButtonTag + i;
        [button setBackgroundImage:[UIImage imageNamed:channel.image] forState:UIControlStateNormal];
        //        button.titleLabel.font = [UIFont systemFontOfSize:18];
        //        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:button];
        [_sphereView addSubview:button];
    }
    [_sphereView setCloudTags:array];
    [self.view addSubview:_sphereView];
}

#pragma mark 处理点击事件
- (void)clickButton:(UIButton *)sender
{
    _sphereView.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _sphereView.userInteractionEnabled = YES;
    });
    // 动画效果
    [_sphereView timerStop];
    [UIView animateWithDuration:0.1 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            sender.transform = CGAffineTransformMakeScale(1., 1.0);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
        }];
    }];
    
    // 跳转
    WAYNewsListTableViewController *newListVC = [[WAYNewsListTableViewController alloc] init];
    newListVC.channel = [WAYFileHandle defaultChannelArray][sender.tag - kBaseButtonTag];
    
    // 配合动画效果略微延时推出视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.parentViewController.navigationController pushViewController:newListVC animated:YES];
        [newListVC release];
    });
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
