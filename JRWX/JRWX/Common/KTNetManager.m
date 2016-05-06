//
//  KTNetManager.m
//  kingTrader
//
//  Created by 张益豪 on 15/9/2.
//  Copyright (c) 2015年 张益豪. All rights reserved.
//

#import "KTNetManager.h"
#import "AFNetworking.h"
#include "JWT.h"

@implementation KTNetManager

/**
 *
 *  @param url     接口字符串
 *  @param params  参数
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              if ([[responseObject objectForKey:@"info"] isEqualToString:@"ok"]) {
                  success([responseObject objectForKey:@"data"]);
                  
              }else{
//                  [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"info"]];
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}
/**
 *  afn同步请求
 *
 *  @return 返回值
 */

+ (id)postSynWithURL:(NSString*)url params:(NSDictionary *)params error:(NSError **)error{
    
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableURLRequest *request =
    [mgr.requestSerializer requestWithMethod:@"POST"
                                   URLString:url
                                  parameters:params
                                       error:nil];
    
    /* 最终继承自 NSOperation，也就是利用 NSOperation 来做的同步请求 */
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestOperation setResponseSerializer:responseSerializer];
    
    [requestOperation start];
    
    [requestOperation waitUntilFinished];
    

    /* 请求结果 */
    id result = [requestOperation responseObject];
    
    if (result != nil) {
        
        if ([[result objectForKey:@"info"] isEqualToString:@"ok"]){
            
            return [result objectForKey:@"data"];
            
        }else{
            NSDictionary* errorDetails = @{@"errorInfo":
                                               [result objectForKey:@"info"],
                                           @"errorCode":[result objectForKey:@"code"]};
            
            *error = [NSError errorWithDomain:[errorDetails objectForKey:@"errorInfo"] code:[[errorDetails objectForKey:@"errorCode"] integerValue] userInfo:errorDetails];
            return nil;
        }
        
    }else{
        *error = [NSError errorWithDomain:@"请求失败" code:202 userInfo:@{@"errorInfo":@"网络错误"}];
        return nil;
    }

}


@end
