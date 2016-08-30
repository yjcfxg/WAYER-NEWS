//
//  WAYReadingListTableViewController.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYReadingListTableViewController.h"
#import "WAYFileHandle.h"
#import "WAYNewsListTableViewCell.h"
#import "WAYPhotoSetTableViewCell.h"
#import "WAYBaseNews.h"
#import "UIImageView+WebCache.h"
#import "WAYNewsDetailViewController.h"
#import "WAYDBHandle.h"
@interface WAYReadingListTableViewController ()<UIAlertViewDelegate>

@end

@implementation WAYReadingListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"离线阅读";
    
    self.view.backgroundColor = kColorOfWhite;
    
    //从数据库里拿出数据
    [WAYFileHandle setupNewsDataSource];
    
    UIBarButtonItem *cleanBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(cleanBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = cleanBarButtonItem;
    [cleanBarButtonItem release];
}
#pragma mark 视图将要显示的时候刷新数据
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - 清空列表
- (void)cleanBarButtonItemAction:(UIBarButtonItem *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，您确定要清空列表吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

#pragma mark - UIAlertViewDelegate Method 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[WAYDBHandle shareInstance] deleteAllNews];
        [[WAYDBHandle shareInstance] deleteAllNewsDetail];
        [self.tableView reloadData];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [WAYFileHandle countOfNews];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WAYBaseNews *news=[WAYFileHandle newsForRow:indexPath.row];
    
//    if (news == nil) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 180, 200, 30)];
//        label.text = @"亲，收藏列表为空，赶紧抢沙发收藏吧！";
//        [self.view addSubview:label];
//        [label release];
//    }
    if ([news.imgextra count] == 0) {
        
        static NSString *cellIdentifier=@"cellIdentifier";
        WAYNewsListTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell1) {
            cell1=[[[WAYNewsListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
        }
        
        cell1.backgroundColor = kColorOfWhite;
        [cell1.mainimageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:kCellImg];
        cell1.titleLabel.text=news.title;
        cell1.digestLabel.text=[NSString stringWithFormat:@"%@",news.digest];
        
        return cell1;
        
    }
  
    
    static NSString *cellIdentifier1=@"cellIdentifier";
    WAYPhotoSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (!cell) {
        cell = [[[WAYPhotoSetTableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1] autorelease];
    }
    
    cell.backgroundColor = kColorOfWhite;
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:kCellImg];
    cell.titleLabel.text=news.title;
    [cell.imagextraView sd_setImageWithURL:[NSURL URLWithString:news.imgextra[0][@"imgsrc"]] placeholderImage:kCellImg];
    [cell.imagextraView1 sd_setImageWithURL:[NSURL URLWithString:news.imgextra[1][@"imgsrc"]] placeholderImage:kCellImg];
    
    return cell;
    
}
#pragma mark  实现删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据源
        [WAYFileHandle deleteNewsForRow:indexPath.row];
        [WAYFileHandle deleteDetailNewsForRow:indexPath.row];
        //更新页面
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark -实现处理点击事件
#pragma mark 处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转详情页面
    WAYNewsDetailViewController *detailVC=[[WAYNewsDetailViewController alloc] init];
    detailVC.news=[WAYFileHandle newsForRow:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WAYBaseNews *new = [WAYFileHandle newsForRow:indexPath.row];
    
    
    if ([new.imgextra count] != 0) {
        return kHeightOfPhotoSetCell;
    }
    return kHeightOfListCell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
