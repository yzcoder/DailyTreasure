//
//  YzDetailViewDataProvider.m
//  DailyTreasure
//
//  Created by Yz on 16/8/1.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzDetailViewDataProvider.h"
#import "YzDetailViewModel.h"

@interface YzDetailViewDataProvider ()

@property (nonatomic, strong) YzDetailViewModel *detailViewModel;

@end

@implementation YzDetailViewDataProvider


- (RACSignal *)storyDetialWithStoryid:(NSString *)storyid {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        _isLoading = YES;
        @strongify(self);
        [YzHttpOperation getRequestWithURL:[NSString stringWithFormat:@"story/%@",storyid] parameters:nil success:^(id  _Nonnull responseObject) {
            self.detailViewModel = [YzDetailViewModel detailModelWithDictionary:(NSDictionary *)responseObject];
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            _isLoading = NO;
        }failure:^(NSError * _Nonnull error) {
            [subscriber sendNext:error];
            [subscriber sendCompleted];
            _isLoading = NO;
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (RACSignal *)getStoryDetial {
    return [self storyDetialWithStoryid:self.storyID];
}

- (NSString *)detailHTMLString {
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",[self.detailViewModel.css firstObject],self.detailViewModel.body];

}

- (NSURL *)topImageURL {
    return [NSURL URLWithString:self.detailViewModel.image];
}
@end
