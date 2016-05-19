//
//  KTPalyTableViewCell.m
//  JRWX
//
//  Created by 张益豪 on 16/5/18.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "KTPalyTableViewCell.h"
#import "KTPlayerTool.h"
@implementation KTPalyTableViewCell

+ (id)cellWithTable:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString* identifier = @"playCell";
    KTPalyTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[KTPalyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([[KTPlayerTool sharedInstance].currentIndexPath isEqual:indexPath]) {
        [cell setupStatePlayWithCurrentCell:cell];
        
    }else{
        [cell setupStatePauseWithCurrentCell:cell];
    }
    [cell addTarget:cell WithIndexPath:indexPath];
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setModel:(KTPlayModel *)model{
    _model = model;
    self.nameLabel.text = model.playUrl;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.playerView];
    [self.contentView addSubview:self.nameLabel];
}

- (void)setupStatePlayWithCurrentCell:(KTPalyTableViewCell*)cell{
    
    cell.playerView.videoProgressView.progress = [[KTPlayerTool sharedInstance] currentPlayProgress];
    cell.playerView.totolTimeLabel.text = [[KTPlayerTool sharedInstance] getDuration];
    cell.playerView.currentTimeLabel.text = [[KTPlayerTool sharedInstance]getCurrentTime];
    cell.playerView.playSlider.minimumValue = 0.0;
    cell.playerView.playSlider.maximumValue = [[KTPlayerTool sharedInstance] getSliderDuration];
    [cell.playerView.playSlider setValue:[[KTPlayerTool sharedInstance] currentPlayProgress] animated:YES];
    
    if ([[KTPlayerTool sharedInstance] isPlaying]) {
        [cell.playerView.stopButton setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        [cell.playerView.stopButton setTitle:@"播放" forState:UIControlStateNormal];
    }
}

- (void)setupStatePauseWithCurrentCell:(KTPalyTableViewCell*)cell{
    
    cell.playerView.videoProgressView.progress = 0;
    [cell.playerView.playSlider setValue:0.0 animated:YES];
    cell.playerView.totolTimeLabel.text = @"00:00";
    cell.playerView.currentTimeLabel.text = @"00:00";
    [cell.playerView.stopButton setTitle:@"播放" forState:UIControlStateNormal];
}

- (void)addTarget:(KTPalyTableViewCell*)cell WithIndexPath:(NSIndexPath*)indexPath{
    
    [cell.playerView.stopButton addTarget:cell action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
    cell.playerView.stopButton.tag = indexPath.row;
    
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChange:) forControlEvents:UIControlEventValueChanged]; //拖动滑竿更新时间
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpInside];  //松手,滑块拖动停止
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpOutside];
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchCancel];
    cell.playerView.playSlider.tag = indexPath.row;
    
}

- (void)playOrPause:(UIButton*)sender{
    NSIndexPath * currentIndex = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    //第一次点击
    if ([KTPlayerTool sharedInstance].currentIndexPath == nil) {
        [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        [[KTPlayerTool sharedInstance] playWithUrl:self.model.playUrl];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateprogress" object:nil];
        return;
    }
    //同一行
    if([[KTPlayerTool sharedInstance].currentIndexPath isEqual:currentIndex]){
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [[KTPlayerTool sharedInstance] pause];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
            [sender setTitle:@"播放" forState:UIControlStateNormal];
        }else{
            [[KTPlayerTool sharedInstance] play];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
            [sender setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }else{
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [[KTPlayerTool sharedInstance] playWithUrl:self.model.playUrl];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
            [sender setTitle:@"暂停" forState:UIControlStateNormal];
            
        }else{
            [[KTPlayerTool sharedInstance] pause];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
            [sender setTitle:@"播放" forState:UIControlStateNormal];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateprogress" object:nil];

}

//手指正在拖动，播放器继续播放，但是停止滑竿的时间走动
- (void)playSliderChange:(UISlider *)slider
{
    if ([KTPlayerTool sharedInstance].player.status != AVPlayerStatusReadyToPlay) {
        return;
    }
    NSIndexPath * currentIndex = [NSIndexPath indexPathForRow:slider.tag inSection:0];
    
    if([[KTPlayerTool sharedInstance].currentIndexPath isEqual:currentIndex]){
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [[KTPlayerTool sharedInstance] pause];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        }else{
            [[KTPlayerTool sharedInstance] play];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        }
    }else{
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [[KTPlayerTool sharedInstance] playWithUrl:self.model.playUrl];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
            
        }else{
            [[KTPlayerTool sharedInstance] pause];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        }
    }
    [[KTPlayerTool sharedInstance] updateCurrentTime:slider.value];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateprogress" object:nil];
}
//手指结束拖动，播放器从当前点开始播放，开启滑竿的时间走动
- (void)playSliderChangeEnd:(UISlider *)slider
{
    if ([KTPlayerTool sharedInstance].player.status != AVPlayerStatusReadyToPlay) {
        return;
    }
    NSIndexPath * currentIndex = [NSIndexPath indexPathForRow:slider.tag inSection:0];
    
    if([[KTPlayerTool sharedInstance].currentIndexPath isEqual:currentIndex]){
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [[KTPlayerTool sharedInstance] pause];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        }else{
            [[KTPlayerTool sharedInstance] play];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        }
    }else{
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [[KTPlayerTool sharedInstance] playWithUrl:self.model.playUrl];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
            
        }else{
            [[KTPlayerTool sharedInstance] pause];
            [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        }
    }
    [[KTPlayerTool sharedInstance] updateCurrentTime:slider.value];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateprogress" object:nil];
}

- (KTPlayerView*)playerView{
    if (!_playerView) {
        _playerView = [[KTPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _playerView.backgroundColor = [UIColor grayColor];
    }
    return _playerView;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 30)];
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
