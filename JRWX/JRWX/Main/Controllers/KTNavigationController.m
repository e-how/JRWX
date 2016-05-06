//
//  KTNavigationController.m
//  kingTrader
//
//  Created by 张益豪 on 15/9/2.
//  Copyright (c) 2015年 张益豪. All rights reserved.
//

#import "KTNavigationController.h"

@interface KTNavigationController ()

@end

@implementation KTNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 背景颜色
        [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
        
        // 字体颜色及大小
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        [dict setObject:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
        
        self.navigationBar.titleTextAttributes = dict;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIBarButtonItem*) createBackButton
{
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 15, 20)];
    imageView.image = [UIImage imageNamed:@"返回按钮.png"];
    [backBtn addSubview:imageView];
    UIBarButtonItem* backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    return backBarBtn;
    
}
- (void)popself{
    
    [self popViewControllerAnimated:YES];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 0) {
        
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];

}

#pragma mark-
#pragma mark- 侧滑返回

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    KTNavigationController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = (id)self;
    nvc.delegate = (id)self;
    return nvc;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController); //the most important
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
