//
//  KTPlayerTool.m
//  JRWX
//
//  Created by 张益豪 on 16/5/18.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "KTPlayerTool.h"

@interface KTPlayerTool()

@end

@implementation KTPlayerTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static KTPlayerTool* instance;
    dispatch_once(&onceToken, ^{
        
        instance = [[KTPlayerTool alloc] init];

    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc] init];
        self.isPlayingflag = NO;
        self.currentIndexPath = nil;
        self.current = 0;
    }
    return self;
}

- (void)playWithUrl:(NSString *)urlString{
    
    [self.player pause];
    
    self.videoURLAsset             = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:urlString ] options:nil];

    self.currentPlayerItem          = [AVPlayerItem playerItemWithAsset:_videoURLAsset];
    
    if (!self.player) {
        self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
    } else {
        [self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
    }
    [self.player play];
    
    self.isPlayingflag = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updataProgress) userInfo:nil repeats:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playbackFinished:)name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

- (void)play{
    [self.player play];
    self.isPlayingflag = YES;
}

- (void)pause{
    [self.player pause];
    self.isPlayingflag = NO;
}

- (void)playbackFinished:(NSNotification*)notice{
    
    [self.player seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        
        [self pause];
        [self updataProgress];

    }];
}

- (BOOL)isPlaying{
    return self.isPlayingflag;
}

- (void)updataProgress{

    self.current ++;
    // 不相等的时候才更新，并发通知，否则seek时会继续跳动
    if (self.current != self.duration) {
        if (self.current >  self.duration) {
            self.current = self.duration;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateprogress" object:nil];
    }else if(self.current+0.5 >= self.duration){//完成
        [self updateCurrentTime:0.f];
        [self pause];
    }
    
}

- (void)updateCurrentTime:(CGFloat)time{
    
    [self.player pause];
//    self.current = time;
    [self updataProgress];

    [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        
        [self play];
        
    }];
}

- (NSString*)getCurrentTime{
    
    CMTime currentTime = self.currentPlayerItem.currentTime;
    CGFloat current = CMTimeGetSeconds(currentTime);

    return [NSString stringWithFormat:@"%d",(int)current];
}

- (NSString*)getDuration{
    
    CMTime duration = self.currentPlayerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    
    return [NSString stringWithFormat:@"%d",(int)totalDuration];
}

- (CGFloat)currentPlayProgress{
    CGFloat current = CMTimeGetSeconds(self.currentPlayerItem.currentTime);
    if (isnan(current)) {
        return 0.01f;
    }return current;
    
}

- (CGFloat)getSliderDuration{
   CGFloat duration = CMTimeGetSeconds(self.currentPlayerItem.duration);
    if (isnan(duration)) {
        return 0.1f;
    }return duration;
}


@end
