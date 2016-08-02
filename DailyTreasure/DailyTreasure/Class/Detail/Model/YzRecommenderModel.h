//
//  YzRecommenderModel.h
//  DailyTreasure
//
//  Created by Yz on 16/8/2.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YzRecommenderModel : NSObject

@property (nonatomic, copy) NSString *bio;

@property (nonatomic, copy) NSString *zhihu_url_token;

@property (nonatomic, assign) long id;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)recommenderModelWithDictionary:(NSDictionary *)dict;
@end
