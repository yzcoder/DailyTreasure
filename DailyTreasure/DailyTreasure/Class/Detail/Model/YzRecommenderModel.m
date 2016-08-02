//
//  YzRecommenderModel.m
//  DailyTreasure
//
//  Created by Yz on 16/8/2.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzRecommenderModel.h"

@implementation YzRecommenderModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)recommenderModelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}
@end
