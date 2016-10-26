//
//  YSQForumDetailController.m
//  MyTravel
//
//  Created by ysq on 16/3/4.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQForumDetailController.h"
#import "HMSegmentedControl.h"
#import "YSQBaseForumController.h"
#import "YSQForumHeaderView.h"
#import "YSQCustomTableView.h"

@interface YSQForumDetailController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) YSQCustomTableView *tableView;
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, strong) YSQBaseForumController *infoVC;
@property (nonatomic, strong) YSQForumHeaderView *header;
@property (nonatomic, assign) CGFloat offset;

@end

@implementation YSQForumDetailController

#pragma mark ---View life cycle 

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[YSQHelp imageWithBgColor:[UIColor clearColor]]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSegment];
    [self setChildVC];
    [self createColletionView];
    [self createTableView];
    [self.infoVC addObserver:self forKeyPath:@"detailModel" options:NSKeyValueObservingOptionNew context:NULL];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoScrollTableView:) name:@"offset" object:nil];
    
}

- (void)autoScrollTableView:(NSNotification *)noti {
    self.tableView.scrollEnabled = YES;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"detailModel"]) {
        [self.header setDataWithModel:self.infoVC.detailModel];
    }
//    if ([keyPath isEqualToString:@"offset"]) {
//        if (self.infoVC.offset <=140 ) {
//            [self.tableView setContentOffset:CGPointMake(0, self.infoVC.offset) animated:YES];
//        }
//    }
}

- (void)setChildVC {
    self.infoVC = [[YSQBaseForumController alloc]init];
    self.infoVC.urlString = YSQ_BBS_DETAIL_NEW_URL;
    self.infoVC.forum_id = self.ID;
    self.infoVC.cellType = YSQForumNewInfoCell;
    [self addChildViewController:self.infoVC];
    
    YSQBaseForumController *strategy = [[YSQBaseForumController alloc]init];
    strategy.urlString = YSQ_BBS_DETAIL_METHODAll_URL;
    strategy.forum_id = self.ID;
    strategy.cellType = YSQForumTravelGuideCell;
    strategy.isStrategy = YES;
    [self addChildViewController:strategy];
    
    YSQBaseForumController *company = [[YSQBaseForumController alloc]init];
    company.urlString = YSQ_BBS_DETAIL_COMPANY_URL;
    company.forum_id = self.ID;
    company.cellType = YSQForumCompanyCell;
    [self addChildViewController:company];
    
    YSQBaseForumController *ask = [[YSQBaseForumController alloc]init];
    ask.urlString = YSQ_BBS_DETAIL_ASK_URL;
    ask.forum_id = self.ID;
    ask.cellType = YSQForumAskCell;
    [self addChildViewController:ask];
    
    YSQBaseForumController *assign = [[YSQBaseForumController alloc]init];
    assign.urlString = YSQ_BBS_DETAIL_ASSIGN_URL;
    assign.forum_id = self.ID;
    assign.cellType = YSQForumTravelGuideCell;
    [self addChildViewController:assign];

    
}

- (void)createTableView {
    self.tableView = [[YSQCustomTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.header = [[YSQForumHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    self.tableView.tableHeaderView = self.header;
}

- (void)createColletionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(WIDTH, HEIGHT - 100);
    self.colletionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 100 ) collectionViewLayout:layout];
    self.colletionView.delegate = self;
    self.colletionView.dataSource = self;
    self.colletionView.backgroundColor = [UIColor clearColor];
    self.colletionView.pagingEnabled = YES;
    [self.colletionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseCell"];
}

- (void)createSegment {

    self.segment = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"最新",@"攻略",@"结伴",@"问答",@"转让"]];
    self.segment.frame = CGRectMake(0, 64, WIDTH, 40);
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.selectionIndicatorColor = [UIColor colorWithRed:0.059 green:0.784 blue:0.490 alpha:1.000];
    self.segment.selectedSegmentIndex = 0;
    self.segment.selectionIndicatorHeight = 2;
    self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segment.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    self.segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.059 green:0.784 blue:0.490 alpha:1.000]};
    self.segment.borderType = HMSegmentedControlBorderTypeBottom;
    self.segment.borderColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    self.segment.borderWidth = 0.5;
    __weak typeof(self) weakSelf = self;
    [self.segment setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.colletionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [weakSelf.tableView scrollToTop];
    }];
}

#pragma mark --UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT - 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return  self.segment;
;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.contentView addSubview:self.colletionView];
    return cell;
}

#pragma mark --UIColletionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseCell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childViewControllers[indexPath.item];
    vc.view.frame = CGRectMake(0, 0, WIDTH, CGRectGetHeight(cell.frame));
    [cell.contentView addSubview:vc.view];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.colletionView == scrollView) {
        return;
    }
    CGFloat offset=scrollView.contentOffset.y;
    
    CGFloat alpha=1-((64-offset)/64);
    if (offset > 64) {
        alpha = 0.995792;
        [YSQHelp clearNavShadow:self isClear:NO];
    } else {
        [YSQHelp clearNavShadow:self isClear:YES];
    }
    if (offset > 144) {
        //[self.tableView setContentOffset:CGPointMake(0, 64) animated:NO];
        self.tableView.scrollEnabled = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enableScroll" object:nil];
    }
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(alpha)] forBarMetrics:UIBarMetricsDefault];
    if (scrollView == self.tableView) {
        [(YSQForumHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}


- (void)dealloc {
    [self.infoVC removeObserver:self forKeyPath:@"detailModel"];
    //[self.infoVC removeObserver:self forKeyPath:@"offset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
@end
