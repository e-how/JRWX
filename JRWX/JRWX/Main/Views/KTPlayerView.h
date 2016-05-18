//
//  KTNavView.h
//  TBPlayer
//
//  Created by 张欢欢 on 16/5/12.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTPlayerView : UIView

@property (nonatomic, strong) UILabel        *currentTimeLabel;
@property (nonatomic, strong) UILabel        *totolTimeLabel;
@property (nonatomic, strong) UIProgressView *videoProgressView;  //缓冲进度条
@property (nonatomic, strong) UISlider       *playSlider;  //滑竿
@property (nonatomic, strong) UIButton       *stopButton;//播放暂停按钮

@end
