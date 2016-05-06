//
//  KTLogUtil.h
//  JRWX
//
//  Created by 张益豪 on 16/5/5.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif

@interface KTLogUtil : NSObject

+(void)installLogUtil;

@end

@interface KTLogFormatter : NSObject <DDLogFormatter>

/**
 *  设置是否显示的log信息；
 *  以下信息默认都显示，不想显示的话可以设为NO
 */
@property (nonatomic,assign) BOOL showYear;
@property (nonatomic,assign) BOOL showMonth;
@property (nonatomic,assign) BOOL showDay;
@property (nonatomic,assign) BOOL showHour;
@property (nonatomic,assign) BOOL showMinute;
@property (nonatomic,assign) BOOL showSecond;

@end