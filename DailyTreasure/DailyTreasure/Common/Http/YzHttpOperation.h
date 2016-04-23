//
//  YzHttpOperation.h
//  DailyTreasure
//
//  Created by 初号机 on 16/3/25.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YzHttpOperation : NSObject

typedef void (^successBlock)(_Nonnull id responseObject);
typedef void (^failureBlock)( NSError * _Nonnull error);

+ (void)getRequestWithURL:( NSString * _Nonnull )URLString parameters:(nullable id)parameters success:(_Nonnull successBlock)success failure:(nullable failureBlock)failure;

@end
