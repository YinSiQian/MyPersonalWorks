//
//  YSQKitsCell.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQKitsCell.h"
#import "YSQKitsModel.h"

@interface YSQKitsCell ()

@property (nonatomic, strong) UIImageView *image;

@end

@implementation YSQKitsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)setDataWithModel:(YSQGuidesModel *)model {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/670_446.jpg?%@",model.cover,model.cover_updatetime]];
    [self.image setImageWithURL:url options:YYWebImageOptionProgressive];
}

- (void)createCell {
    self.image = [UIImageView new];
    self.image.backgroundColor = YSQGray;
//    self.image.image = [UIImage imageNamed:@"coverbg"];
    [self.contentView addSubview:self.image];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
    }];
}

@end
