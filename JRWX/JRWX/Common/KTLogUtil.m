//
//  KTLogUtil.m
//  JRWX
//
//  Created by 张益豪 on 16/5/5.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "KTLogUtil.h"

@implementation KTLogUtil

+(void)installLogUtil{
    // Add File Log
    DDFileLogger* fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    KTLog(@"LogDir:  %@", fileLogger.logFileManager.logsDirectory);
    // Add Apple System Log
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    // Enable XcodeColors
    setenv("XcodeColors", "YES", 0);
    // Add Standard lumberjack initialization
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    // Set colors for levels
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagDebug];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor lightGrayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    // Set format
    KTLogFormatter* logFormatter = [[KTLogFormatter alloc]init];
    [fileLogger setLogFormatter:logFormatter];
    [[DDASLLogger sharedInstance] setLogFormatter:logFormatter];
    [[DDTTYLogger sharedInstance] setLogFormatter:logFormatter];
}

@end

#import <libkern/OSAtomic.h>
#import "DDLegacyMacros.h"

static NSString *const LogFormatterCalendarKey = @"LogFormatterCalendarKey";
static const NSCalendarUnit LogFormatterCalendarUnit = (NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);

@interface KTLogFormatter () {
    int32_t atomicLoggerCount;
    NSCalendar *logCalendar;
}

@end

@implementation KTLogFormatter

-(instancetype)init{
    self = [super init];
    if (self) {
        _showYear = NO;
        _showMonth = YES;
        _showDay  = YES;
        _showHour = YES;
        _showMinute = YES;
        _showSecond = YES;
    }
    return self;
}

/**
 *  获取Calendar
 *
 *  @return
 */
-(NSCalendar *)_logCalendar{
    int32_t loggerCount = OSAtomicAdd32(0, &atomicLoggerCount);
    
    if (loggerCount <=1) {//如果是单个线程
        if (!logCalendar) {
            logCalendar = [NSCalendar autoupdatingCurrentCalendar];
        }
        return logCalendar;
    }else{//如果是多线程
        NSMutableDictionary* dic = [[NSThread currentThread] threadDictionary];
        NSCalendar* calendar = [dic objectForKey:LogFormatterCalendarKey];
        if (!calendar) {
            calendar = [NSCalendar autoupdatingCurrentCalendar];
            [dic setObject:calendar forKey:LogFormatterCalendarKey];
        }
        return calendar;
    }
}

/**
 *  根据flag获取level字符串
 *
 *  @param flag log标志
 *
 *  @return level字符串
 */
-(NSString *)_logLevelWithFlag:(DDLogFlag)flag{
    if (flag == DDLogFlagError){
        return @"Error";
    }else if (flag == DDLogFlagInfo){
        return @"Info";
    }else if (flag == DDLogFlagDebug){
        return @"Debug";
    }else if (flag == DDLogFlagWarning){
        return @"Warn";
    }else if (flag == DDLogFlagVerbose){
        return @"Verbose";
    }else{
        return @"Unknow";
    }
}

/**
 *  协议方法
 */
-(NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    NSDateComponents* components = [[self _logCalendar] components:LogFormatterCalendarUnit fromDate:logMessage->_timestamp];
    
    NSMutableString* logMsg = [NSMutableString stringWithFormat:@"[%@] ",[self _logLevelWithFlag:logMessage->_flag]];
    if (_showYear) {
        [logMsg appendString:[NSString stringWithFormat:@"%04ld-",(long)components.year]];
    }
    if (_showMonth) {
        [logMsg appendString:[NSString stringWithFormat:@"%02ld-",(long)components.month]];
    }
    if (_showDay) {
        [logMsg appendString:[NSString stringWithFormat:@"%02ld ",(long)components.day]];
    }
    if (_showHour) {
        [logMsg appendString:[NSString stringWithFormat:@"%02ld:",(long)components.hour]];
    }
    if (_showMinute) {
        [logMsg appendString:[NSString stringWithFormat:@"%02ld:",(long)components.minute]];
    }
    if (_showSecond) {
        [logMsg appendString:[NSString stringWithFormat:@"%02ld ",(long)components.second]];
    }
    
    [logMsg appendString:[NSString stringWithFormat:@"(%@:%lu)%@:%@",[logMessage->_file lastPathComponent],(unsigned long)logMessage->_line,logMessage->_function,logMessage->_message]];
    return logMsg;
}

/**
 *  协议方法
 */
- (void)didAddToLogger:(id <DDLogger> __unused)logger
{
    OSAtomicIncrement32(&atomicLoggerCount);
}

/**
 *  协议方法
 */
- (void)willRemoveFromLogger:(id <DDLogger> __unused)logger
{
    OSAtomicDecrement32(&atomicLoggerCount);
}

@end

