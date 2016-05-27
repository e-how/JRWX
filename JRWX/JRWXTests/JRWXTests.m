//
//  JRWXTests.m
//  JRWXTests
//
//  Created by 张益豪 on 16/5/4.
//  Copyright © 2016年 Ktkt. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JRWXTests : XCTestCase

@end

@implementation JRWXTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSLog(@"自定义测试testExample");
    int  a= 3;
    XCTAssertTrue(a == 3,"a 不能等于 0");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
