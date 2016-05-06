//
//  KTRootViewController.h
//  kingTrader
//
//  Created by 张益豪 on 15/9/2.
//  Copyright (c) 2015年 张益豪. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MJRefresh.h"


@interface KTRootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView* tableView;

- (void)initData;
- (void)reloadCurrentPage;

@end
