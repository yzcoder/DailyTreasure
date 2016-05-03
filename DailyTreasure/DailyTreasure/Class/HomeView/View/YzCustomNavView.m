//
//  YzHomeCusNavView.m
//  DailyTreasure
//
//  Created by 初号机 on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzCustomNavView.h"

@interface YzCustomNavView ()

@property (nonatomic, strong) YzCusProgressView *cusProgressView;

@end
@implementation YzCustomNavView

-(void)setProgress:(CGFloat)progress {
    _progress = progress;
    [_cusProgressView redrawWithProgress:_progress];
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.cusProgressView = [[YzCusProgressView alloc] initWithFrame:CGRectMake(0, 0, self.customNavViewProgressView.width, self.customNavViewProgressView.height)];
    [self.customNavViewProgressView addSubview:self.cusProgressView];
}

@end




@interface YzCusProgressView ()
@property (strong,nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong,nonatomic) CAShapeLayer *whiteCircleLayer;
@property (strong,nonatomic) CAShapeLayer *grayCircleLayer;
@end
@implementation YzCusProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_indicatorView];
        
        CGFloat radius = MIN(frame.size.width, frame.size.height)/2-3;
        _grayCircleLayer = [[CAShapeLayer alloc] init];
        _grayCircleLayer.lineWidth = 0.5f;
        _grayCircleLayer.strokeColor = [UIColor grayColor].CGColor;
        _grayCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _grayCircleLayer.opacity = 0.f;
        _grayCircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.width/2-radius, self.height/2-radius, 2*radius, 2*radius)].CGPath;
        [self.layer addSublayer:_grayCircleLayer];
        
        _whiteCircleLayer = [[CAShapeLayer alloc] init];
        _whiteCircleLayer.lineWidth = 2.f;
        _whiteCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _whiteCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _whiteCircleLayer.strokeEnd = 0.f;
        _whiteCircleLayer.opacity = 0.f;
        _whiteCircleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2, self.height/2) radius:radius startAngle:M_PI_2 endAngle:M_PI*5/2 clockwise:YES].CGPath;
        [self.layer addSublayer:_whiteCircleLayer];
    }
    return self;
}

- (void)redrawWithProgress:(CGFloat)progress {
    if (progress>0) {
        _whiteCircleLayer.opacity = 1.f;
        _grayCircleLayer.opacity = 1.f;
    }else if (progress <= 0){
        _whiteCircleLayer.opacity = 0.f;
        _grayCircleLayer.opacity = 0.f;
    }
    _whiteCircleLayer.strokeEnd = progress;
    
}

- (void)startAnimation {
    [_indicatorView startAnimating];
}

- (void)stopAnimation {
    [_indicatorView stopAnimating];
}

@end