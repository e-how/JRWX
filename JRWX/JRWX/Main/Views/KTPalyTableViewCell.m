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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)cellWithTable:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    static NSString* identifier = @"playCell";
    KTPalyTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[KTPalyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ([[[KTPlayerTool sharedInstance] currentIndexPath] isEqual:indexPath] && [[KTPlayerTool sharedInstance] currentIndexPath] != nil) {
        cell.playerView.videoProgressView.progress = [[KTPlayerTool sharedInstance] currentPlayProgress];
        cell.playerView.totolTimeLabel.text = @"11";//[[KTPlayerTool sharedInstance] getDuration];
        cell.playerView.currentTimeLabel.text = @"dd";//[[KTPlayerTool sharedInstance]getCurrent];
        cell.playerView.playSlider.minimumValue = 0.0;
        cell.playerView.playSlider.maximumValue = 10;//[[KTPlayerTool sharedInstance] getSliderDuration];
        [cell.playerView.playSlider setValue:8 animated:YES];
        
        if ([[KTPlayerTool sharedInstance] isPlaying]) {
            [cell.playerView.stopButton setTitle:@"暂停" forState:UIControlStateNormal];
        }else{
            [cell.playerView.stopButton setTitle:@"播放" forState:UIControlStateNormal];
        }
    }else{
        cell.playerView.videoProgressView.progress = 0;
        [cell.playerView.playSlider setValue:0.0 animated:YES];
        cell.playerView.totolTimeLabel.text = @"00:00";
        cell.playerView.currentTimeLabel.text = @"00:00";
        [cell.playerView.stopButton setTitle:@"播放" forState:UIControlStateNormal];
    }
    [cell.playerView.stopButton addTarget:cell action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
     cell.playerView.stopButton.tag = indexPath.row;

    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChange:) forControlEvents:UIControlEventValueChanged]; //拖动滑竿更新时间
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpInside];  //松手,滑块拖动停止
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchUpOutside];
    [cell.playerView.playSlider addTarget:cell action:@selector(playSliderChangeEnd:) forControlEvents:UIControlEventTouchCancel];
    
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

- (void)playOrPause:(UIButton*)sender{
    
    NSIndexPath * currentIndex = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if ([KTPlayerTool sharedInstance].currentIndexPath == nil) {
        [KTPlayerTool sharedInstance].currentIndexPath = currentIndex;
        [[KTPlayerTool sharedInstance] playWithUrl:self.model.playUrl];
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
//    [[KTPlayerTool sharedInstance] updateCurrentTime:slider.value];
}
//手指结束拖动，播放器从当前点开始播放，开启滑竿的时间走动
- (void)playSliderChangeEnd:(UISlider *)slider
{
    //    [self seekToTime:slider.value];
//    [[KTPlayerTool sharedInstance] updateCurrentTime:slider.value];
    
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
