//
//  YzDetailViewController.m
//  DailyTreasure
//
//  Created by Yz on 16/8/1.
//  Copyright © 2016年 Yuz. All rights reserved.
//



#import "YzDetailViewController.h"
#import "YzHomeTopStoriesView.h"

@interface YzDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) YzDetailViewDataProvider *dataProvider;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) StoryView *storyView;
@property (nonatomic, strong) UIView *statusBg;
@property (nonatomic, assign) BOOL isLightContent;
@end

@implementation YzDetailViewController

#pragma mark - Setter & Getter-

-(void)setStoryid:(NSString *)storyid {
    self.dataProvider.storyID = _storyid = storyid;
}

-(void)setIsLightContent:(BOOL)isLightContent {
    _isLightContent = isLightContent;
    self.statusBg.hidden = _isLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
}

-(YzDetailViewDataProvider *)dataProvider {
    if (!_dataProvider) {
        _dataProvider = [[YzDetailViewDataProvider alloc] init];
    }
    return _dataProvider;
}

-(StoryView *)storyView {
    if (!_storyView) {
        _storyView = [[StoryView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
    }
    return _storyView;
}

-(UIView *)statusBg {
    if (!_statusBg) {
        _statusBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _statusBg.backgroundColor = [UIColor whiteColor];
    }
    return _statusBg;
}
#pragma mark - INIT
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView.scrollView.delegate = self;
    [self.webView.scrollView addSubview:self.storyView];
    [self.view addSubview:self.statusBg];
    [self.view bringSubviewToFront:self.statusBg];
    @weakify(self)
    [[self.dataProvider getStoryDetial] subscribeNext:^(id x) {
        @strongify(self);
        self.storyView.imageURL = [self.dataProvider topImageURL];
        [self.webView loadHTMLString:[self.dataProvider detailHTMLString] baseURL:nil];
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (IOS7_OR_LATER) {
        [self.webView.scrollView setContentInset:UIEdgeInsetsZero];
    }
}

#pragma mark - ScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentY = scrollView.contentOffset.y;
    if (contentY < 0) {
        if (contentY >= -90) {
            [self.storyView setFrame:CGRectMake(0, contentY, kScreenWidth, kHomeTopStoriesViewHeight - contentY)];
        }else {
            scrollView.contentOffset = CGPointMake(0, -90);
        }
    }else {
        

    }
    self.isLightContent = contentY < kHomeTopStoriesViewHeight ? YES : NO;
    
}

#pragma mark - 辅助方法

/**< 工具栏返回按钮点击事件*/
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**< 工具栏下一个按钮点击事件*/
- (IBAction)nextAction:(id)sender {
}

/**< 工具栏点赞按钮点击事件*/
- (IBAction)favoriteAction:(id)sender {
}

/**< 工具栏分享按钮点击事件*/
- (IBAction)shareAction:(id)sender {
}

/**< 工具栏评论按钮点击事件*/
- (IBAction)commentAction:(id)sender {
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    if (!self.isLightContent) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

@end
