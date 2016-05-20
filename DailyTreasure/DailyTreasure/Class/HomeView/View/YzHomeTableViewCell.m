//
//  YzHomeTableViewCell.m
//  DailyTreasure
//
//  Created by 初号机 on 16/5/7.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "YzHomeTableViewCell.h"

@interface YzHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellImageViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *multipicImageView;

@end

@implementation YzHomeTableViewCell

+ (YzHomeTableViewCell *)homeTableViewCellWithTableView:(UITableView *)tableView {
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

-(void)setCellProvider:(YzHomeTableViewCellDataProvider *)cellProvider {
    _cellProvider = cellProvider;
    
    self.cellTitleLabel.text = [_cellProvider homeCellStoryTitle];
    
    if ([_cellProvider isTitleWithoutImage]) {
        self.cellImageViewWidth.constant = 0;
    }else {
        [self.cellImageView sd_setImageWithURL:[_cellProvider homeCellImageURL]];
    }
    
    if ([_cellProvider isMultipic]) {
        self.multipicImageView.image = [UIImage imageNamed:@"Home_Morepic"];
        
        self.multipicImageView.hidden = NO;
    }else{
        self.multipicImageView.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
