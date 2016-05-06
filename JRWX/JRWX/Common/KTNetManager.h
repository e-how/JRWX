//
//  KTNetManager.h
//  kingTrader
//
//  Created by 张益豪 on 15/9/2.
//  Copyright (c) 2015年 张益豪. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KTNetManager : NSObject

/**
 * post 异步请求
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  post 同步请求
 *
 *  @param url    <#url description#>
 *  @param params <#params description#>
 *  @param error  <#error description#>
 *
 *  @return <#return value description#>
 */
+ (id)postSynWithURL:(NSString*)url params:(NSDictionary *)params error:(NSError **)error;

@end
