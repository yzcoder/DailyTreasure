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


#define kColorHex(hexValue) [UIColor colorWithRed:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hexValue & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hexValue & 0xFF))/255.0 alpha:1.0]
#define kColorWithRGB(r, g, b, alp) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:alp]


/**< network*/

#define kBaseURL @"http://news-at.zhihu.com/api/4"
#define kGetLaunchImageURL @"start-image/720*1184"
#define kGetHomeStories @"news/latest"
#define kGetHistoryStories @"news/before/"




#define kLaunchViewImageURL @"LaunchViewImageURL"



#endif /* YzDefineHeader_h */
