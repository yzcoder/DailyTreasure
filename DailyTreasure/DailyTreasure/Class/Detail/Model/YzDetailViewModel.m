
//
//  YzDetailViewModel.m
//  DailyTreasure
//
//  Created by Yz on 16/8/2.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzDetailViewModel.h"

@implementation YzDetailViewModel



- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        if (dict[@"recommenders"]) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in dict[@"recommenders"]) {
                YzRecommenderModel *rModel = [YzRecommenderModel recommenderModelWithDictionary:dic];
                [mArr addObject:rModel];
            }
            self.recommenders = [NSArray arrayWithArray:mArr];
        }
    }
    return self;
}

+ (instancetype)detailModelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"storyid"];
    }
}


@end
