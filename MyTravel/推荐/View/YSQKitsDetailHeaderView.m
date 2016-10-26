//
//  YSQKitsDetailHeaderView.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQKitsDetailHeaderView.h"
#import "YSQKitsDetailModel.h"

@interface YSQKitsDetailHeaderView ()

//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *size;
@property (nonatomic, strong) UILabel *updateTime;
@property (nonatomic, strong) UILabel *download;


@end

@implementation YSQKitsDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCell];
        [self makeConstraints];
    }
    return self;
}

- (void)setDataWithModel:(YSQKitsDetailModel *)model {
    NSNumber *file = model.mobile[@"size"];
    CGFloat fileSize = file.floatValue / 1024.0 /1024.0 ;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/670_446.jpg?%@",model.cover,model.cover_updatetime]];
    [self.imageView setImageWithURL:url options:YYWebImageOptionProgressive];
    self.download.text = [NSString stringWithFormat:@"下载: %@",model.download];
    self.size.text = [NSString stringWithFormat:@"大小:  %.1f M",fileSize];
    self.updateTime.text = [NSString stringWithFormat:@"更新时间: %@",[NSString formatterTime:[NSNumber numberWithInteger:model.update_time.integerValue]]];
}


- (void)createCell {
    self.imageView = [[UIImageView alloc]initWithFrame:self.frame];
    self.imageView.backgroundColor = YSQGray;
    [self addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.size = [UILabel new];
    self.size.textColor = [UIColor whiteColor];
    self.size.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:self.size];
    
    self.updateTime = [UILabel new];
    self.updateTime.textColor = [UIColor whiteColor];
    self.updateTime.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:self.updateTime];
    
    self.download = [UILabel new];
    self.download.textColor = [UIColor whiteColor];
    self.download.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:self.download];
}

- (void)makeConstraints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
    }];
    
    [self.size mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.updateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.size.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [self.download mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.updateTime.mas_right).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
}

@end
