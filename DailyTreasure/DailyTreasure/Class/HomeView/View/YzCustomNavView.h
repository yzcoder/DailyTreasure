//
//  YzHomeCusNavView.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YzCustomNavView : UIView
@property (weak, nonatomic) IBOutlet UIButton *customNavViewLeftButtonItem;
@property (weak, nonatomic) IBOutlet UILabel *customNavViewTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *customNavViewProgressView;
@property (weak, nonatomic) IBOutlet UIButton *customNavViewRightButtonItem;

@property (nonatomic, assign) CGFloat progress;
@end


@interface YzCusProgressView : UIView

- (void)redrawWithProgress:(CGFloat)progress;
- (void)startAnimation;
- (void)stopAnimation;

@end