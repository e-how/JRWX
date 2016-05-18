//
//  KTPlayerTool.h
//  JRWX
//
//  Created by 张益豪 on 16/5/18.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kTBPlayerStateChangedNotification;
FOUNDATION_EXPORT NSString *const kTBPlayerProgressChangedNotification;
FOUNDATION_EXPORT NSString *const kTBPlayerLoadProgressChangedNotification;

//播放器的几种状态
typedef NS_ENUM(NSInteger, KTPlayerState) {
    KTPlayerStateBuffering = 1,
    KTPlayerStatePlaying   = 2,
    KTPlayerStateStopped   = 3,
    KTPlayerStatePause     = 4
};

@interface KTPlayerTool : NSObject

@property (nonatomic, readonly) KTPlayerState state;
@property (nonatomic, assign) CGFloat       loadedProgress;   //缓冲进度
@property (nonatomic, assign) CGFloat       duration;         //视频总时间
@property (nonatomic, assign) CGFloat       current;          //当前播放时间
@property (nonatomic, assign) CGFloat       progress;         //播放进度 0~1
@property (nonatomic        ) BOOL          stopWhenAppDidEnterBackground;// default is YES

@property (nonatomic, assign) NSIndexPath*    currentIndexPath;

@property (nonatomic, assign) CGFloat      currentTime;//开始播放的时间


+ (instancetype)sharedInstance;

- (void)playWithUrl:(NSString *)urlString;
//- (void)seekToTime:(CGFloat)seconds;
- (void)resume;
- (void)pause;
- (CGFloat)currentPlayProgress;
- (void)updateCurrentTime:(CGFloat)time;
- (BOOL)isPlaying;
- (void)play;
@end
