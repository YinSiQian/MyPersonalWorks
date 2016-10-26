//
//  YSQBBSContentViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/18.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBBSContentViewController.h"
#import "BBSViewController.h"
#import "YSQHotBBSViewController.h"
#import "YSQSearchFriendsViewController.h"
#import "YSQSearchController.h"
#import "YSQNavgationController.h"
@interface YSQBBSContentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISegmentedControl *segment;
@end

@implementation YSQBBSContentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQGreenColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSubviews];
    [self createSegment];
    [self createNavItem];
    [self createColletionView];
}

- (void)createNavItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(willStartSearch)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)willStartSearch {
    YSQSearchController *search = [[YSQSearchController alloc]init];
     YSQNavgationController *nav = [[YSQNavgationController alloc]initWithRootViewController:search];
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)createSegment {
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"热议",@"进入版面",@"找旅伴"]];
    _segment.backgroundColor = [UIColor clearColor];
    _segment.tintColor = [UIColor whiteColor];
    _segment.selectedSegmentIndex = 0;
    _segment.layer.cornerRadius = 4;
    _segment.layer.masksToBounds = YES;
    [_segment addTarget:self action:@selector(changedSelectedIndex) forControlEvents:UIControlEventValueChanged];
    self.navigationController.navigationBar.topItem.titleView = _segment;
}

- (void)changedSelectedIndex {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_segment.selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


- (void)createSubviews {
    YSQHotBBSViewController *hot = [[YSQHotBBSViewController alloc]init];
    [self addChildViewController:hot];
    
    BBSViewController *bbs = [[BBSViewController alloc]init];
    [self addChildViewController:bbs];

    YSQSearchFriendsViewController *friend = [[YSQSearchFriendsViewController alloc]init];
    [self addChildViewController:friend];

}

- (void)createColletionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(WIDTH, HEIGHT );
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark --UIColletionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseCell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childViewControllers[indexPath.item];
    if ([vc isKindOfClass:[YSQSearchFriendsViewController class]]) {
        vc.view.frame = CGRectMake(0, 54, WIDTH, HEIGHT - 64);
    } else {
        vc.view.frame = CGRectMake(0, 54, WIDTH, CGRectGetHeight(cell.frame));
    }
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //禁止在最侧边滑动.
    NSInteger index = scrollView.contentOffset.x / WIDTH;
    _segment.selectedSegmentIndex = index;
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > 2 * WIDTH) {
        self.collectionView.scrollEnabled = NO;
    } else {
        self.collectionView.scrollEnabled = YES;
    }
}

@end
