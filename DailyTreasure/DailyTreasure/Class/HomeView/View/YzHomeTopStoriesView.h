//
//  YzHomeTopStoriesView.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/8.
//  Copyright © 2016年 Yuz. All rights reserved.
//


#define kHomeTopStoriesViewHeight 300

#import <UIKit/UIKit.h>


@interface YzHomeTopStoriesView : UIView

- (instancetype)initWithModels:(NSArray *)topstoriesModels frame:(CGRect)frame ;

@end

@interface StoryView : UIView

@property (nonatomic, copy) NSURL *imageURL;
@property (nonatomic, copy) NSString *title;

@end