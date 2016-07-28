//
//  YzHomeViewDataProvider.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/7.
//  Copyright © 2016年 Yuz. All rights reserved.
//



#import <Foundation/Foundation.h>
@class YzHomeTableViewCellDataProvider;
@class YzHomeTopDataProvider;

@interface YzHomeViewDataProvider : NSObject

@property(nonatomic, assign, readonly) BOOL isLoading;
/**< 获取当日最新*/
- (RACSignal *)getHomeViewData;
/**< 获取历史记录*/
- (RACSignal *)getPreviousStories;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)headerTitleForSection:(NSInteger)section;
- (YzHomeTableViewCellDataProvider *)cellProviderAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray <YzHomeTopDataProvider *>*)getTopStoriesArray;

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

