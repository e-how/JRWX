//
//  KTPalyTableViewCell.h
//  JRWX
//
//  Created by 张益豪 on 16/5/18.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTPlayModel.h"
#import "KTPlayerView.h"

@interface KTPalyTableViewCell : UITableViewCell

@property (nonatomic, strong) KTPlayerView* playerView;
@property (nonatomic, strong) KTPlayModel* model;
@property (nonatomic, strong) UILabel* nameLabel;

+ (id)cellWithTable:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@end
