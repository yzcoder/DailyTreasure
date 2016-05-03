//
//  YzMianViewController.m
//  DailyTreasure
//
//  Created by 初号机 on 16/4/23.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzDrawerViewController.h"

@interface YzDrawerViewController ()

@property(assign,nonatomic) CGFloat distance;
@property (nonatomic, weak) UIView *homeView;
@property (nonatomic, weak) UIView *leftView;
@property(nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation YzDrawerViewController

#pragma mark - Lazy Load
-(UIView *)homeView {
    if (!_homeView) {
        UIView *view = [[UIView alloc] initWithFrame:kScreenBounds];
        _homeView = view;
        [self.view addSubview:_homeView];
    }
    return _homeView;
}

-(UIView *)leftView {
    if (!_leftView) {
        UIView *view = [[UIView alloc] initWithFrame:kScreenBounds];
        _leftView = view;
        [self.view addSubview:_leftView];
    }
    return _leftView;
}

#pragma mark - INIT
+ (YzDrawerViewController *)creatDrawerViewControllerWithHomeViewController:(UIViewController *)homeViewController leftViewController:(UIViewController *)leftViewController {
    YzDrawerViewController *drawerViewController = [[YzDrawerViewController alloc] initWithHomeViewController:homeViewController leftViewController:leftViewController];
    
    return drawerViewController;
}

- (instancetype)initWithHomeViewController:(UIViewController *)homeViewController leftViewController:(UIViewController *)leftViewController
{
    self = [super init];
    if (self) {
        [self.homeView addSubview:homeViewController.view];
        [self.leftView addSubview:leftViewController.view];
        [self addChildViewController:homeViewController];
        [self addChildViewController:leftViewController];
        [self setLeftAndHomeView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - 辅助逻辑
- (void)setLeftAndHomeView {
    
    _distance = MainViewOriginXFromValue;
    

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.homeView addGestureRecognizer:panGesture];


    self.leftView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue, LeftViewScaleFromValue), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0));
    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [self.view bringSubviewToFront:self.homeView];
}

- (void)tap:(UITapGestureRecognizer *)recongizer {
    [self showMainView];
}

- (void)pan:(UIPanGestureRecognizer *)recongnizer {
    
    CGFloat moveX = [recongnizer translationInView:self.view].x;
    CGFloat truedistance = _distance + moveX;
    CGFloat percent = truedistance/MainViewMoveXMaxValue;
    if (truedistance >= 0 && truedistance <= MainViewMoveXMaxValue) {
        self.homeView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, 1, MainViewScaleYFromValue-MainViewScaleMaxValue*percent), CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXFromValue+truedistance, 0));
        self.leftView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue+LeftViewScaleMaxValue*percent, LeftViewScaleFromValue+LeftViewScaleMaxValue*percent), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue+LeftViewMoveXMaxValue*percent, 0));
    }
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        if (truedistance <= MainViewMoveXMaxValue/2) {
            [self showMainView];
        }else{
            [self showLeftMenuView];
        }
    }
    
}

- (void)showMainView {
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.homeView.transform = CGAffineTransformIdentity;
        self.leftView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, LeftViewScaleFromValue, LeftViewScaleFromValue), CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue, 0));
    } completion:^(BOOL finished) {
        self.distance = MainViewOriginXFromValue;
        [self.homeView removeGestureRecognizer:self.tapGesture];
    }];
}

- (void)showLeftMenuView {
    [UIView animateWithDuration:AnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.homeView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, 1, MainViewScaleYEndValue), CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXEndValue, 0));
        self.leftView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.distance = MainViewOriginXEndValue;
        [self.homeView addGestureRecognizer:self.tapGesture];
    }];
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
