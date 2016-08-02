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
#import "YzDetailViewController.h"


#define kTableHeaderViewHeight 180
#define kTableViewCellHeight 88


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
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kTableHeaderViewHeight)];
    
    self.homeTableView.tableHeaderView = view;
    self.homeTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    self.topStoryView = [[YzHomeTopStoriesView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, kHomeTopStoriesViewHeight)];
//    self.topStoryView.clipsToBounds = YES;
    [self.homeTableView addSubview:self.topStoryView];
    

    
    

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

    CGPoint scrollContent = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 20);
    self.custonNavBackiView.alpha = scrollContent.y/100 - 1;
    self.cusNavView.progress = -scrollContent.y/40;
    
    if (scrollContent.y < 0 && scrollContent.y >= -80) {
        
        self.topStoryView.frame = CGRectMake(0, - fabs(scrollContent.y) - 20, kScreenWidth, kHomeTopStoriesViewHeight+ fabs(scrollContent.y));
        
    }else
        
        self.topStoryView.frame = CGRectMake(0, -20, kScreenWidth, kHomeTopStoriesViewHeight);
    
        if (scrollView.contentOffset.y < -80) {
            scrollView.contentOffset = CGPointMake(0, -80);
        }
    
    if (scrollView.contentSize.height - scrollContent.y <= kScreenHeight) {
        if (!self.homeViewProvider.isLoading) {
            [[self.homeViewProvider getPreviousStories] subscribeNext:^(id x) {
                [self.homeTableView reloadData];
            }];
        }
    }
    if ([self.homeViewProvider numberOfRowsInSection:0] != -1) {
        if (scrollContent.y > [self.homeViewProvider numberOfRowsInSection:0] * kTableViewCellHeight + kTableHeaderViewHeight) {
            self.custonNavBackiView.top = -44;
            self.cusNavView.customNavViewTitleLabel.hidden = YES;
        }else {
            self.custonNavBackiView.top = 0;
            self.cusNavView.customNavViewTitleLabel.hidden = NO;
        }
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
    return kTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.bounds];
    [view addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [self.homeViewProvider headerTitleForSection:section];
    view.backgroundColor = kColorHex(0x30C5FF);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YzDetailViewController *detailVC = [[YzDetailViewController alloc] init];
    detailVC.storyid = [[self.homeViewProvider cellProviderAtIndexPath:indexPath] homeCellStoryID];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}


@end
