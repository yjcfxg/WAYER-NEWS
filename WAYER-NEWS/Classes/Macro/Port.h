//
//  Port.h
//  WAYER-NEWS
//
//  Created by JC_Hu on 14-9-25.
//  Copyright (c) 2014年 WAYER. All rights reserved.
//

#ifndef WAYER_NEWS_Port_h
#define WAYER_NEWS_Port_h

// 新闻详情接口 docid为新闻类的一个属性，通过它可以拼接出对应接口
#define URL_OF_DETAIL(docid) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html", docid]


// 0
//新闻类接口 , 加载的接口只是改变%ld的地方 如果是刷新的话那么接口是把%ld换成0 如果是想加载更多的话把%ld换成20,40,60........
#define kNewsUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1295501906343/%ld-20.html",refreshCount * 20]

// 1
//娱乐类接口
#define kEntertainmentUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348648517839/%ld-20.html",refreshCount * 20]


// 2
//财经类接口
#define kFianceUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348648756099/%ld-20.html",refreshCount * 20]

// 3
//体育类接口
#define kSportsUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348649079062/%ld-20.html",refreshCount * 20]

// 4
//科技类接口
#define kTechnologyUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348649580692/%ld-20.html",refreshCount * 20]

// 5
//汽车类接口
#define kCarUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348654060988/%ld-20.html",refreshCount * 20]

// 6
//军事类接口
#define kMilitaryUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348648141035/%ld-20.html",refreshCount * 20]

// 7
//历史类接口
#define kHistoryUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1368497029546/%ld-20.html",refreshCount * 20]

// 8
//时尚类接口
#define kFashionUrl(refreshCount) [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348650593803/%ld-20.html",refreshCount * 20]

/**********************************************************************************************/


// 9
//NBA接口
#define kNBAUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348649145984/%ld-20.html",refreshCount * 20]

// 10
//国际足球的接口
#define kInternationalFootballUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348649176279/%ld-20.html",refreshCount * 20]

// 11
//中国足球的接口
#define kChinaFootballUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348649503389/%ld-20.html",refreshCount * 20]

// 12
//游戏的接口
#define kGameUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348654151579/%ld-20.html",refreshCount * 20]

// 13
//旅游接口
#define kTravelUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1348654204705/%ld-20.html",refreshCount * 20]

// 14
//移动互联的接口
#define kMobileInternetUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1351233117091/%ld-20.html",refreshCount * 20]


// 15
//轻松一刻的接口
#define kRelaxedTimeUrl(refreshCount) [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/headline/T1350383429665/%ld-20.html",refreshCount * 20]



#endif
