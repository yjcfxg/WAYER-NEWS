//
//  WAYRootTabBarViewController.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYRootTabBarViewController.h"
#import "WAYChannelViewController.h"
#import "WAYDiscoverViewController.h"
#import "WAYSettingTableViewController.h"
#import "WAYReadingListTableViewController.h"
#define kTabBarItemBaseTag 100

@interface WAYRootTabBarViewController ()

@end

@implementation WAYRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kColorOfWhite;
    
    // 加载子视图控制器
    [self loadAllSubVCs];
    
    // 颜色设置
    self.tabBar.barTintColor = kColorOfWhite;
    self.tabBar.tintColor = kColorOfBlue;
    
}

- (void)loadAllSubVCs
{
    // 1. 首页
    WAYChannelViewController *channelVC = [[[WAYChannelViewController alloc] init] autorelease];
    
    UINavigationController *homePageNC = [[UINavigationController alloc] initWithRootViewController:channelVC];
    
    // 设置导航栏字体颜色
    [[UINavigationBar appearance] setBarTintColor: kColorOfBlue];
    [[UINavigationBar appearance] setTintColor: kColorOfWhite];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           kColorOfWhite, NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0], NSFontAttributeName, nil]];
    
    homePageNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"首页" image:kHomePageImg tag:kTabBarItemBaseTag] autorelease];
    
    // 2. 发现
//    WAYDiscoverViewController *discoverVC=[[WAYDiscoverViewController alloc] init];
//    UINavigationController *discoverNC = [[UINavigationController alloc] initWithRootViewController:discoverVC];
//    [discoverVC release];
//    discoverNC.tabBarItem=[[[UITabBarItem alloc] initWithTitle:@"发现" image:kDiscoverImg tag:kTabBarItemBaseTag+1] autorelease];
    // 3. 阅读
    WAYReadingListTableViewController *readindVC=[[[WAYReadingListTableViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    UINavigationController *readingNC=[[UINavigationController alloc] initWithRootViewController:readindVC];
    readingNC.tabBarItem=[[[UITabBarItem alloc] initWithTitle:@"阅读" image:kReadingImg tag:kTabBarItemBaseTag+1] autorelease];
    
    // 4. 设置
    WAYSettingTableViewController *settingTVC = [[[WAYSettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    UINavigationController *settingNC = [[UINavigationController alloc] initWithRootViewController:settingTVC];

    settingNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"设置" image:kSettingImg tag:kTabBarItemBaseTag + 2] autorelease];

    
    // 添加到TabBarController上
    
    self.viewControllers = @[homePageNC,readingNC, settingNC];
    [homePageNC release], [readingNC release],[settingNC release];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
