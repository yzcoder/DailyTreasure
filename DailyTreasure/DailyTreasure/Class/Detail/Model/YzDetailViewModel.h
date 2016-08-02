//
//  YzDetailViewModel.h
//  DailyTreasure
//
//  Created by Yz on 16/8/2.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YzRecommenderModel.h"

@interface YzDetailViewModel : NSObject
/**< HTML 格式的新闻*/
@property (nonatomic, copy) NSString *body;
/**< 图片的内容提供方*/
@property (nonatomic, copy) NSString *image_source;
/**< 标题*/
@property (nonatomic, copy) NSString *title;
/**< 获得的图片*/
@property (nonatomic, copy) NSString *image;
/**< 供在线查看内容与分享至 SNS 用的 URL*/
@property (nonatomic, copy) NSString *share_url;
/**< 新闻的 id*/
@property (nonatomic, copy) NSString *storyid;
/**< 供手机端的 WebView(UIWebView) 使用*/
@property (nonatomic, copy) NSString *css;
/**推荐者*/
@property (nonatomic,strong) NSArray<YzRecommenderModel *> *recommenders;
/**html  供手机端的 WebView(UIWebView) 使用*/
@property (nonatomic, copy) NSString *htmlStr;


+ (instancetype)detailModelWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;




@end
