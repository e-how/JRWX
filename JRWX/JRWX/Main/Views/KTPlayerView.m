//
//  KTNavView.m
//  TBPlayer
//
//  Created by 张欢欢 on 16/5/12.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "KTPlayerView.h"


@implementation KTPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildVideoNavBar];
    }
    return self;
}
#pragma mark - UI界面
- (void)buildVideoNavBar
{
    //当前时间
    
    if (self.currentTimeLabel == nil) {
        self.currentTimeLabel = [[UILabel alloc] init];
    }
    
    _currentTimeLabel.textColor = [self colorWithHex:0xffffff alpha:1.0];
    _currentTimeLabel.font = [UIFont systemFontOfSize:10.0];
    _currentTimeLabel.frame = CGRectMake(30, 0, 52, 44);
    _currentTimeLabel.textAlignment = NSTextAlignmentRight;
    _currentTimeLabel.text = @"00:00";
    [self addSubview:_currentTimeLabel];
    
    
    
    //总时间
    if (self.totolTimeLabel == nil) {
        self.totolTimeLabel = [[UILabel alloc] init];
    }
    
    _totolTimeLabel.textColor = [self colorWithHex:0xffffff alpha:1.0];
    _totolTimeLabel.font = [UIFont systemFontOfSize:10.0];
    _totolTimeLabel.frame = CGRectMake(SCREEN_WIDTH-52-15, 0, 52, 44);
    _totolTimeLabel.textAlignment = NSTextAlignmentLeft;
    _totolTimeLabel.text = @"00:00";
    [self addSubview:_totolTimeLabel];
    
    
    
    //进度条
    if (self.videoProgressView == nil) {
        self.videoProgressView = [[UIProgressView alloc] init];
    }
    
    _videoProgressView.progressTintColor = [self colorWithHex:0xffffff alpha:1.0];  //填充部分颜色
    _videoProgressView.trackTintColor = [self colorWithHex:0xffffff alpha:0.18];   // 未填充部分颜色
    _videoProgressView.frame = CGRectMake(62+30, 21, SCREEN_WIDTH-124-44, 20);
    _videoProgressView.layer.cornerRadius = 1.5;
    _videoProgressView.layer.masksToBounds = YES;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.5);
    _videoProgressView.transform = transform;
    [self addSubview:_videoProgressView];
    
    
    
    //滑竿
    
    if (self.playSlider == nil) {
        self.playSlider = [[UISlider alloc] init];
    }
    
    _playSlider.frame = CGRectMake(62+30, 0, SCREEN_WIDTH-124-44, 44);
    [_playSlider setThumbImage:[UIImage imageNamed:@"icon_progress"] forState:UIControlStateNormal];
    _playSlider.minimumTrackTintColor = [UIColor clearColor];
    _playSlider.maximumTrackTintColor = [UIColor clearColor];
    [self addSubview:_playSlider];

    
    //暂停按钮
    if (self.stopButton == nil) {
        self.stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    _stopButton.frame = CGRectMake(0, 0, 44, 44);
    
    [_stopButton setTitle:@"播放" forState:UIControlStateNormal];
    [self addSubview:_stopButton];
    
    
    
}

#pragma mark - color
- (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alphaValue];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
