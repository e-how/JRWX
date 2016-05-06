//
//  KTConfigHeader.h
//  kingTrader
//
//  Created by 张益豪 on 15/9/2.
//  Copyright (c) 2015年 张益豪. All rights reserved.
//  配置文件

#ifndef kingTrader_KTConfigHeader_h
#define kingTrader_KTConfigHeader_h

//接口前缀
#define API_URL @"http://api.liangtou.com"
#define DEV_URL @"http://apit.liangtou.com"

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//默认行高
#define kCellHeight 50.0f
//标签栏高度
#define kTabbarHeight 49.0f
//导航栏高度
#define kNavHeight 64.f
// grb
#define KTColor(r, g, b) [UIColor colorWithRed:\
    (r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 设置颜色 转换成rgb
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

//选中行的颜色
#define selectedCellColor [UIColor colorWithRed:0.12f green:0.12f blue:0.12f alpha:1.00f]

// 自定义Log
#ifdef DEBUG
#define KTLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define KTLog(...)
#endif



//解决数组越界
//有返回值
#define SAFE_OBJECT_OF_ARRAY_AT_INDEX(_ARRAY_,_INDEX_) ((_ARRAY_)&&(_INDEX_>=0)&&(_INDEX_<[_ARRAY_ count])?([_ARRAY_ objectAtIndex:_INDEX_]):(nil))

//解决截取字符串的问题
#define SAFE_SUBSTRING_TO_INDEX(_STR_,_INX_) ((_INX_ <= [_STR_ length])? ([_STR_ substringToIndex:_INX_]):(nil))

//解决将空值加入数组造造成的崩溃

#define SAFE_ADD_OBJECT_INTO_ARRAY(_ARRAY_,_OBJ_) ((_OBJ_)? ([_ARRAY_ addObject:_OBJ_]) : (nil))

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

//可以避免循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif
