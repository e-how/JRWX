//
//  KTPlayerTool.h
//  JRWX
//
//  Created by 张益豪 on 16/5/18.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>


@interface KTPlayerTool : NSObject

@property (nonatomic, assign) CGFloat        loadedProgress;   //缓冲进度
@property (nonatomic, assign) CGFloat        duration;         //视频总时间
@property (nonatomic, assign) NSInteger      current;          //当前播放时间
@property (nonatomic        ) BOOL           stopWhenAppDidEnterBackground;// default is YES
@property (nonatomic, strong) AVPlayer       *player;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic, strong) AVPlayerLayer  *currentPlayerLayer;
@property (nonatomic, strong) AVURLAsset     *videoURLAsset;
@property (nonatomic, assign) BOOL           isPlayingflag;
@property (nonatomic, strong) NSIndexPath*   currentIndexPath;
@property (nonatomic, assign) CGFloat        currentTime;//开始播放的时间


+ (instancetype)sharedInstance;

- (void)playWithUrl:(NSString *)urlString;
- (void)play;
- (void)pause;
- (BOOL)isPlaying;
- (NSString*)getCurrentTime;
- (NSString*)getDuration;
- (CGFloat)currentPlayProgress;
- (CGFloat)getSliderDuration;
- (void)updateCurrentTime:(CGFloat)time;

@end
