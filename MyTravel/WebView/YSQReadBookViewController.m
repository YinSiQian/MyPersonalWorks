//
//  YSQReadBookViewController.m
//  MyTravel
//
//  Created by ysq on 16/6/12.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQReadBookViewController.h"
#import <WebKit/WebKit.h>
#import "YSQHTMLModel.h"
#import "YSQBookCell.h"
#import "YSQBookCoverView.h"
#import "YSQBookListViewController.h"


@interface YSQReadBookViewController ()<UIGestureRecognizerDelegate,UMSocialUIDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *filePaths;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@end

@implementation YSQReadBookViewController

#pragma mark ---懒加载

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)filePaths {
    if (!_filePaths) {
        _filePaths = [NSMutableArray array];
    }
    return _filePaths;
}

#pragma mark ---View life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createCollectionView];
    [self loadData];
    [self loadCover];
    [self createNavItem];
    [self createClickViewTag];
}

#pragma mark --数据处理

- (void)loadData {
    NSString *jsonPath = [self.filePath stringByAppendingPathComponent:@"menu.json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in arr) {
        YSQHTMLModel *model = [YSQHTMLModel modelWithDictionary:dict];
        NSString *path = [self.filePath stringByAppendingPathComponent:model.file];
        [self.filePaths addObject:path];
        [self.dataArray addObject:model];
    }
}

#pragma mark --UI

- (void)create {
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    self.effectView.frame = CGRectMake(0, 0, WIDTH, 64);
    [self.view addSubview:self.effectView];
    [UIColor colorWithHexString:@"21CC5F"];
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 30)];
    titleView.backgroundColor = [UIColor whiteColor];
}

- (void)createClickViewTag {
    __block int tagCount = 0;
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        tagCount++;
        if (tagCount % 2 == 0) {
            self.navigationController.navigationBar.hidden = YES;
        } else {
            self.navigationController.navigationBar.hidden = NO;
        }
    }];
    tag.delegate = self;
    [self.collectionView addGestureRecognizer:tag];
}

- (void)createNavItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(chooseBookPage)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItems = @[backItem,item];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseBookPage {
    YSQBookListViewController *list = [[YSQBookListViewController alloc]init];
    list.dataArray = self.dataArray;
    list.callBack = ^(NSInteger index) {
        [self.collectionView setContentOffset:CGPointMake(index * WIDTH, 1)];
    };
    [self.navigationController pushViewController:list animated:YES];
}

- (void)loadCover {
    YSQBookCoverView *coverView = [[YSQBookCoverView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    NSString *coverPath = [self.filePath stringByAppendingPathComponent:@"coverbg.png"];
    NSString *titlePath = [self.filePath stringByAppendingPathComponent:@"covertitle.png"];
    [coverView loadCoverImage:coverPath titleImage:titlePath];
    [coverView starAnimation:^(YSQBookCoverView *cover) {
        [cover removeFromSuperview];
    }];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(WIDTH, HEIGHT - 20);
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT - 20) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled =YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[YSQBookCell class] forCellWithReuseIdentifier:@"bookCell"];
}


#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YSQBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookCell" forIndexPath:indexPath];
    [cell loadHTMLWithHTMLPath:self.filePaths[indexPath.item] baseURL:self.filePath];
    return cell;
}

#pragma mark --UIGestureRecognizerDelegate


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    return YES;
}


@end
