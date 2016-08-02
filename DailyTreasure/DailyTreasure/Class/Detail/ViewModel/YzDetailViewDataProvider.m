//
//  YzDetailViewDataProvider.m
//  DailyTreasure
//
//  Created by Yz on 16/8/1.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzDetailViewDataProvider.h"
#import "YzDetailViewModel.h"

@implementation YzDetailViewDataProvider


- (RACSignal *)storyDetialWithStoryid:(NSString *)storyid {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        _isLoading = YES;
        @strongify(self);
        [YzHttpOperation getRequestWithURL:[NSString stringWithFormat:@"story/%@",storyid] parameters:nil success:^(id  _Nonnull responseObject) {
            YzDetailViewModel *detailModel = [YzDetailViewModel detailModelWithDictionary:(NSDictionary *)responseObject];
            
            
            _isLoading = NO;
        }failure:^(NSError * _Nonnull error) {
            _isLoading = NO;
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (RACSignal *)getStoryDetial {
    return [self storyDetialWithStoryid:self.storyID];
}
@end
