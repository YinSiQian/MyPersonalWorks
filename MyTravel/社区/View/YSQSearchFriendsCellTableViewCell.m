//
//  YSQSearchFriendsCellTableViewCell.m
//  MyTravel
//
//  Created by ysq on 16/6/17.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQSearchFriendsCellTableViewCell.h"
#import "YSQCompanyModel.h"

@interface YSQSearchFriendsCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *contents;
@property (weak, nonatomic) IBOutlet UILabel *publishInfo;
@property (weak, nonatomic) IBOutlet UILabel *reply;
@property (weak, nonatomic) IBOutlet UILabel *counts;

@end

@implementation YSQSearchFriendsCellTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"search";
    YSQSearchFriendsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQSearchFriendsCellTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setDataWithModel:(YSQCompanyModel *)model {
    self.time.text = [NSString stringWithFormat:@"%@ - %@ |",[NSString formatterTime:model.start_time],[NSString formatterTime:model.end_time]];
    self.address.text = model.citys_str;
    self.contents.text = model.title;
    self.publishInfo.text = [NSString stringWithFormat:@"%@ | %@",model.username,[NSString countTimeFromNow:model.publish_time.stringValue]];
    self.reply.text = [NSString stringWithFormat:@"%@",model.replys];
    self.counts.text = [NSString stringWithFormat:@"%@",model.views];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.time.font = [UIFont boldSystemFontOfSize:12];
    self.address.font = [UIFont boldSystemFontOfSize:12];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
