//
//  YzDetailViewController.m
//  DailyTreasure
//
//  Created by Yz on 16/8/1.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzDetailViewController.h"

@interface YzDetailViewController ()
@property (nonatomic, strong) YzDetailViewDataProvider *dataProvider;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation YzDetailViewController

#pragma mark - Setter & Getter-

-(void)setStoryid:(NSString *)storyid {
    self.dataProvider.storyID = _storyid = storyid;
}

-(YzDetailViewDataProvider *)dataProvider {
    if (!_dataProvider) {
        _dataProvider = [[YzDetailViewDataProvider alloc] init];
    }
    return _dataProvider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.dataProvider getStoryDetial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
