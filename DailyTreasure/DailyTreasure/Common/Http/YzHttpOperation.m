//
//  YzHttpOperation.m
//  DailyTreasure
//
//  Created by 初号机 on 16/3/25.
//  Copyright © 2016年 Yuz. All rights reserved.
//
#import "YzHttpOperation.h"

@implementation YzHttpOperation

+ (void)getRequestWithURL:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
