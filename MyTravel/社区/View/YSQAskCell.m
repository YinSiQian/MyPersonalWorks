//
//  YSQAskCell.m
//  MyTravel
//
//  Created by ysq on 16/4/29.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQAskCell.h"
#import "YSQAskModel.h"
#import "YSQCompanyModel.h"

@interface YSQAskCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *reply;
@property (weak, nonatomic) IBOutlet UILabel *ask;

@end


@implementation YSQAskCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"ask";
    YSQAskCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQAskCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setDataWithModel:(YSQAskModel *)model {
    self.title.text = model.title;
    self.content.text = model.content;
    self.username.text = model.author;
    self.time.text = [NSString countTimeFromNow:[NSString stringWithFormat:@"%@",model.add_time]];
    self.ask.text = [NSString stringWithFormat:@"同问: %@",model.ask_num];
    self.reply.text = [NSString stringWithFormat:@"回答: %@",model.answer_num];
}

- (void)setDataWithCMModel:(YSQCompanyModel *)model {
    self.title.text = [NSString stringWithFormat:@"%@ - %@ |",[NSString formatterTime:model.start_time],[NSString formatterTime:model.end_time]];
    self.content.text = model.title;
    self.username.text = model.username;
    self.time.text = [NSString countTimeFromNow:[NSString stringWithFormat:@"%@",model.publish_time]];
    self.ask.text = [NSString stringWithFormat:@"%@",model.views];
    self.reply.text = [NSString stringWithFormat:@"%@",model.replys];
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
