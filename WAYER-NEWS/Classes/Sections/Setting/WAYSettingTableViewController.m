//
//  WAYSettingTableViewController.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYSettingTableViewController.h"
#import <StoreKit/StoreKit.h>
#import "WAYAppDelegate.h"
#import "WAYFileHandle.h"
#import "WAYDimmerTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "WAYAboutViewController.h"
#import "WAYWeixinShareHandle.h"
#import "WAYShareViewController.h"

@interface WAYSettingTableViewController ()<UIAlertViewDelegate, SKStoreProductViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic ,retain)NSMutableArray *allSettingData;
@property (nonatomic, assign)__block CGFloat tmpSize;
@property (nonatomic, assign)__block BOOL isGoningToJump;

@property (nonatomic, retain)WAYShareViewController *shareVC;
@property (nonatomic, retain)UIWindow *window;

@end

@implementation WAYSettingTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *tmpDataArray = [NSMutableArray arrayWithObjects:@"清除缓存", nil];
    self.allSettingData = [NSMutableArray arrayWithObjects:
                           @[@"亮度"],
                           @[@"iCloud同步"],
                           tmpDataArray,
                           @[@"去评分",@"推荐给好友"],
                           @[@"关于我们",@"意见反馈"], nil]
    ;
    
    self.view.backgroundColor = kColorOfWhite;
    self.navigationItem.title = @"设置";
    
    // 分享视图控制器
    self.shareVC = [WAYShareViewController new];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    _window.hidden = YES;
    [_window addSubview:_shareVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _allSettingData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_allSettingData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0){
        // 调节亮度
        // 重用cell
        NSString *cellID = @"dimmerCellID";
        WAYDimmerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[WAYDimmerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID]autorelease];
        }
        
        // 设置cell
        [cell.dimmerSlider addTarget:self action:@selector(dimmerSliderAction:) forControlEvents:UIControlEventValueChanged];
        return cell;
        
    }else {
        static NSString *cellIdentifier=@"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        NSString *imgName= [NSString stringWithFormat:@"%ld-%ld.png",indexPath.section,(long)indexPath.row];
        cell.imageView.image=[UIImage imageNamed:imgName];
        cell.textLabel.text=_allSettingData[indexPath.section][indexPath.row];
        
        return cell;
    }
}



#pragma mark 调节亮度滑杆触发事件
- (void)dimmerSliderAction:(UISlider *)sender
{
//    CGFloat alpha = 1 - sender.value;
    WAYAppDelegate *myAppDelegate = [UIApplication sharedApplication].delegate;
    myAppDelegate.window.alpha = sender.value;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"亮度";
    }
    
    if (section == 1) {
        return @"同步";
    }
    
    return nil;
}



#pragma mark - 处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    NSLog(@"row:%ld, section:%ld", indexPath.row, indexPath.section);
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        // 点击了去评分button
        
        
        //ios6.0之前跳转appStore评分
        //        NSString *str = [NSString stringWithFormat:
        //                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
        //                         m_appleID];
        //        NSString *str=@"https://appsto.re/cn/S8gTy.i";
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
        // 提示请等待
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"数据请求中...." message:@"请等待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        alert.tag = 1001;
        [alert show];
        [alert release];
        
        _isGoningToJump = YES;
        
        // Initialize Product View Controller
        SKStoreProductViewController *storeProductViewController = [[[SKStoreProductViewController alloc] init]autorelease];
        // Configure View Controller
        [storeProductViewController setDelegate:self];
        [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"930027626"} completionBlock:^(BOOL result, NSError *error) {
            
            // alertView消失
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            
            if (error) {
                NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
            } else {
                // Present Store Product View Controller
                if (_isGoningToJump) {
                    
                    [self presentViewController:storeProductViewController animated:YES completion:nil];
                }
            }
            
        }];
        
    }
    
    
    if (indexPath.section == 3 && indexPath.row ==1) {
        // 推荐给好友分享
        [_shareVC show];
        
    }
//    if (indexPath.row == 6) {
//        NSString *title = @"title";
//        float latitude = 35.4634;
//        float longitude = 9.43425;
//        int zoom = 13;
//        NSString *stringURL = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@@%1.6f,%1.6f&z=%d", title, latitude, longitude, zoom];
//        NSURL *url = [NSURL URLWithString:stringURL];
//        [[UIApplication sharedApplication] openURL:url];
//    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        WAYAboutViewController *aboutVC=[[WAYAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
        [aboutVC release];
    }

    if (indexPath.section == 4 && indexPath.row == 1) {
        BOOL canSendMail=[MFMailComposeViewController canSendMail];
        if (canSendMail) {
            //创建邮件视图控制器
            MFMailComposeViewController * picker= [[MFMailComposeViewController alloc] init];
            picker.navigationBar.tintColor = kColorOfWhite;
            //设置主题
            [picker setSubject:@"意见反馈"];
            //设置发送对象
            [picker setToRecipients:[NSArray arrayWithObject:@"yjcfxg@163.com"]];
            //设置抄送对象
            [picker setCcRecipients:[NSArray arrayWithObject:@"991003391@qq.com"]];
            //设置内容
            [picker setMessageBody:@"亲，好玩吗？开心吗？😄🍎" isHTML:YES];
            //设置代理
            [picker setMailComposeDelegate:self];
            [self presentViewController:picker animated:YES completion:nil];
//            [self dismissViewControllerAnimated:YES completion:^{
//                
//            }];
            [picker release];
        }
    }


    if (indexPath.section == 2 && indexPath.row == 0) {

        // 点击了清空缓存button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，您确定要清空缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1000;
        [alert show];
        [alert release];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"该功能还未开放" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}
#pragma mark - 实现MFMailComposeViewControllerDelegate 方法

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            NSLog(@"result:canceled");
            break;
        }
        case MFMailComposeResultSent:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"邮件发送成功！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            [alert release];
            break;
        }
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"邮件发送失败！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            [alert release];
            break;
        }
        case MFMailComposeResultSaved:
        {
            NSLog(@"result:save");
            break;
        }
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 实现SKStoreProductViewController代理方法
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - 实现UIAlertViewDelegate代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        // 清除缓存提示alertView
        if (buttonIndex == 1) {
            
            [self clearTmp];
        }
        return;
    }
    
    if (alertView.tag == 1001) {
        // 去评分 提示等待 alertView
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        _isGoningToJump = NO;
    }
    
            
}

#pragma 清理缓存
- (void)clearTmp
{
    CGFloat sizeDidCleaned = [WAYFileHandle checkTmpSize];
    
    [WAYFileHandle cleanCachePath];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"真棒" message:[NSString stringWithFormat:@"您清理了 %@的缓存", [self convertTmpSizeString: sizeDidCleaned]] delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshUI];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });

}

#pragma mark 更新UI
- (void)refreshUI
{
    _tmpSize = [WAYFileHandle checkTmpSize];
    _allSettingData[2][0] = [NSString stringWithFormat:@"清理缓存  (%@)",[self convertTmpSizeString:_tmpSize]];
    [self.tableView reloadData];
}



#pragma mark 转换缓存大小字符串
- (NSString *)convertTmpSizeString: (CGFloat)tmpSize
{
    return tmpSize >= 1 ? [NSString stringWithFormat:@"%.2fM",tmpSize] : [NSString stringWithFormat:@"%.2fK",tmpSize * 1024];
}

#pragma mark 视图将出现时
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshUI];
}

- (void)dealloc
{
    [_shareVC release];
    [_allSettingData release];
//    [_window release];
    [super dealloc];
}

@end
