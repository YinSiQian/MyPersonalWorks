//
//  MTBannerCell.m
//  MyTravel
//
//  Created by ysq on 16/1/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBannerCell.h"
#import "YSQRecommendModel.h"
#import "YSQSlideModel.h"

@interface YSQBannerCell ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *see;

@property (weak, nonatomic) IBOutlet UIButton *garb;
@property (weak, nonatomic) IBOutlet UIButton *book;
@property (weak, nonatomic) IBOutlet UIButton *travel;

@property (nonatomic, strong) NSMutableArray *urlArray;
@end


@implementation YSQBannerCell


- (void)layoutSubviews {
    self.see.layer.cornerRadius = 25;
    self.see.layer.masksToBounds = YES;
    self.garb.layer.cornerRadius = 25;
    self.garb.layer.masksToBounds = YES;
    self.book.layer.cornerRadius = 25;
    self.book.layer.masksToBounds = YES;
    self.travel.layer.cornerRadius = 25;
    self.travel.layer.masksToBounds = YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifier = @"reuseIdentifier";
    YSQBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YSQBannerCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setAutoScrollViewWithModel:(YSQRecommendModel *)model {
    NSMutableArray * urlArray = [NSMutableArray array];
    self.urlArray = [NSMutableArray array];
    for (YSQSlideModel  * slide in model.slide) {
        [urlArray addObject:slide.photo];
        [self.urlArray addObject:slide.url];
    }
    SDCycleScrollView * scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, self.scrollView.frame.size.height) imageURLStringsGroup:urlArray];
    scrollview.delegate = self;
    //pagecontroller的几个点的位置
    scrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    //pagecontroller的style
    scrollview.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    scrollview.pageDotColor = [UIColor lightGrayColor];
    scrollview.currentPageDotColor = [UIColor colorWithRed:0.116 green:1.000 blue:0.106 alpha:1.000];
    //滚动时间
    if (urlArray.count==1) {
        scrollview.autoScrollTimeInterval=10000.0;
    }else
        scrollview.autoScrollTimeInterval= 3.0;
    [self.scrollView addSubview:scrollview];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSString *url = self.urlArray[index];
    if ([self.delegate respondsToSelector:@selector(goToBannerDetailWithURL:)]) {
        [self.delegate goToBannerDetailWithURL:url];
    }
}

- (IBAction)see:(id)sender {
    [self responseFunctionWithType:YSQTravelStrategyService];
}

- (IBAction)qiang:(id)sender {
    [self responseFunctionWithType:YSQTravelDiscountService];
}

- (IBAction)book:(id)sender {
    
}

- (IBAction)location:(id)sender {
    [self responseFunctionWithType:YSQTravelLocationService];
}

- (void)responseFunctionWithType:(YSQTraveServiceType)type {
    if ([self.delegate respondsToSelector:@selector(seeTravelService:)]) {
        [self.delegate seeTravelService:type];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
