//
//  WAYDiscoverViewController.m
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-10-6.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYDiscoverViewController.h"
#import "WAYChannelViewController.h"
@interface WAYDiscoverViewController ()<UIWebViewDelegate>

@property (nonatomic ,retain) UIWebView *webView;
@end

@implementation WAYDiscoverViewController

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
    
    // navigationBar
    self.navigationItem.title = @"发现";
    self.navigationController.navigationBar.tintColor = kColorOfWhite;
    
    UIImageView * backgroundImage = [[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    backgroundImage.image = kDiscoverBackgroundImg;
    [self.view addSubview:backgroundImage];
    
    // webView
   self.webView=[[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)] autorelease];
    _webView.hidden=YES;
    _webView.delegate=self;
    [self webViewSendRequest];
    _webView.scalesPageToFit=YES;
    [self.view addSubview:_webView];
    
    UIBarButtonItem *rightBarButton = [[[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(cancle:)] autorelease];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
#pragma mark webView发送请求
- (void)webViewSendRequest
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://3g.163.com/m/iphone/"]]];
    
    
}

- (void)cancle:(UIBarButtonItem *)sender
{
    [self webViewSendRequest];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webView.hidden=NO;
    _webView.alpha=0;
    [UIView animateWithDuration:0.5 animations:^{
        _webView.alpha=1;
    }];
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

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}
@end
