//
//  YSQCityChooseView.m
//  MyTravel
//
//  Created by ysq on 16/4/20.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQCityChooseView.h"
#import "YSQChooseTypeModel.h"


@interface YSQCityChooseView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation YSQCityChooseView

+ (instancetype)initWithDataArray:(NSArray *)dataArray {
    YSQCityChooseView *view = [[YSQCityChooseView alloc]init];
    view.dataArray = dataArray;
    return view;
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.490];
        [self addGestureRecongizer];
        self.selectedIndex = 0;
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
        if ([self.delegate respondsToSelector:@selector(changedBarItemStatus)]) {
            [self.delegate changedBarItemStatus];
        }
    }];
    tag.delegate = self;
    [self addGestureRecognizer:tag];
}


- (void)createTableView {
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH / 2, 320) style:UITableViewStylePlain];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH / 2, 0, WIDTH / 2, 320) style:UITableViewStylePlain];
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    [self addSubview:self.rightTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        return self.dataArray.count;
    } else {
        YSQPoiModel *model = self.dataArray[self.selectedIndex];
        return model.country.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"left"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"left"];
        }
        YSQPoiModel *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.continent_name;
        cell.textLabel.font = YSQSamllFont;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"right"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"right"];
        }
        YSQPoiModel *poiModel = self.dataArray[self.selectedIndex];
        YSQCountryModel *model = poiModel.country[indexPath.row];
        cell.textLabel.text = model.country_name;
        cell.textLabel.font = YSQSamllFont;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:YES];
    if (self.leftTableView == tableView) {
         self.selectedIndex = indexPath.row;
        [self.rightTableView reloadData];
    } else {
        YSQPoiModel *poiModel = self.dataArray[self.selectedIndex];
        YSQCountryModel *model = poiModel.country[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(sendCityValue:countryID:)]) {
            [self.delegate sendCityValue:poiModel.continent_id countryID:model.country_id];
        }
    }
}

#pragma mark ---UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

@end
