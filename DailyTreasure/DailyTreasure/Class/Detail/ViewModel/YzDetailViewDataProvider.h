//
//  YzDetailViewDataProvider.h
//  DailyTreasure
//
//  Created by Yz on 16/8/1.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YzDetailViewDataProvider : NSObject

@property (nonatomic, copy) NSString *storyID;

@property (nonatomic, readonly, assign) BOOL isLoading;



- (RACSignal *)storyDetialWithStoryid:(NSString *)storyid;

- (RACSignal *)getStoryDetial;


@end
