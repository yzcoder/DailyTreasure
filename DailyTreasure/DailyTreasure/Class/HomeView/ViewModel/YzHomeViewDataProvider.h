//
//  YzHomeViewDataProvider.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/7.
//  Copyright © 2016年 Yuz. All rights reserved.
//



#import <Foundation/Foundation.h>
@class YzHomeTableViewCellDataProvider;


@interface YzHomeViewDataProvider : NSObject

/**< 获取当日最新*/
- (RACSignal *)getHomeViewData;


- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)headerTitleForSection:(NSInteger)section;
- (YzHomeTableViewCellDataProvider *)cellProviderAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray <YzHomeTableViewCellDataProvider *>*)getTopStoriesArray;

@end


@interface YzHomeTableViewCellDataProvider : NSObject

+ (instancetype)homeCellDataProviderWithDictionary:(NSDictionary *)dict;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSString *)homeCellStoryTitle;

- (NSURL *)homeCellImageURL;

- (BOOL)isMultipic;

- (BOOL)isTitleWithoutImage;
@end

@interface YzHomeTopDataProvider : NSObject

+ (instancetype)homeToplDataProviderWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict ;
- (NSString *)topStoryTitle ;
- (NSURL *)topImageURL ;
@end

