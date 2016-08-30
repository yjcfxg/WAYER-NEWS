//
//  WAYChannelListViewController.m
//  WAYER-NEWS
//
//  Created by 喵了个咪 on 14-9-30.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#import "WAYChannelListViewController.h"
 //#import "WAYChannelList.h"
#import "WAYNewsListTableViewController.h"
#import "WAYFileHandle.h"
#import "WAYChannel.h"

#define kWidth  [[UIScreen mainScreen] bounds].size.width
#define kHeight   [[UIScreen mainScreen] bounds].size.height
#define kRightButton_width  30    //右侧button的宽度
#define kRightButton_Height  35
#define kLabel_width   kWidth-kRightButton_width  //label的宽度
//lable下面的button的宽度
#define kButton_left 20     //距离左侧的距离
#define kButton_margin 16
#define kbutton_lineMargin  12  //上下行的间距
//#define kButton_width  (kWidth-2*kButton_left-3*kButton_margin)/3
#define kButton_width 74
#define kButton_height 74
//#define kView_width  [[UIScreen mainScreen] bounds].size.width/3
//button下面提示添加的  label的 y值
#define kAddLabel_top 300

#define kBtnBaseTag 1000

//定义动画时间
#define  Duration 0.2

@interface WAYChannelListViewController ()
{
    BOOL m_bTransform;
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
//    UIImageView *tagImgView;
    BOOL buBool;
    
    
    NSInteger btnIndex;
   
}

@property (nonatomic ,retain)NSMutableArray *dataArray;


@end

@implementation WAYChannelListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
 //   [self createData];
    
    buBool = NO;
    
    //初始化
    self.itemArray1 = [NSMutableArray array];
    self.itemArray2 = [NSMutableArray array];
    self.subArr = [NSMutableArray array];
    self.view.backgroundColor = kColorOfWhite;
    
    
    //创建一个label
   
    
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, kWidth, kRightButton_Height - 15)];
    aLabel.text = @"长按按钮进行移动；双击屏幕停止编辑";
    aLabel.font = [UIFont systemFontOfSize:12.f];
    aLabel.textColor = [UIColor whiteColor];
    aLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
    aLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:aLabel];
    [aLabel release];
    
    
    //button
    self.dataArray = [NSMutableArray arrayWithArray:[WAYFileHandle orderedChannelArray]];
    int x = kButton_left;
    int y = kRightButton_Height + 50;
    for (int i = 0; i<[_dataArray count]; i++)
    {
        UIView *subView =[[[UIView alloc] initWithFrame:CGRectMake(x, y, kButton_width, kButton_height)] autorelease];
            x += kButton_width + kButton_margin;
        if (x > 240) {
            x = kButton_left;
            y += kButton_height + kbutton_lineMargin;
        }
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(10, 10, kButton_width, kButton_height);
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.tintColor = [UIColor blackColor];
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 8;
      //  button.tag = i;
        
        
        // 显示对应频道信息
        WAYChannel *channel = _dataArray[i];
        subView.tag = channel.urlIndex + kBtnBaseTag;
        [button setBackgroundImage:[UIImage imageNamed:channel.image] forState:UIControlStateNormal];
        
        
        //给button添加点击事件
//        [button addTarget:self action:@selector(newsButtonClick:event:) forControlEvents:UIControlEventTouchUpInside];
        

        
//        tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//        tagImgView.image = kDeleteImg;
//        tagImgView.tag=i+100;
//        [tagImgView setHidden:YES];
//        [subView addSubview:tagImgView];
        [self.subArr addObject:subView];
        [self.view addSubview:subView];
        

        
        
        //给button添加长按手势,用于拖拽
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        [subView addGestureRecognizer:longGesture];
        
        
        //双击手势，停止摇晃
        UITapGestureRecognizer *tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)];
        [tapGestureTel2 setNumberOfTapsRequired:2];
        [tapGestureTel2 setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:tapGestureTel2];
        
        
      
        [subView addSubview:button];
    }

    
    //提示读者添加item，设置一个label
    /*
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kAddLabel_top+20, kWidth, kRightButton_Height)];
    addLabel.text = @"  点击添加";
    addLabel.font = [UIFont systemFontOfSize:13.f];
    addLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [self.view addSubview:addLabel];
    [addLabel release];
    */
    
    //用于添加更多
    /*
    NSArray *tittlesArr = [[NSArray alloc]initWithObjects:@"房产",@"社会",@"电影",@"彩票",@"手机",@"数码",@"网购",@"原创",@"家居",@"读书",@"教育",@"情感",@"军事",nil];
    int a = kButton_left;
    int b = kAddLabel_top+60;
    for (int i = 0; i<12; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(a, b, kButton_width, kButton_height);
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.tintColor = [UIColor blackColor];
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 8;
        button.tag = i;
        [button addTarget:self action:@selector(addNewsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[tittlesArr objectAtIndex:i] forState:UIControlStateNormal];
        a += kButton_width + kButton_margin;
        if (a > 280) {
            a = kButton_left;
            b += kButton_height + kbutton_lineMargin;
        }
        [self.itemArray2 addObject:button];
        [self.view addSubview:button];
        
    }
    [tittlesArr release];
    */
    
    // 记录位置数组
    self.positionArray = [NSMutableArray array];
    NSArray *loadedArray = [WAYFileHandle loadChannelOrder];
    if (loadedArray) {
        [_positionArray addObjectsFromArray: loadedArray];
    } else {
        for (int i = 0; i < _dataArray.count; i++) {
            [_positionArray addObject:[NSNumber numberWithInt:i]];
        }
    }

    // navigationBar
    UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(finishButtonAction:)];
    self.navigationItem.rightBarButtonItem = finishButton;
    [finishButton release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonAction:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
}

#pragma mark 点击完成按钮事件
- (void)finishButtonAction:(UIBarButtonItem *)sender
{
    // 保存改变的顺序
    [WAYFileHandle saveChannelOrder:_positionArray];
    
    // 跳转页面
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 点击取消按钮事件
- (void)cancelButtonAction:(UIBarButtonItem *)sender
{
    // 复原顺序
    
    // 跳转页面
    [self.navigationController popViewControllerAnimated:YES];
}

/*

#pragma mark - button的点击事件
- (void)newsButtonClick:(UIButton *)sender event:(id)event
{
    
    UIButton *btn = (UIButton *)sender;
    [self deleteButton:btn.tag];
    
}

- (void)deleteButton:(NSInteger)index

{
    
//    
//    NSArray *views = self.view.subviews;
//    __block CGRect newframe;
//    for (int i = index; i < [_dataArray count]; i++)
//    {
//        UIView *obj = [views objectAtIndex:i];
//        __block CGRect nextframe = obj.frame;
//        if (i == index)
//        {
//            [obj removeFromSuperview];
//        }
//        else
//        {
//            for (UIView *v in obj.subviews)
//            {
//                if ([v isMemberOfClass:[Button class]])
//                {
//                    v.tag = i - 1;
//                    break;
//                }
//            }
//            [UIView animateWithDuration:0.6 animations:^
//             {
//                 obj.frame = newframe;
//             } completion:^(BOOL finished)
//             {
//             }];
//        }
//        newframe = nextframe;
//    }
//    [_dataArray removeObjectAtIndex:index];
//    
    
}




- (void)addNewsButtonClick:(UIButton *)button
{
    NSLog(@"待续");
    
    
}
*/

#pragma mark 更新初始位置
- (void)updatePositionIndex:(UIView *)btn
{

    NSInteger index = btn.tag - kBtnBaseTag;
    
    btnIndex = [_positionArray indexOfObject:[NSNumber numberWithInteger:index]];
}


#pragma mark 交换位置
- (void)exchangePositionWithBtn:(UIView *)btn
                           view:(UIView *)view
{
    NSInteger viewTag = view.tag - kBtnBaseTag;
    NSInteger viewIndex = [_positionArray indexOfObject:[NSNumber numberWithInteger:viewTag]];
    
    [_positionArray exchangeObjectAtIndex:btnIndex withObjectAtIndex:viewIndex];
    
    for (NSNumber *num in _positionArray) {
        int i = [num intValue];
        
        WAYChannel *channel = [WAYFileHandle defaultChannelArray][i];
        NSLog(@"%ld %@", [_positionArray indexOfObject:num], channel.title);
        
    }
}

#pragma mark - 长按手势  & button的拖拽手势，方法
- (void)longPressed:(UILongPressGestureRecognizer *)sender
{

    
    UIView *btn = (UIView *)sender.view;
    [self.view bringSubviewToFront:btn];
    [self updatePositionIndex:btn];

    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"UIGestureRecognizerStateBegan");
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        [self updatePositionIndex:btn];
        
        if (m_bTransform)
            return;
        
//        for (UIView *view in self.view.subviews)
//        {
//            view.userInteractionEnabled = YES;
//            for (UIView *v in view.subviews)
//            {
//                if ([v isMemberOfClass:[UIImageView class]])
//                    [v setHidden:NO];
//            }
//        }
        m_bTransform = YES;
        [self BeginWobble];
        
        
        
        
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            btn.alpha = 1.0;
        }];
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        NSInteger index = [self indexOfPoint:btn.center withView:btn];
        if (index<0)
        {
            contain = NO;
        }
        else
        {
            UIView *view = _subArr[index];
            [self exchangePositionWithBtn:btn view:view];
            
            [UIView animateWithDuration:Duration animations:^{
                
                CGPoint temp = CGPointZero;
                temp = view.center;
                view.center = originPoint;
//                btn.center = temp;
                originPoint = temp;
                contain = YES;
                
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(Duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            });
        }
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain)
            {
                btn.center = originPoint;
            }
            [self BeginWobble];
        }];
        originPoint = btn.center;
        [self updatePositionIndex:btn];
    }
    
}



- (NSInteger)indexOfPoint:(CGPoint)point withView:(UIView *)btn
{
    for (NSInteger i = 0;i<_subArr.count;i++)
    {
        UIView *view = _subArr[i];
        if (view != btn)
        {
            if (CGRectContainsPoint(view.frame, point))
            {
                return i;
            }
        }
    }
    return -1;
}

#pragma mark 双击手势
-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if(m_bTransform==NO)
        return;
    
//    for (UIView *view in self.subArr)
//    {
////        view.userInteractionEnabled = NO;
//        for (UIView *v in view.subviews)
//        {
//            if ([v isMemberOfClass:[UIImageView class]])
//                [v setHidden:YES];
//        }
//    }
    m_bTransform = NO;
    [self EndWobble];
}

#pragma mark 开始摇晃
-(void)BeginWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in self.subArr)
    { 
        srand([[NSDate date] timeIntervalSince1970]);
        float rand=(float)random();
        CFTimeInterval t=rand*0.0000000001;
        [UIView animateWithDuration:0.1 delay:t options:0  animations:^
         {
             view.transform=CGAffineTransformMakeRotation(-0.05);
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  view.transform=CGAffineTransformMakeRotation(0.05);
              } completion:^(BOOL finished) {}];
         }];
    }
    [pool release];

}


#pragma mark 停止摇晃
-(void)EndWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in self.subArr)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             view.transform=CGAffineTransformIdentity;
//             for (UIView *v in view.subviews)
//             {
//                 if ([v isMemberOfClass:[UIImageView class]])
//                     [v setHidden:YES];
//             }
         } completion:^(BOOL finished) {}];
    }
    [pool release];
}

- (void)viewWillDisappear:(BOOL)animated
{
    m_bTransform = NO;
    [self EndWobble];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc
{
    [_itemArray1 release];
    [_itemArray2 release];
    [_subArr release];
    [_dataArray release];
    [_positionArray release];
    [super dealloc];
}

@end
