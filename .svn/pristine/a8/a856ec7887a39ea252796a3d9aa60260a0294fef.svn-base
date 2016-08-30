//
//  WAYAboutViewController.m
//  WAYER-NEWS
//
//  Created by yjcfxg on 14-10-6.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYAboutViewController.h"

@interface WAYAboutViewController ()



@property (nonatomic ,retain) UILabel *textLabel;
@property (nonatomic ,retain) UIImageView *mainView;
@property (nonatomic ,retain) UILabel *deLabel;
@property (nonatomic ,retain) UILabel *teLabel;
@property (nonatomic ,retain) UILabel *contactLabel;
@property (nonatomic ,retain) UILabel *phoneLabel;
@property (nonatomic ,retain) UILabel *phoneNumberLabel;
@property (nonatomic ,retain) UIButton *callButton;
@end

@implementation WAYAboutViewController

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
    self.title=@"关于我们";
//    self.textLabel=[[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _textLabel.font=[UIFont systemFontOfSize:20];
//    [self.view addSubview:_textLabel];
//    _textLabel.text =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"About" ofType:@"txt"]  encoding:NSUTF8StringEncoding error:nil];
    [self addAllViews];
    
 
    
}
- (void)addAllViews
{
    self.view.backgroundColor = kColorOfWhite;
    
    self.mainView=[[[UIImageView alloc] initWithImage:kPlaceHolderImg] autorelease];
    _mainView.frame=CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width-20, 180);
    
    [self.view addSubview:_mainView];
    
    self.textLabel=[[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_mainView.frame)+5, [UIScreen mainScreen].bounds.size.width-10, 130)] autorelease];
    
    _textLabel.numberOfLines=-1;
    _textLabel.text=@"功能简介：WAYER资讯包含海量资讯的新闻服务平台,真实反映每时每刻的新闻热点。您可以阅读新闻事件、人物动态、产品资讯等,每天24小时面向广大网民,快速了解它们的最新进展。";
    [self.view addSubview:_textLabel];
    self.teLabel=[[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_textLabel.frame), CGRectGetMaxY(_textLabel.frame), self.view.frame.size.width-10, 30)] autorelease];
    _teLabel.numberOfLines=-1;
    _teLabel.text=@"开发团队：胡竞尘，琚增辉，徐光";
    [self.view addSubview:_teLabel];
    
    self.deLabel=[[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_teLabel.frame), CGRectGetMaxY(_teLabel.frame)+5, self.view.frame.size.width-10, 30)] autorelease];
    _deLabel.numberOfLines=-1;
    _deLabel.text=@"技术交流群：101046551";
    [self.view addSubview:_deLabel];
    
    self.contactLabel= [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_deLabel.frame), CGRectGetMaxY(_deLabel.frame)+5, self.view.frame.size.width, 30)] autorelease];
    _contactLabel.numberOfLines=-1;
    _contactLabel.text=@"地   址：北京市海淀区金五星商厦";
    [self.view addSubview:_contactLabel];
    
    self.phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_contactLabel.frame), CGRectGetMaxY(_contactLabel.frame)+5, 80, 30)] autorelease];
    _phoneLabel.text=@"联系方式:";
    [self.view addSubview:_phoneLabel];
    
    self.phoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_phoneLabel.frame), CGRectGetMinY(_phoneLabel.frame), 110, 30)] autorelease];
    _phoneNumberLabel.text=@"15038286738";
    [self.view addSubview:_phoneNumberLabel];
    
    self.callButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_callButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    _callButton.frame = CGRectMake(CGRectGetMaxX(_phoneNumberLabel.frame), CGRectGetMinY(_phoneNumberLabel.frame), 80, 30);
    [_callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_callButton];
    
    
}
#pragma mark callButtonAction
- (void)callButtonAction:(UIButton *)sender
{
    NSString *number = _phoneNumberLabel.text;// 此处读入电话号码
    
    // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    
    NSString *num = [NSString stringWithFormat:@"tel:%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    UIWebView * callWebview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:num]]];
    [callWebview release];

//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
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
    [_mainView release];
    [_teLabel release];
    [_textLabel release];
    [_deLabel release];
    [_contactLabel release];
    [super dealloc];
}
@end
