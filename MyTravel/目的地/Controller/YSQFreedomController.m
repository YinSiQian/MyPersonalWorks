//
//  YSQFreedomController.m
//  MyTravel
//
//  Created by ysq on 16/3/24.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQFreedomController.h"
#import "HMSegmentedControl.h"
#import "YSQFreeChildViewController.h"

@interface YSQFreedomController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YSQFreeChildViewController *leftChild;
@property (nonatomic, strong) YSQFreeChildViewController *rightChild;
@property (nonatomic, strong) HMSegmentedControl *segment;

@end

@implementation YSQFreedomController

#pragma mark ---懒加载

- (YSQFreeChildViewController *)leftChild {
    if (!_leftChild) {
        self.leftChild = [[YSQFreeChildViewController alloc]init];
        self.leftChild.type = @"tickets_freewalker";
        self.leftChild.ID = self.ID;
        self.leftChild.datatype = self.type;
        self.leftChild.productType = @"10162C10182C1020";
        [self addChildViewController:self.leftChild];
        self.leftChild.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 40 - 64);
      }
    return _leftChild;
}

- (YSQFreeChildViewController *)rightChild {
    if (!_rightChild) {
        self.rightChild = [[YSQFreeChildViewController alloc]init];
        self.rightChild.type = @"local_discount";
        self.rightChild.ID = self.ID;
        self.rightChild.productType = @"2410";
        self.rightChild.datatype = self.type;
        [self addChildViewController:self.rightChild];
        self.rightChild.view.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 40 - 64);
    }
    return _rightChild;
}


#pragma mark ---view life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createSegment];
    [self createScrollView];
    [self createDataView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --UI 

- (void)createSegment {
    self.segment = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"超值自由行",@"精彩当地游"]];
    self.segment.frame = CGRectMake(0, 64, WIDTH, 40);
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.selectionIndicatorColor = [UIColor redColor];
    self.segment.selectedSegmentIndex = self.selectedIndex;
    self.segment.selectionIndicatorHeight = 2;
    self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segment.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    self.segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.059 green:0.784 blue:0.490 alpha:1.000]};
    self.segment.borderType = HMSegmentedControlBorderTypeBottom;
    self.segment.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.segment.borderWidth = 0.5;
    [self.view addSubview:self.segment];
    __weak typeof(self) weakSelf = self;
    [self.segment setIndexChangeBlock:^(NSInteger index) {
        if (index == 1) {
            [weakSelf.scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:YES];
            [weakSelf.scrollView addSubview:weakSelf.rightChild.view];
        } else {
            [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            [weakSelf.scrollView addSubview:weakSelf.leftChild.view];
        }
    }];
}


- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40 + 64, WIDTH,HEIGHT - 40 - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(WIDTH * 2, 0);
    [self.view addSubview:self.scrollView];
}

- (void)createDataView {
    if (self.selectedIndex == 0) {
        [self.scrollView addSubview:self.leftChild.view];
    } else if (self.selectedIndex == 1) {
        [self.scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:NO];
        [self.scrollView addSubview:self.rightChild.view];
    }
}

@end
