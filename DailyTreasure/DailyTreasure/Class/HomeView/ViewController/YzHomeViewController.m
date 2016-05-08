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

@property (weak, nonatomic) IBOutlet UIView *custonNavBackiView;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic, weak) YzCustomNavView *cusNavView;
@property (nonatomic, strong) UIView *headerView;
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
    self.custonNavBackiView.alpha = 0;
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.homeTableView.tableHeaderView = self.headerView;

    

    /**< 数据源*/
    @weakify(self);
    [[self.homeViewProvider getHomeViewData] subscribeNext:^(NSDictionary *dataSourceDict) {
        @strongify(self);
        
        [self.homeTableView reloadData];
        
        self.topStoryView = [[YzHomeTopStoriesView alloc] initWithModels:[self.homeViewProvider getTopStoriesArray] frame:CGRectMake(0, 0, kScreenWidth, kHomeTopStoriesViewHeight)];
        [self.headerView addSubview:self.topStoryView];
        
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
    self.cusNavView.progress = -scrollView.contentOffset.y/100;

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
