//
//  YzHomeTopStoriesView.m
//  DailyTreasure
//
//  Created by 初号机 on 16/5/8.
//  Copyright © 2016年 Yuz. All rights reserved.
//



#import "YzHomeTopStoriesView.h"
#import "YzHomeViewDataProvider.h"
@interface YzHomeTopStoriesView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray <YzHomeTopDataProvider *>*topstoriesModels;
@property (nonatomic, weak) StoryView *preStoryView;
@property (nonatomic, weak) StoryView *currentStoryView;
@property (nonatomic, weak) StoryView *nextStoryView;

@end

@implementation YzHomeTopStoriesView

#pragma mark - Lazy Load -

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 3, kHomeTopStoriesViewHeight)];
        [self addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        _mainScrollView = scrollView;
    }
    return _mainScrollView;
}

-(StoryView *)preStoryView {
    if (!_preStoryView) {
        StoryView *storyView = [[StoryView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
        [self.mainScrollView addSubview:storyView];
        _preStoryView = storyView;
    }
    return _preStoryView;
}

-(StoryView *)currentStoryView {
    if (!_currentStoryView) {
        StoryView *storyView = [[StoryView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
        [self.mainScrollView addSubview:storyView];
        _currentStoryView = storyView;
    }
    return _currentStoryView;
}

-(StoryView *)nextStoryView {
    if (!_nextStoryView) {
        StoryView *storyView = [[StoryView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
        [self.mainScrollView addSubview:storyView];
        _nextStoryView = storyView;
    }
    return _nextStoryView;
}

-(NSArray *)topstoriesModels {
    if (!_topstoriesModels) {
        _topstoriesModels = [NSArray array];
    }
    return _topstoriesModels;
}
#pragma mark - 页面逻辑 -

- (instancetype)initWithModels:(NSArray *)topstoriesModels frame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _currentIndex = 0;
        
        self.topstoriesModels = topstoriesModels;
        
        [self loadPage];
    }
    return self;
}

- (void)loadPage
{
    [self.mainScrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    
    if (self.topstoriesModels.count == 0) {
        return;
    }
    // 移除三个视图上的数据
    [self.preStoryView cleanData];
    [self.currentStoryView cleanData];
    [self.nextStoryView cleanData];
    
    // 加载三张图
    // 当前页
    self.currentStoryView.imageURL = [self.topstoriesModels[self.currentIndex] topImageURL];
    self.currentStoryView.title = [self.topstoriesModels[self.currentIndex] topStoryTitle];
    
    // 左侧页
    NSInteger preIndex = _currentIndex - 1 < 0 ?
    self.topstoriesModels.count - 1 :
    self.currentIndex - 1;
    self.preStoryView.imageURL = [self.topstoriesModels[preIndex] topImageURL];
    self.preStoryView.title = [self.topstoriesModels[preIndex] topStoryTitle];
    
    // 右侧叶
    NSInteger nextIndex = _currentIndex + 1 == self.topstoriesModels.count ?
    0 : self.currentIndex + 1;
    self.nextStoryView.imageURL = [self.topstoriesModels[nextIndex] topImageURL];
    self.nextStoryView.title = [self.topstoriesModels[nextIndex] topStoryTitle];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateCurrentIndex];
}

- (void)updateCurrentIndex {
    int index = self.mainScrollView.contentOffset.x / kScreenWidth;
    if(index == 0) {
        _currentIndex = _currentIndex-1 < 0 ? self.topstoriesModels.count - 1:_currentIndex - 1;
        [self loadPage];
        return;
    }
    
    if(index == 2) {
        _currentIndex = _currentIndex + 1 == self.topstoriesModels.count ?0 : _currentIndex + 1;
        [self loadPage];
    }
}

@end

@interface StoryView ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation StoryView

-(UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

-(void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self.imageView sd_setImageWithURL:imageURL];
    
    [self layoutIfNeeded];
}

-(void)setTitle:(NSString *)title {
    _title = title;
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    CGSize size =  [attStr boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    self.titleLabel.attributedText = attStr;
    self.titleLabel.frame = CGRectMake(15, kHomeTopStoriesViewHeight - 30 - size.height, kScreenWidth - 30, size.height);
    
    [self layoutIfNeeded];

}

- (void)cleanData {
//    self.imageView.image = nil;
//    self.titleLabel.attributedText = nil;
}
@end