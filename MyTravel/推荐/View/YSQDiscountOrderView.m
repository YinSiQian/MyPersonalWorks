//
//  YSQDiscountOrderView.m
//  MyTravel
//
//  Created by ysq on 16/4/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQDiscountOrderView.h"
#import "YSQChooseTypeModel.h"

@interface YSQDiscountOrderView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *modelArr;
@end

@implementation YSQDiscountOrderView

static NSString *salesDesc = @"salesDesc";//按销量排序
static NSString *priceAsc = @"priceAsc";   //按价格升序
static NSString *priceDesc = @"priceDesc";//按价格降序
static NSString *in24 = @"in24";              //最新
static NSString *Default = @"default";        //默认

static NSString *reuse = @"cell";

+ (instancetype)initWithTitlesArray:(NSArray *)arr {
    YSQDiscountOrderView *order = [[YSQDiscountOrderView alloc]init];
    order.titleArr = arr;
    return order;
}

+ (instancetype)initWithModelArray:(NSArray *)modelArray {
    YSQDiscountOrderView *order = [[YSQDiscountOrderView alloc]init];
    order.modelArr = modelArray;
    return order;
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.490];
        [self addGestureRecongizer];
        [self createTableView];
    }
    return self;
}

- (void)addGestureRecongizer {
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        self.frame = CGRectMake(0, -HEIGHT, WIDTH, HEIGHT);
        CATransition *transition = [CATransition animation];
        transition.startProgress = 0.2;
        transition.endProgress = 1;
        transition.type = @"fade";
        transition.duration = 0.3;
        [self.layer addAnimation:transition forKey:nil];
        if ([self.statusDelegate respondsToSelector:@selector(changedButtonSelected)]) {
            [self.statusDelegate changedButtonSelected];
        }
    }];
    tag.delegate = self;
    [self addGestureRecognizer:tag];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, [self countTableViewHeight]) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

#pragma mark --UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr ? self.titleArr.count : self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.font = YSQSamllFont;
    if (self.titleArr) {
        cell.textLabel.text = self.titleArr[indexPath.row];
    }
    if (self.modelArr) {
        if ([self.modelArr[0] isKindOfClass:[YSQTypeModel class]]) {
            YSQTypeModel *model = self.modelArr[indexPath.row];
            cell.textLabel.text = model.catename;
        } else if ([self.modelArr[0] isKindOfClass:[YSQDepartureModel class]]) {
            YSQDepartureModel *model = self.modelArr[indexPath.row];
            cell.textLabel.text = model.city_des;
        } else if ([self.modelArr[0] isKindOfClass:[YSQTimesModel class]]) {
            YSQTimesModel *model = self.modelArr[indexPath.row];
            cell.textLabel.text = model.Description;
        }
    }
    return cell;
}

#pragma mark --UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (int index = 0; index < (self.titleArr ? self.titleArr.count : self.modelArr.count); index ++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if (index == indexPath.row) {
            cell.textLabel.textColor = [UIColor redColor];
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    if ([self.dataSource respondsToSelector:@selector(sendDataInDict:)]) {
        [self.dataSource sendDataInDict:@{@"value": self.modelArr[indexPath.row]}];
        return;
    }
    switch (indexPath.row) {
        case 0: [self responseFunctionWithType:Default];
            break;
        case 1: [self responseFunctionWithType:salesDesc];
            break;
        case 2: [self responseFunctionWithType:priceAsc];
            break;
        case 3: [self responseFunctionWithType:priceDesc];
            break;
        case 4: [self responseFunctionWithType:in24];
            break;
        default:
            break;
    }
}

- (void)responseFunctionWithType:(NSString *)type {
    if ([self.delegate respondsToSelector:@selector(orderDiscountInfoWithType:)]) {
        [self.delegate orderDiscountInfoWithType:type];
    }
}

#pragma mark ---UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (CGFloat)countTableViewHeight {
    if (self.modelArr || self.titleArr.count > 9) {
        return 9 * 40;
    }
    return self.titleArr.count * 40;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    self.tableView.height = [self countTableViewHeight];
    [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    self.tableView.height = [self countTableViewHeight];
    [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
