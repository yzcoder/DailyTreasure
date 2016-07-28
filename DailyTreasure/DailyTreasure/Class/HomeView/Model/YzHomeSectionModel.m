//
//  YzHomeSectionModel.m
//  DailyTreasure
//
//  Created by 初号机 on 16/5/8.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzHomeSectionModel.h"


@implementation YzHomeSectionModel

-(NSMutableArray *)dataModelArray {
    if (!_dataModelArray) {
        _dataModelArray = [NSMutableArray array];
    }
    return _dataModelArray;
}

+ (instancetype)sectionModelWithTitle:(NSString *)title modelArray:(NSArray *)modelArray {
    return [[self alloc] initWithTitle:title modelArray:modelArray];
}

- (instancetype)initWithTitle:(NSString *)title modelArray:(NSArray *)modelArray {
    self = [super init];
    if (self) {
        self.headerTitle = [self dateStringFormat:title];
        for (NSDictionary *storyDict in modelArray) {
            YzHomeTableViewCellDataProvider *cellProvider = [YzHomeTableViewCellDataProvider homeCellDataProviderWithDictionary:storyDict];
            [self.dataModelArray addObject:cellProvider];
        }
    }
    return self;
}

- (NSString *)dateStringFormat:(NSString *)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:str];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *sectionTitleText = [formatter stringFromDate:date];
    
    return sectionTitleText;
}


@end
