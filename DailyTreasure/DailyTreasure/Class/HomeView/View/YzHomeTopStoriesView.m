//
//  YzHomeTopStoriesView.m
//  DailyTreasure
//
//  Created by 初号机 on 16/5/8.
//  Copyright © 2016年 Yuz. All rights reserved.
//



#import "YzHomeTopStoriesView.h"

@interface YzHomeTopStoriesView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) StoryView *preStoryView;
@property (nonatomic, weak) StoryView *currentStoryView;
@property (nonatomic, weak) StoryView *nextStoryView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YzHomeTopStoriesView

#pragma mark - Lazy Load -

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
        scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kHomeTopStoriesViewHeight);
        [self addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.clipsToBounds = NO;
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

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 40, self.height - 40, 80, 50)];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self insertSubview:pageControl aboveSubview:self.mainScrollView];
        _pageControl = pageControl;
    }
    return _pageControl;
}

#pragma mark - Setter -
-(void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    self.pageControl.currentPage = _currentIndex;
}

-(void)setTopstoriesModels:(NSArray<YzHomeTopDataProvider *> *)topstoriesModels {
    _topstoriesModels  = topstoriesModels;
    self.pageControl.numberOfPages = self.topstoriesModels.count;
    [self loadPage];
}

-(void)setIsTimeFire:(BOOL)isTimeFire {
    if (isTimeFire) {
        //开启定时器
        [self.timer setFireDate:[NSDate distantPast]];
        return;
    }    
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
}
#pragma mark - 页面逻辑 -

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topstoriesModels = [NSMutableArray array];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    [self loadPage];
    [self creatTimer];
}


- (void)creatTimer {
    _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timerUpdatePage) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}
- (void)loadPage
{
    [self.mainScrollView setContentOffset:CGPointMake(kScreenWidth, 0) ];
    
    if (self.topstoriesModels.count == 0) {
        return;
    }
    
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateCurrentIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateCurrentIndex];
}

- (void)updateCurrentIndex {
    int index = self.mainScrollView.contentOffset.x / kScreenWidth;
    if(index == 0) {
        self.currentIndex = _currentIndex-1 < 0 ? self.topstoriesModels.count - 1:_currentIndex - 1;
        [self loadPage];
        return;
    }
    
    if(index == 2) {
        self.currentIndex = _currentIndex + 1 == self.topstoriesModels.count ?0 : _currentIndex + 1;
        [self loadPage];
    }
}

- (void)timerUpdatePage {
    [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.contentOffset.x + kScreenWidth, self.mainScrollView.contentOffset.y) animated:YES];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.currentStoryView setFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.height)];
    self.pageControl.frame = CGRectMake(kScreenWidth/2 - 40, self.height - 40, 80, 50);

}

-(void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end


@interface StoryView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation StoryView

-(UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight )];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
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
    CGSize size =  [attStr boundingRectWithSize:CGSizeMake(kScreenWidth - 30, kHomeTopStoriesViewHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    self.titleLabel.attributedText = attStr;
    self.titleLabel.frame = CGRectMake(15, self.height - 30 - size.height, kScreenWidth - 30, size.height);
    [self layoutIfNeeded];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(0 - kScreenWidth * (self.height/kHomeTopStoriesViewHeight - 1)/2 , 0, kScreenWidth * (self.height/kHomeTopStoriesViewHeight), self.height)];
    [self.titleLabel setFrame:CGRectMake(15, self.height - 30 - self.titleLabel.height, kScreenWidth - 30, self.titleLabel.height)];
}

@end