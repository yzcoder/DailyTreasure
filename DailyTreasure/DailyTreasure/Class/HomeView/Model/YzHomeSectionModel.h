//
//  YzHomeSectionModel.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/8.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YzHomeViewDataProvider.h"

@interface YzHomeSectionModel : NSObject

@property (nonatomic, copy) NSString *headerTitle;

@property (nonatomic, strong) NSMutableArray <YzHomeTableViewCellDataProvider *>*dataModelArray;


+ (instancetype)sectionModelWithTitle:(NSString *)title modelArray:(NSArray *)modelArray;

- (instancetype)initWithTitle:(NSString *)title modelArray:(NSArray *)modelArray;



@end
