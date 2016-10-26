//
//  YSQTravelGuideCell.m
//  MyTravel
//
//  Created by ysq on 16/4/29.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQTravelGuideCell.h"
#import "YSQForumDetailModel.h"

@interface YSQTravelGuideCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *see;

@end

@implementation YSQTravelGuideCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"guide";
    YSQTravelGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQTravelGuideCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setDataWithModel:(YSQEntryModel *)model {
    self.title.text = model.title;
    self.username.text = model.username;
    self.time.text = [NSString countTimeFromNow:[NSString stringWithFormat:@"%@",model.publish_time]];
    self.see.text = [NSString stringWithFormat:@"查看: %@",model.views];
    self.comments.text = [NSString stringWithFormat:@"回复: %@",model.replys];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
