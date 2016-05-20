//
//  YzMianViewController.h
//  DailyTreasure
//
//  Created by 初号机 on 16/4/23.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <UIKit/UIKit.h>


//打开抽屉动画参数初始值
#define AnimateDuration             0.2
#define MainViewOriginXFromValue    0
#define MainViewOriginXEndValue     kScreenWidth*0.6
#define MainViewMoveXMaxValue       ABS(MainViewOriginXEndValue - MainViewOriginXFromValue)
#define MainViewScaleYFromValue     1
#define MainViewScaleYEndValue      1
#define MainViewScaleMaxValue       ABS(MainViewScaleYEndValue - MainViewScaleYFromValue)
#define LeftViewOriginXFromValue    -kScreenWidth*0.6
#define LeftViewOriginXEndValue     0
#define LeftViewMoveXMaxValue       ABS(LeftViewOriginXEndValue - LeftViewOriginXFromValue)
#define LeftViewScaleFromValue      1
#define LeftViewScaleEndValue       1
#define LeftViewScaleMaxValue       ABS(LeftViewScaleEndValue - LeftViewScaleFromValue)



@interface YzDrawerViewController : UIViewController

+ (YzDrawerViewController *)creatDrawerViewControllerWithHomeViewController:(UIViewController *)homeViewController leftViewController:(UIViewController *)leftViewController;
- (void)showMainView;
- (void)showLeftMenuView;
@end
