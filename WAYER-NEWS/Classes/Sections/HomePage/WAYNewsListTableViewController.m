//
//  WAYNewsListTableViewController.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYNewsListTableViewController.h"
#import "WAYBaseNews.h"
#import "WAYNewsListTableViewCell.h"
#import "WAYPhotoSetTableViewCell.h"
#import "WAYScrollPhotoTableViewCell.h"
#import "WAYNetWorkHandle.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+MJRefresh.h"
#import "WAYFileHandle.h"
#import "WAYNewsDetailViewController.h"
#import "WAYHeaderPhotoView.h"
#import "WAYChannel.h"
#import "SDImageCache.h"
@interface WAYNewsListTableViewController ()<UITableViewDataSource,UITableViewDelegate,WAYNetWorkHandleDelegate>

//@property (nonatomic ,retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *allDataArray;//用于存放新闻的数组
@property (nonatomic, retain) NSMutableArray *tempDataArray;


@property (nonatomic ,assign) NSInteger refreshCount;

//@property (nonatomic, retain) WAYHeaderPhotoView *headerPhotoView;
@property (nonatomic, retain) UIImageView *backgroundImageView;

@end

@implementation WAYNewsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _channel.title;
    _refreshCount = 0;
   
    self.allDataArray = [NSMutableArray array];
    self.tempDataArray = [NSMutableArray array];
    
    self.tableView.rowHeight = 900;
    
    
    // 背景图
    self.backgroundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidthOfScreen, [UIScreen mainScreen].bounds.size.height)] autorelease];
    _backgroundImageView.image = kBackGroundImg;
    [self.tableView addSubview:_backgroundImageView];
   
    
    //单步集成刷新（处理刷新事件）
   [self setUpRefresh];
}
#pragma mark 处理上下拉刷新事件
- (void)setUpRefresh
{
    //1.下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    #warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    //上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //设置文字
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上可以刷新";
    self.tableView.headerRefreshingText = @"正在努力加载中，请稍等";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开马上可以刷新";
    self.tableView.footerRefreshingText = @"正在努力加载中，请稍等";
    
}
#pragma mark 下拉刷新实现
- (void)headerRefreshing
{
    NSLog(@"header refresh");
    //1. 添加数据
    //调用代理实现网络请求数据
    // 重置数据
    _refreshCount = 0;

//    if (![WAYNetWorkHandle isConnectionAvailable]) {
//        [self.tableView headerEndRefreshing];
//        return;
//    }

    [_tempDataArray removeAllObjects];

    [WAYNetWorkHandle dataDownLoadWithStringUrl:[WAYFileHandle urlStringWithIndex:_channel.urlIndex refreshCount:_refreshCount] delegate:self];
}

#pragma mark 实现网络请求数据代理方法WAYDataDownLoadDelegate
- (void)WAYDataDownLoad:(WAYNetWorkHandle *)dataDownLoad didFinishLoading:(NSData *)data
{
    if (nil != data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dict in dictionary[dictionary.allKeys[0]]) {
            WAYBaseNews *newList = [[WAYBaseNews new]autorelease];
            [newList setValuesForKeysWithDictionary:dict];
            if (![_tempDataArray containsObject:newList]) {
                [_tempDataArray addObject:newList];
            }
        }
        if (_tempDataArray.count != 0) {
            //        _allDataArray = _tempDataArray;
            [_allDataArray removeAllObjects];
            [_allDataArray addObjectsFromArray:_tempDataArray];
            [self.tableView reloadData];
        }
        
        
        [UIView animateWithDuration:.3 animations:^{
            _backgroundImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [_backgroundImageView removeFromSuperview];
        }];
    }
    
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

#pragma mark 上拉刷新
- (void)footerRefreshing
{
    NSLog(@"footer refresh");
    //1. 添加数据
    //    NSArray * newsArr = @[kNewsUrl(_refreshCount * 20)];
    //2.刷新cell
    //    [WAYDataDownLoad dataDownLoadWithStringUrl:[newsArr objectAtIndex:[self.record intValue]-1] delegate:self];
    
    //刷新次数自增
    _refreshCount ++;

    [WAYNetWorkHandle dataDownLoadWithStringUrl:[WAYFileHandle urlStringWithIndex:_channel.urlIndex refreshCount:_refreshCount ]delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allDataArray count];
}

#pragma mark cell上显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    WAYBaseNews *new = _allDataArray[indexPath.row];
    //    NSLog(@"%d", [new.imgextra count]);
    
    if (indexPath.row == 0) {
        static NSString *Identifiercell2 = @"IdentifierCell2";
        WAYScrollPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifiercell2];
        if (!cell) {
            cell = [[[WAYScrollPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifiercell2] autorelease];
        }
        
        ////////////////////////
        WAYBaseNews *adNews1 = [WAYFileHandle randomAdNews];
//        WAYBaseNews *adNews2 = [WAYFileHandle randomAdNews];
        
        [cell.headerPhotoView clearData];
        [cell.headerPhotoView addNewsArray:@[new, adNews1]];
        cell.headerPhotoView.tapBlock = ^(NSInteger i){
            if (i == 0) {
                [self jumpToDetailView:[NSIndexPath indexPathForRow:0 inSection:0]];
            } else {
                WAYBaseNews *news = cell.headerPhotoView.allDataArray[i];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:news.url]];
            }
        };
        
        [cell.headerPhotoView startScroll];
        
        
        
        ////////////////////////
        
        
        return cell;
    }
    
    if ([new.imgextra count] != 0) {
        
        static NSString *Identifiercell1 = @"IdentifierCell1";
        WAYPhotoSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifiercell1];
        if (!cell) {
            cell = [[[WAYPhotoSetTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifiercell1] autorelease];
        }
        
        cell.backgroundColor = kColorOfWhite;
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",new.title];
        [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:new.imgsrc] placeholderImage:kCellImg];
        [cell.imagextraView sd_setImageWithURL:[NSURL URLWithString:new.imgextra[0][@"imgsrc"]] placeholderImage:kCellImg];
        [cell.imagextraView1 sd_setImageWithURL:[NSURL URLWithString:new.imgextra[1][@"imgsrc"]] placeholderImage:kCellImg];
        return cell;
    } else {
        static NSString *Identifiercell = @"IdentifierCell";
       WAYNewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifiercell];
        
        if (!cell) {
            cell = [[[WAYNewsListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifiercell] autorelease];
        }
        
        cell.backgroundColor = kColorOfWhite;
        [cell.mainimageView sd_setImageWithURL:[NSURL URLWithString:new.imgsrc] placeholderImage:kCellImg];
        cell.titleLabel.text = new.title;
        cell.digestLabel.text = [NSString stringWithFormat:@"%@",new.digest];
        return cell;
    }
    return 0;
}

#pragma mark 点击HeaderPhotoView事件
- (void)selectHeaderPhotoView:(WAYHeaderPhotoView *)sender
{
    [self jumpToDetailView:[NSIndexPath indexPathForItem:0 inSection:0]];
}

#pragma mark 处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取消选中状态
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    
    [self jumpToDetailView:indexPath];
    
}

- (void)jumpToDetailView:(NSIndexPath *)indexPath
{
    // 根据indexPath.row拿到新闻对象
    WAYBaseNews *news = _allDataArray[indexPath.row];
    
    // 跳转到新闻详情
    WAYNewsDetailViewController *detailVC = [WAYNewsDetailViewController new];
    detailVC.news = news;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark 定义返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WAYBaseNews *new = _allDataArray[indexPath.row];
    
    if (indexPath.row == 0) {
        return kHeightOfHeader;
    }
    
    if ([new.imgextra count] != 0) {
        return kHeightOfPhotoSetCell;
    }
    return kHeightOfListCell;
}

#pragma mark dealloc方法重写
- (void)dealloc
{
    [_allDataArray release];
    [_tempDataArray release];
    [_backgroundImageView release];
    [_channel release];
    
    [super dealloc];
}


@end
