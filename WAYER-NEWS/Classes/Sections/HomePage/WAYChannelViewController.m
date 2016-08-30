//
//  WAYChannelViewController.m
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannelViewController.h"
#import "WAYChannelCell.h"
#import "WAYChannelHeader.h"
#import "WAYNewsListTableViewController.h"
#import "WAYHeaderPhotoView.h"
#import "WAYFileHandle.h"
#import "WAYNetWorkHandle.h"
#import "WAYBaseNews.h"
#import "WAYChannelListViewController.h"
#import "WAYNewsDetailViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "WAYChannel.h"
#import "WAYChannelSphereViewController.h"
#import "DBSphereView.h"


@interface WAYChannelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WAYNetWorkHandleDelegate,UIScrollViewDelegate>


@property (nonatomic, retain) NSMutableArray *alldata;

@property (nonatomic, copy)void (^didFinishDownload)(NSString *);

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL isExchanged;

@property (nonatomic, assign) CGPoint centerOfCollectionView;

@end

@implementation WAYChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"WAYER";

    self.isExchanged = NO;
    
    //创建UICollectionViewFlowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置item的内边距大小
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 3, 5, 3);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    
    //页眉设置
    flowLayout.headerReferenceSize = CGSizeMake(kWidthOfScreen, kHeightOfHeader);
    
    //创建UIcollectionView
    self.collectionView = [[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout] autorelease];
    _collectionView.backgroundColor = kColorOfWhite;
    
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    //注册cell
    [_collectionView registerClass:[WAYChannelCell class] forCellWithReuseIdentifier:@"cell"];
    //注册header
    [_collectionView registerClass:[WAYChannelHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //设置数据源
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
    _centerOfCollectionView = _collectionView.center;
    [_collectionView release];
    [flowLayout release];
    //单步集成刷新
    [self setupRefresh];
    
    UIBarButtonItem *exchange = [[UIBarButtonItem alloc] initWithTitle:@"切换首页" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = exchange;

}
#pragma mark 切换按钮
- (void)rightBarButtonAction:(UIBarButtonItem *)sender
{
    // 动画时禁用按钮
    
//    NSString *str = NSStringFromCGRect(_collectionView.frame);
//    NSString *str2 = NSStringFromCGPoint(_collectionView.contentOffset);
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
    if (!_isExchanged) {
        // 要切换到球状云
        
        // 九宫格视图收缩动画
//        [_collectionView setContentOffset:CGPointMake(kHeightOfHeader + 10, 0) animated:YES];
        WAYChannelSphereViewController *sphereVC=[[WAYChannelSphereViewController alloc] init];
        [self addChildViewController:sphereVC];
        [sphereVC release];
        
        [UIView animateWithDuration:.3 animations:^{
            // 视角移动到中心
            _collectionView.contentOffset = CGPointMake(0, kHeightOfHeader + 10);
        } completion:^(BOOL finished) {
            self.view.backgroundColor = [UIColor blackColor];
            [UIView animateWithDuration:.3 animations:^{
                // 收缩
                _collectionView.center = kCenterOfSphereView;
                _collectionView.transform = CGAffineTransformMakeScale(1 / 6.0, 1 / 10.0);
                _collectionView.alpha = .2;
            } completion:^(BOOL finished) {
                // 切换到球状云
                [self.view addSubview:sphereVC.view];
                sphereVC.view.alpha = .2;
                [UIView animateWithDuration:.1 animations:^{
                    sphereVC.view.alpha = 1;
                } completion:^(BOOL finished) {
                    
                }];
                _collectionView.hidden = YES;
            }];
        }];
        
        
        
    } else {
        // 要切换回九宫格
        // 动画
        
        WAYChannelSphereViewController *sphereVC = self.childViewControllers[0];
        DBSphereView *sphereView = sphereVC.sphereView;
        // 球状云归零位动画
        [sphereView goBackToZeroAnimateCompletion:^() {
            // 动画结束后， 开始渐变动画出现九宫格视图
            _collectionView.hidden = NO;
            [self.view bringSubviewToFront:_collectionView];
            [UIView animateWithDuration:.5 animations:^{
                _collectionView.alpha = 1;
                _collectionView.center = _centerOfCollectionView;
                _collectionView.transform = CGAffineTransformMakeScale(1, 1);
                self.view.backgroundColor = kColorOfWhite;
            } completion:^(BOOL finished) {
//                动画完成后移除球状云视图
                [sphereVC.view removeFromSuperview];
                [sphereVC removeFromParentViewController];
            }];
        }];
    }
    
    _isExchanged = !_isExchanged;
}


#pragma mark 单步集成刷新
- (void)setupRefresh
{
    //下拉刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefreshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];

    //设置文字
    self.collectionView.headerPullToRefreshText = @"下拉可以刷新";
    self.collectionView.headerReleaseToRefreshText = @"松开马上可以刷新";
    self.collectionView.headerRefreshingText = @"正在努力加载中，请稍等";
    
}
- (void)headerRefreshing
{
    //1.添加数据
    // 接口
    NSString *urlStr = [WAYFileHandle urlStringWithIndex:0 refreshCount:0];
    
    [WAYNetWorkHandle dataDownLoadWithStringUrl:urlStr delegate:self];
}


#pragma mark 实现网络请求代理方法
- (void)WAYDataDownLoad:(WAYNetWorkHandle *)dataDownLoad didFinishLoading:(NSData *)data
{
    if (nil == data) {
        return;
    }
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.alldata=[NSMutableArray array];
    for (NSDictionary *dic in dict[dict.allKeys[0]]) {
        WAYBaseNews *news=[[WAYBaseNews new]autorelease];
        [news setValuesForKeysWithDictionary:dic];
        [_alldata addObject:news];
    }
    
    
    _didFinishDownload(@"hehe");
    [_collectionView headerEndRefreshing];
    
}



#pragma mark 设置每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(104, 104);
}

#pragma mark 设置有多少个section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 设置每个分组有几行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}
#pragma mark 设置item上显示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WAYChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 15) {
        cell.imageView.image = kCustomHomePageImg;
        return cell;
    }
    WAYChannel *channel = [WAYFileHandle orderedChannelArray][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:channel.image];
    return cell;
    
}
#pragma mark  设置header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    WAYChannelHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    // didFinishDownload Block实现
    self.didFinishDownload = ^(NSString *str){
        
        NSArray *subArray = [_alldata subarrayWithRange:NSMakeRange(0, 3)];
        // 添加广告
        subArray = [subArray arrayByAddingObject:[WAYFileHandle randomAdNews]];
        
        [view.headerPhotoView clearData];
        [view.headerPhotoView addNewsArray:subArray];
        
        view.headerPhotoView.tapBlock = ^(NSInteger i){
            WAYBaseNews *news = view.headerPhotoView.allDataArray[i];
            if ([news.docid hasPrefix:kPrefixOfAdNews]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:news.url]];
            } else {
                WAYNewsDetailViewController *newsDetailVC = [WAYNewsDetailViewController new];
                newsDetailVC.news = news;
                
                [self.navigationController pushViewController:newsDetailVC animated:YES];
                [newsDetailVC release];
            }
        };
        
        [view.headerPhotoView startScroll];
    };
    
    
    
    return view;
}


#pragma mark 处理点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 15) {
        WAYChannelListViewController *channelListVC = [[WAYChannelListViewController alloc]init];
        [self.navigationController pushViewController:channelListVC animated:YES];
        [channelListVC release];
        return;
        
    }
    
    
    WAYNewsListTableViewController *newsTVC = [[WAYNewsListTableViewController alloc] init];
    newsTVC.channel = [WAYFileHandle orderedChannelArray][indexPath.row];
    [self.navigationController pushViewController:newsTVC animated:YES];
    [newsTVC release];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _collectionView.center = _centerOfCollectionView;

}

- (void)viewWillAppear:(BOOL)animated
{
    _collectionView.headerHidden = NO;
    [_collectionView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    _collectionView.headerHidden = YES;
    [_collectionView headerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    Block_release(_didFinishDownload);
    [_alldata release];
    [super dealloc];
}

@end
