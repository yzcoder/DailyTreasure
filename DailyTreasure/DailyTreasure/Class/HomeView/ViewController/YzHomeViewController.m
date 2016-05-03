//
//  YzHomeViewController.m
//  DailyTreasure
//
//  Created by 初号机 on 16/4/23.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzHomeViewController.h"
#import "YzCustomNavView.h"
@interface YzHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *custonNavBackiView;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic, weak) YzCustomNavView *cusNavView;

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


#pragma mark - INIT -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = kScreenBounds;
    
    [self.view bringSubviewToFront:self.cusNavView];
    
    @weakify(self);
    [RACObserve(self.homeTableView, contentOffset) subscribeNext:^(id x) {
        @strongify(self);
        self.custonNavBackiView.alpha = 1 - self.homeTableView.contentOffset.y/100;
        
//        if (self.homeTableView.contentOffset.y < 0) {
          self.cusNavView.progress = -self.homeTableView.contentOffset.y/100;
//        }
     
     }];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = @"测试";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



@end
