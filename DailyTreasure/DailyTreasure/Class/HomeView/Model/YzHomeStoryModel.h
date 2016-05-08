//
//  YzHomeStoryModel.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/7.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YzHomeStoryModel : NSObject

@property (nonatomic, copy) NSString *ga_prefix;
/**< 日报ID*/
@property (nonatomic, copy) NSString *storyid;
/**< 图片 date*/
@property (nonatomic, strong) NSArray *images;
/**< 标题*/
@property (nonatomic, copy) NSString *title;
/**< 类型*/
@property (nonatomic, copy) NSString *type;
/**< 是否多图*/
@property (nonatomic, assign) BOOL *multipic;


+ (instancetype)storyModelWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

@interface YzTopStoryModel : NSObject

@property (nonatomic, copy) NSString *ga_prefix;
/**< 日报ID*/
@property (nonatomic, copy) NSString *storyid;
/**< 标题*/
@property (nonatomic, copy) NSString *title;
/**< 类型*/
@property (nonatomic, copy) NSString *type;
/**< 图片 top*/
@property (nonatomic, copy) NSString *image;


+ (instancetype)topModelWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end