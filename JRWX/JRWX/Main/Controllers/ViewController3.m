//
//  ViewController3.m
//  JRWX
//
//  Created by 张益豪 on 16/5/4.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import "ViewController3.h"
#import <KVOController/KVOController.h>
#import "KTConmonModel.h"

@interface YYAlbum : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *photos; // Array<YYPhoto>
//@property (nonatomic, strong) NSDictionary *likedUsers; // Key:name(NSString) Value:user(YYUser)
//@property (nonatomic, strong) NSSet *likedUserIds; // Set<NSNumber>
@end

@implementation YYAlbum
@end

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 100, 100, 50)];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn setTitle:@"btnpressed" forState:UIControlStateHighlighted];

    [btn bk_addEventHandler:^(id sender) {
        [UIAlertView bk_showAlertViewWithTitle:@"title" message:@"message" cancelButtonTitle:@"cancel" otherButtonTitles:@[@"ok",@"oktest"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            DDLogDebug(@"alert clicked==%tu",buttonIndex);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    NSArray* array = @[@"1",@"2",@"3",@"4"];

    [array bk_all:^BOOL(id obj) {
      DDLogInfo(@"id obj= %@\n",obj);
      return YES;
    }];
    
    [array bk_each:^(id obj) {
        DDLogInfo(@"each=%@\n",obj);
    }];
    
    [array bk_any:^BOOL(id obj) {
        DDLogInfo(@"any = %@\n",obj);
        return YES;
    }];
    
    [array bk_apply:^(id obj) {
        DDLogInfo(@"apply obj=%@",obj);
    }];
    
    
    KTConmonModel* model = [[KTConmonModel alloc] init];
    [model modelSetWithJSON:@{@"title":@"11"}];
    DDLogInfo(@"model=%@",model.modelDescription);
    
    KTConmonModel* model1 = [KTConmonModel modelWithJSON:@{@"title":@"123"}];
    DDLogInfo(@"model1.title=%@ description=%@",model1.title,model1.modelDescription);
    
    ContainerObjectExample();
    
}

static void ContainerObjectExample() {
    YYAlbum *album = [YYAlbum modelWithJSON:@"          \
                      { \                                                  
                      \"name\" : \"Happy Birthday\",                      \
                      \"photos\" : [                                      \
                      {                                               \
                      \"url\":\"http://example.com/1.png\",       \
                      \"desc\":\"Happy~\"                         \
                      },                                              \
                      {                                               \
                      \"url\":\"http://example.com/2.png\",       \
                      \"desc\":\"Yeah!\"                          \
                      }                                               \
                      ]\
                      }"];
    NSString *albumJSON = [album modelToJSONString];
    DDLogInfo(@"Album: %@", albumJSON);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
