//
//  YzHomeViewController.m
//  DailyTreasure
//
//  Created by 初号机 on 16/4/23.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzHomeViewController.h"
#import "YzHomeViewDataProvider.h"
#import "YzHomeTableViewCell.h"
#import "YzCustomNavView.h"
#import "YzHomeTopStoriesView.h"



@interface YzHomeViewController ()<UITableViewDataSource, UITableViewDelegate ,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (weak, nonatomic) IBOutlet UIView *custonNavBackiView;


@property (nonatomic, weak) YzCustomNavView *cusNavView;
@property (nonatomic, strong) YzHomeTopStoriesView *topStoryView;
@property (nonatomic, strong) YzHomeViewDataProvider *homeViewProvider;

@property (nonatomic, strong) NSArray *topStoriesArray;
@property (nonatomic, strong) NSArray *storiesArray;
@end

@implementation YzHomeViewController

#pragma mark - Lazy Load

-(YzCustomNavView *)cusNavView {
    if (!_cusNavView) {
        YzCustomNavView *cusNavView = [[NSBundle mainBundle] loadNibNamed:@"YzCustomNavView" owner:nil options:nil][0];
        cusNavView.frame = CGRectMake(0, 0, kScreenWidth, 64);
        [self.view addSubview:cusNavView];
        _cusNavView = cusNavView;
    }
    return _cusNavView;
}

-(YzHomeViewDataProvider *)homeViewProvider {
    if (!_homeViewProvider) {
        _homeViewProvider = [[YzHomeViewDataProvider alloc] init];
    }
    return _homeViewProvider;
}



-(NSArray *)storiesArray {
    if (!_storiesArray) {
        _storiesArray = [NSArray array];
    }
    return _storiesArray;
}

-(NSArray *)topStoriesArray {
    if (!_topStoriesArray) {
        _topStoriesArray = [NSArray array];
    }
    return _topStoriesArray;
}


#pragma mark - INIT -



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = kScreenBounds;
    
    
    
    
    [self.view bringSubviewToFront:self.cusNavView];
    [self.cusNavView.customNavViewLeftButtonItem setImage:[UIImage imageNamed:@"Home_Icon"] forState:(UIControlStateNormal)];
    self.cusNavView.customNavViewTitleLabel.text = @"今日新闻";
    [[self.cusNavView.customNavViewLeftButtonItem rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        YzAppDelegate *appDelegate = kAppdelegate;
        [appDelegate.drawerViewController showLeftMenuView];
    }];
    self.custonNavBackiView.alpha = 0;
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,200)];
    
    self.homeTableView.tableHeaderView = view;
    
    
    self.topStoryView = [[YzHomeTopStoriesView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight -100 )];
//    self.topStoryView.clipsToBounds = YES;
    [self.homeTableView addSubview:self.topStoryView];
    self.topStoryView.backgroundColor = [UIColor orangeColor];
    

    
    

    /**< 数据源*/
    @weakify(self);
    [[self.homeViewProvider getHomeViewData] subscribeNext:^(NSDictionary *dataSourceDict) {
        @strongify(self);
        
        [self.homeTableView reloadData];
        
        self.topStoryView.topstoriesModels = [self.homeViewProvider getTopStoriesArray];
        
    } error:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.custonNavBackiView.alpha = scrollView.contentOffset.y/100 - 1;
    self.cusNavView.progress = -scrollView.contentOffset.y/40;
    
    if (scrollView.contentOffset.y < 0 && scrollView.contentOffset.y >= -80) {
//        self.topStoryView.top = - fabs(scrollView.contentOffset.y);
//        self.topStoryView.height = 200 + fabs(scrollView.contentOffset.y);
        
        self.topStoryView.frame = CGRectMake(0, - fabs(scrollView.contentOffset.y), kScreenWidth, 200 + fabs(scrollView.contentOffset.y));
    }else
        if (scrollView.contentOffset.y < -80) {
        scrollView.contentOffset = CGPointMake(0, -80);
    }
    
    if (scrollView.contentSize.height - scrollView.contentOffset.y <= kScreenHeight) {
        [[self.homeViewProvider getPreviousStories] subscribeNext:^(id x) {
            [self.homeTableView reloadData];
        }];
    }
}


#pragma mark - UITableViewDelegate & UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.homeViewProvider numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.homeViewProvider numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YzHomeTableViewCell *cell = [YzHomeTableViewCell homeTableViewCellWithTableView:tableView];
    cell.cellProvider = [self.homeViewProvider cellProviderAtIndexPath:indexPath];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}



@end
