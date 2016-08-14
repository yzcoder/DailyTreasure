//
//  YzHomeViewDataProvider.m
//  DailyTreasure
//
//  Created by 初号机 on 16/5/7.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzHomeViewDataProvider.h"
#import "YzHomeStoryModel.h"
#import "YzHomeSectionModel.h"

@interface YzHomeViewDataProvider ()

@property (nonatomic, strong) NSMutableArray <YzHomeSectionModel *>*sectionModelArray;
@property (nonatomic, strong) NSMutableArray <YzHomeTopDataProvider *>*topStoryArray;
@property (nonatomic, copy) NSString *currentDateString;


@end

@implementation YzHomeViewDataProvider

#pragma mark - Lazy load -
-(NSMutableArray *)sectionModelArray {
    if (!_sectionModelArray) {
        _sectionModelArray = [NSMutableArray array];
    }
    return _sectionModelArray;
}

-(NSArray<YzHomeTopDataProvider *> *)topStoryArray {
    if (!_topStoryArray) {
        _topStoryArray = [NSMutableArray array];
    }
    return _topStoryArray;
}

#pragma mark - 数据逻辑 -
#pragma mark 获取当日最新
- (RACSignal *)getHomeViewData {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [YzHttpOperation getRequestWithURL:kGetHomeStories parameters:nil success:^(id  _Nonnull responseObject) {
            NSDictionary *reponseDict = (NSDictionary*)responseObject;
            self.currentDateString = reponseDict[@"date"];
            YzHomeSectionModel *sectionModel = [YzHomeSectionModel sectionModelWithTitle:reponseDict[@"date"] modelArray:reponseDict[@"stories"]];
            [self.sectionModelArray addObject:sectionModel];
            
            NSArray *topStories = reponseDict[@"top_stories"];
            
            for (NSDictionary *storyDict in topStories) {
                YzHomeTopDataProvider *topProvider = [YzHomeTopDataProvider homeToplDataProviderWithDictionary:storyDict];
                [self.topStoryArray addObject:topProvider];
            }
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
        } failure:^(NSError * _Nonnull error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

#pragma mark 获取历史记录
- (RACSignal *)getPreviousStories {
    _isLoading = YES;
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [YzHttpOperation getRequestWithURL:[NSString stringWithFormat:@"%@%@",kGetHistoryStories,self.currentDateString] parameters:nil success:^(id  _Nonnull responseObject) {
            NSDictionary *reponseDict = (NSDictionary*)responseObject;
            self.currentDateString = reponseDict[@"date"];
            YzHomeSectionModel *sectionModel = [YzHomeSectionModel sectionModelWithTitle:reponseDict[@"date"] modelArray:reponseDict[@"stories"]];
            [self.sectionModelArray addObject:sectionModel];
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            _isLoading = NO;
        } failure:^(NSError * _Nonnull error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
            _isLoading = NO;
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}




- (NSInteger)numberOfSections {
    return self.sectionModelArray.count;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return  self.sectionModelArray.count ? self.sectionModelArray[section].dataModelArray.count : -1;
}
- (NSString *)headerTitleForSection:(NSInteger)section {
    return  self.sectionModelArray[section].headerTitle;
}
- (YzHomeTableViewCellDataProvider *)cellProviderAtIndexPath:(NSIndexPath *)indexPath {
    return  self.sectionModelArray[indexPath.section].dataModelArray[indexPath.row];
}

- (NSArray <YzHomeTopDataProvider *>*)getTopStoriesArray {
    return [NSArray arrayWithArray:self.topStoryArray];
}

@end






@interface YzHomeTableViewCellDataProvider ()

@property (nonatomic, strong) YzHomeStoryModel *storyModel;

@end

@implementation YzHomeTableViewCellDataProvider


+ (instancetype)homeCellDataProviderWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.storyModel = [YzHomeStoryModel storyModelWithDictionary:dict];
    }
    return self;
}

- (NSString *)homeCellStoryTitle {
    return self.storyModel.title;
}

- (NSURL *)homeCellImageURL {
    return [NSURL URLWithString:self.storyModel.images[0]];
}

- (NSString *)homeCellStoryID {
    return self.storyModel.storyid;
}

- (BOOL)isMultipic {
    return self.storyModel.multipic;
}

- (BOOL)isTitleWithoutImage {
    return self.storyModel.images == nil ? YES : NO;
}
@end




@interface YzHomeTopDataProvider ()

@property (nonatomic, strong) YzTopStoryModel *topModel;

@end

@implementation YzHomeTopDataProvider


+ (instancetype)homeToplDataProviderWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.topModel = [YzTopStoryModel topModelWithDictionary:dict];
    }
    return self;
}

- (NSString *)topStoryTitle {
    return self.topModel.title;
}

- (NSURL *)topImageURL {
    return [NSURL URLWithString:self.topModel.image];
}

-(NSString *)topStoryID {
    return self.topModel.storyid;
}

@end