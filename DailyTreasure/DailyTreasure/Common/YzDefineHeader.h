//
//  YzDefineHeader.h
//  DailyTreasure
//
//  Created by 初号机 on 16/5/2.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#ifndef YzDefineHeader_h
#define YzDefineHeader_h


#import "YzAppDelegate.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds
#define kAppdelegate  (YzAppDelegate *)[UIApplication sharedApplication].delegate;

/**< network*/

#define kBaseURL @"http://news-at.zhihu.com/api/4"
#define kGetLaunchImageURL @"start-image/720*1184"
#define kGetHomeStories @"news/latest"
#define kGetHistoryStories @"news/before/"




#define kLaunchViewImageURL @"LaunchViewImageURL"



#endif /* YzDefineHeader_h */
