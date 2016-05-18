//
//  KTPlayerTool.m
//  JRWX
//
//  Created by 张益豪 on 16/5/18.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "KTPlayerTool.h"

@interface KTPlayerTool()

@property (nonatomic, strong) AVPlayer       *player;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic, strong) AVPlayerLayer  *currentPlayerLayer;
@property (nonatomic, strong) AVURLAsset     *videoURLAsset;
@property (nonatomic, assign) BOOL            isPlayingflag;

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
    }
    return self;
}

//- (void)releasePlayer
//{
//    if (!self.currentPlayerItem) {
//        return;
//    }
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.currentPlayerItem removeObserver:self forKeyPath:@"status"];
//   
//    self.currentPlayerItem = nil;
//}

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
//    [self.currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)play{
    [self.player play];
    self.isPlayingflag = YES;
}
- (void)resume{
    
}
- (void)pause{
    [self.player pause];
    self.isPlayingflag = NO;
}
- (CGFloat)currentPlayProgress{
    return 0.8f;
}
- (BOOL)isPlaying{
    return self.isPlayingflag;
}
- (void)updataProgress{
    self.progress++;
    self.current ++;
    // 不相等的时候才更新，并发通知，否则seek时会继续跳动
    if (self.current != self.duration) {
        if (self.current >  self.duration) {
            self.current = self.duration;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateprogress" object:nil];
    }
    
}

- (void)updateCurrentTime:(CGFloat)time{
    
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    AVPlayerItem *playerItem = (AVPlayerItem *)object;
//    
//    if ([keyPath isEqualToString:@"status"]) {
//        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
//            [self monitoringPlayback:playerItem];// 给播放器添加计时器
//            
//        } else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown) {
////            [self stop];
//        }
//        
//    }
//}

//- (void)monitoringPlayback:(AVPlayerItem *)playerItem{
//    self.duration = playerItem.duration.value / playerItem.duration.timescale; //视频总时间
//#pragma mark 在这播放
//    
//    [self.player play];
//    
//}

@end
