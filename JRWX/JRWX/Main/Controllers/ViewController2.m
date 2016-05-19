//
//  ViewController2.m
//  JRWX
//
//  Created by 张益豪 on 16/5/4.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "ViewController2.h"
#import "KTPalyTableViewCell.h"
#import "KTPlayModel.h"
#import "KTPlayerTool.h"
@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray* dataSource;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.dataSource = [NSMutableArray array];
    KTPlayModel* model1 = [[KTPlayModel alloc] init];
    KTPlayModel* model2 = [[KTPlayModel alloc] init];
    KTPlayModel* model3 = [[KTPlayModel alloc] init];
    KTPlayModel* model4 = [[KTPlayModel alloc] init];
    model1.playUrl = @"http://qqma.tingge123.com:82/123/2015/09/Bandari%20-%20%E5%AE%89%E5%A6%AE%E7%9A%84%E4%BB%99%E5%A2%83.mp3";
    model2.playUrl = @"http://qqma.tingge123.com:82/123/2015/09/%E8%BD%BB%E9%9F%B3%E4%B9%90%20-%20%E5%88%9D%E9%9B%AA.mp3";
    model3.playUrl = @"http://qqma.tingge123.com:82/123/2013/07/%E5%A4%9C%E7%9A%84%E9%92%A2%E7%90%B4%E6%9B%B24-%E7%9F%B3%E8%BF%9B.mp3";
    model4.playUrl = @"http://qqma.tingge123.com:82/123/2013/06/%E8%B4%9D%E5%A4%9A%E8%8A%AC%20%E6%9C%88%E5%85%89%E6%9B%B2.mp3";
    for (int i = 0 ; i < 5; i++) {
        [self.dataSource addObject:model1];
        [self.dataSource addObject:model2];
        [self.dataSource addObject:model3];
        [self.dataSource addObject:model4];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(progressUpdate:) name:@"updateprogress" object:nil];
    
}

-(void)progressUpdate:(NSNotification *)notify
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KTPalyTableViewCell* cell = [KTPalyTableViewCell cellWithTable:tableView indexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

@end
