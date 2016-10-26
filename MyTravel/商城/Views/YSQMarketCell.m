//
//  YSQMarketCell.m
//  MyTravel
//
//  Created by ysq on 16/8/31.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQMarketCell.h"
#import "YSQMallMarketModel.h"

@interface YSQMarketCell ()

@property (weak, nonatomic) IBOutlet UIButton *bigPic;

@property (weak, nonatomic) IBOutlet UIButton *topPic;
@property (weak, nonatomic) IBOutlet UIButton *bottomPic;

@end

@implementation YSQMarketCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"market";
    YSQMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQMarketCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    if (_modelArr.count > 0) {
        [self setDataWithArr:_modelArr];
    }
}

- (void)setDataWithArr:(NSArray *)modelArr {
    YSQMallMarketModel *model1 = modelArr.firstObject;
    [self.bigPic setBackgroundImageWithURL:[NSURL URLWithString:model1.pic] forState:UIControlStateNormal options:YYWebImageOptionProgressive];
    YSQMallMarketModel *model2 = modelArr[1];
    [self.topPic setBackgroundImageWithURL:[NSURL URLWithString:model2.pic] forState:UIControlStateNormal options:YYWebImageOptionProgressive];    YSQMallMarketModel *model3 = modelArr.lastObject;
    [self.bottomPic setBackgroundImageWithURL:[NSURL URLWithString:model3.pic] forState:UIControlStateNormal options:YYWebImageOptionProgressive];
}

- (IBAction)bigAction:(id)sender {
    YSQMallMarketModel *model = _modelArr.firstObject;
    [self responseFunction:model.url];
}

- (IBAction)topAction:(id)sender {
    YSQMallMarketModel *model = _modelArr[1];
    [self responseFunction:model.url];
}

- (IBAction)bottomAction:(id)sender {
    YSQMallMarketModel *model = _modelArr.lastObject;
    [self responseFunction:model.url];
}

- (void)responseFunction:(NSString *)url {
    if ([self.delegate respondsToSelector:@selector(seeRecommend:)]) {
        [self.delegate seeRecommend:url];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
