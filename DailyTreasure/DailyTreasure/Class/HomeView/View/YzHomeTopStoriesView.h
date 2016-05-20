//
//  YzHomeTopStoriesView.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/8.
//  Copyright © 2016年 Yuz. All rights reserved.
//


#define kHomeTopStoriesViewHeight 300

#import <UIKit/UIKit.h>
#import "YzHomeViewDataProvider.h"

@interface YzHomeTopStoriesView : UIView
@property (nonatomic, strong) NSArray <YzHomeTopDataProvider *>*topstoriesModels;

@end

@interface StoryView : UIView

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, copy) NSURL *imageURL;
@property (nonatomic, copy) NSString *title;

@end