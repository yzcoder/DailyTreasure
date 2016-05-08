//
//  YzHomeTableViewCell.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/7.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YzHomeViewDataProvider.h"

@interface YzHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) YzHomeTableViewCellDataProvider *cellProvider;

+ (YzHomeTableViewCell *)homeTableViewCellWithTableView:(UITableView *)tableView;


@end
