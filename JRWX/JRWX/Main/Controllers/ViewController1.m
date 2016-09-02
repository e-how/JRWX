//
//  ViewController1.m
//  JRWX
//
//  Created by 张益豪 on 16/5/4.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
#import "LFLUISegmentedControl.h"

@interface ViewController1 ()<LFLUISegmentedControlDelegate>

@property(nonatomic, strong)UIScrollView *mainScrollView; /**< 正文mainSV */

@property (nonatomic ,strong)LFLUISegmentedControl * LFLuisement;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    int x = 1;
    
    NSLog(@"branch1!");
    
    
    NSAssert(x!=0,@"x must not be zero");
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"setting" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
    
    //    1.初次创建：
    self.LFLuisement=[[LFLUISegmentedControl alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.LFLuisement.delegate = self;
    //   2.设置显示切换标题数组
    [self.LFLuisement AddSegumentArray:
     [NSArray arrayWithObjects:@"关注",@"VIP",nil]];
    [self.LFLuisement selectTheSegument:0];
    [self.view addSubview:self.LFLuisement];
    
    [self createMainScrollView];
}

//创建正文ScrollView内容
- (void)createMainScrollView {
    
    CGFloat begainScrollViewY = 33+ 64;
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, begainScrollViewY, SCREEN_WIDTH,(SCREEN_HEIGHT -begainScrollViewY))];
    self.mainScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, (SCREEN_HEIGHT -begainScrollViewY));
    //设置代理
    self.mainScrollView.delegate = self;
    
    //添加滚动显示的三个对应的界面view
    for (int i = 0; i < 2; i++) {
        UIView *viewExample = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *i, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        viewExample.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        [self.mainScrollView addSubview:viewExample];
    }
}

#pragma mark --- UIScrollView代理方法

static NSInteger pageNumber = 0;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pageNumber = (int)(scrollView.contentOffset.x / SCREEN_WIDTH + 0.5);
    //    滑动SV里视图,切换标题
    [self.LFLuisement selectTheSegument:pageNumber];
}

#pragma mark ---LFLUISegmentedControlDelegate
/**
 *  点击标题按钮
 *
 *  @param selection 对应下标 begain 0
 */
-(void)uisegumentSelectionChange:(NSInteger)selection{
    //    加入动画,显得不太过于生硬切换
    [UIView animateWithDuration:.2 animations:^{
        [self.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH *selection, 0)];
    }];
}

- (void)push{
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
