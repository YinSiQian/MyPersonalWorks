//
//  YSQStrategyDetailController.m
//  MyTravel
//
//  Created by ysq on 16/4/26.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQStrategyDetailController.h"
#import "YSQKitsIntroCell.h"
#import "YSQAuthorInfoCell.h"
#import "YSQRelatedCell.h"
#import "YSQKitsDetailHeaderView.h"
#import "YSQTitleHeaderView.h"
#import "YSQKitsDetailModel.h"
#import "ZipArchive.h"
#import "YSQReadBookViewController.h"


@interface YSQStrategyDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YSQKitsDetailModel *detailModel;
@property (nonatomic, strong) NSMutableArray *cellHeightArr;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIView *downInfoView;
@property (nonatomic, strong) UILabel *speed;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, assign) BOOL isdownloaded;
@property (nonatomic, assign) BOOL isDownloading;


@end

@implementation YSQStrategyDetailController

#pragma mark ---懒加载

- (NSMutableArray *)cellHeightArr {
    if (!_cellHeightArr) {
        _cellHeightArr = [NSMutableArray array];
    }
    return _cellHeightArr;
}

- (UIView *)downInfoView {
    if (!_downInfoView) {
        _downInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        _downInfoView.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000];
        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 19, WIDTH - 70, 2)];
        self.progressView.progressViewStyle = UIProgressViewStyleDefault;
        self.progressView.progressTintColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
        self.progressView.trackTintColor = [UIColor greenColor];
        [_downInfoView addSubview:self.progressView];
        
        self.speed = [[UILabel alloc]initWithFrame:CGRectMake((_downInfoView.width - 200) / 2, _downInfoView.height - 10, 200, 10)];
        self.speed.textColor = [UIColor whiteColor];
        self.speed.textAlignment  = NSTextAlignmentCenter;
        self.speed.font = [UIFont systemFontOfSize:8];
        [_downInfoView addSubview:self.speed];
        
        UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 50, 0, 30, 40)];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        cancel.titleLabel.font = YSQNormalFont;
        [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelDownload:) forControlEvents:UIControlEventTouchUpInside];
        [_downInfoView addSubview:cancel];
    }
    return _downInfoView;
}

#pragma mark --- view lift cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[YSQHelp imageWithBgColor:[UIColor clearColor]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"progress"]) {
        [self.progressView setProgress:self.progress animated:YES];
        if (self.progress == 1.0f) {
            [self.downInfoView removeFromSuperview];
            self.isdownloaded = YES;
            [self.downloadBtn setTitle:@"阅读" forState:UIControlStateNormal];
        }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"progress"];
}

#pragma mark --网络

- (void)loadData {
    NSDictionary *dict = @{@"client_id":@"qyer_ios",@"client_secret":@"cd254439208ab658ddf9",@"count":@"20",@"id":self.ID,@"lat":@"23.01220323973925",@"lon":@"113.2956616605503",@"page":@"1",@"track_app_channel":@"AppStore",@"track_app_version":@"6.8.5",@"track_device_info":@"iPhone",@"track_deviceid":@"B501CB2C-FD57-433E-A7DF-2EC4937CD6AD",@"track_os":@"ios9.3.1",@"v":@"1"};
    [NetWorkManager POST:YSQ_KITS_DETAIL_URL parameters:dict success:^(id responseObject) {
        NSDictionary *data = responseObject[@"data"];
        self.detailModel = [YSQKitsDetailModel  modelWithDictionary:data];
        self.filePath = [YSQHelp cutOutString:self.detailModel.mobile[@"file"]];
        self.isdownloaded = [[NSFileManager defaultManager] fileExistsAtPath:self.filePath] || [[NSFileManager defaultManager] fileExistsAtPath:[YSQHelp createUnZipPath:self.filePath]];
        [self createTableView];
        [self createBottomDownloadBtn];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//下载锦囊
- (void)download {
    NSString *urlString = self.detailModel.mobile[@"file"];
    self.downloadTask = [NetWorkManager download:urlString progress:^(CGFloat progress, NSString *downloadSpeed) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progress = progress;
            self.speed.text = downloadSpeed;
        });
    } success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ---UI
- (void)createTableView {
    [self countCellHeight];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT- 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.942 green:0.945 blue:0.965 alpha:1.000];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    YSQKitsDetailHeaderView *headerView = [[YSQKitsDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 240)];
    headerView.tag = 10;
    [headerView setDataWithModel:self.detailModel];
    self.tableView.tableHeaderView = headerView;
}

- (void)createBottomDownloadBtn {
   self.downloadBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT - 40, WIDTH, 40)];
    self.downloadBtn.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000];
    if (self.isdownloaded) {
        [self.downloadBtn setTitle:@"阅读" forState:UIControlStateNormal];
    } else {
        [self.downloadBtn setTitle:@"立即下载" forState:UIControlStateNormal];
    }
    [self.downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(downloadStrategy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadBtn];
}

#pragma mark ---下载操作
- (void)cancelDownload:(UIButton *)btn {
    [self.downloadTask suspend];
    self.isDownloading = YES;
    [self.downInfoView setHidden:YES];
}

- (void)downloadStrategy:(UIButton *)btn {
    if (self.isdownloaded) {
        [self unZipDownloadFile];
    } else if (self.isDownloading) {
        [self.downInfoView setHidden:NO];
        [self.downloadTask resume];
    } else {
        [self.downloadBtn addSubview:self.downInfoView];
        [self download];
    }
}

#pragma mark ---解压文件
- (void)unZipDownloadFile {
    //判断是否已经解压过
    NSString *destination = [YSQHelp createUnZipPath:self.filePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:destination]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            YSQReadBookViewController *read = [[YSQReadBookViewController alloc]init];
            read.filePath = destination;
            [self.navigationController pushViewController:read animated:YES];
        });
        return;
    }
    //生成解压地址,并且创建解压文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:destination]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [SSZipArchive unzipFileAtPath:self.filePath toDestination:destination progressHandler:^(NSString *entry, unz_file_info zipInfo, long entryNumber, long total) {
        
    } completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
        //解压成功后,删除被解压的文件夹.
        NSLog(@"%@",error);
        if (succeeded) {
            NSError *error = nil;
            if (![[NSFileManager defaultManager] removeItemAtPath:self.filePath error:&error]) {
                NSLog(@"%@",error.localizedDescription);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                YSQReadBookViewController *read = [[YSQReadBookViewController alloc]init];
                read.filePath = destination;
                [self.navigationController pushViewController:read animated:YES];
            });
        }
    }];
}

#pragma mark --countHeight 

- (void)countCellHeight {
    CGSize introHeight = [NSString sizeWithText:self.detailModel.info font:YSQNormalFont maxSize:CGSizeMake(WIDTH - 20, HEIGHT)];
    NSArray *introArr = @[@(introHeight.height + 15)];
    [self.cellHeightArr addObject:introArr];
    NSMutableArray *authorArr = [NSMutableArray array];
    [self.detailModel.authors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YSQAuthorModel *model = self.detailModel.authors[idx];
        CGSize size = [NSString sizeWithText:model.intro font:YSQNormalFont maxSize:CGSizeMake(WIDTH - 20, HEIGHT)];
        CGFloat height = size.height + 60;
        [authorArr addObject:@(height)];
    }];
    [self.cellHeightArr addObject:authorArr];

}

#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.detailModel.authors.count;
    } else if (section == 2) {
        return self.detailModel.related_guides.count;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YSQTitleHeaderView *titleView = [[YSQTitleHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    if (section == 0) {
        titleView.title.text = @"简介";
    } else if (section == 1) {
        titleView.title.text = @"锦囊作者";
    } else if (section == 2) {
        titleView.title.text = @"相关锦囊";
    }
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 100;
    }
    return [self.cellHeightArr[indexPath.section][indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YSQKitsIntroCell *cell = [YSQKitsIntroCell cellWithTableView:tableView];
        cell.intro.text = self.detailModel.info;
        return cell;
    } else if (indexPath.section == 1) {
        YSQAuthorInfoCell *cell = [YSQAuthorInfoCell cellWithTableView:tableView];
        YSQAuthorModel *model = self.detailModel.authors[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    } else {
        YSQRelatedCell *cell = [YSQRelatedCell cellWithTableView:tableView];
        YSQRelateModel *model = self.detailModel.related_guides[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }
}

#pragma mark --UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        YSQRelateModel *model = self.detailModel.related_guides[indexPath.row];
        YSQStrategyDetailController *detail = [[YSQStrategyDetailController alloc]init];
        detail.title = model.country_name_cn;
        detail.ID = model.ID;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark --UIScrollViewDelegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.y;
    CGFloat alpha=1-((64-offset)/64);
    if (offset > 64) {
        alpha = 0.995792;
        [YSQHelp clearNavShadow:self isClear:NO];
    } else {
        [YSQHelp clearNavShadow:self isClear:YES];
    }
    if (alpha >= 0.1) {
        self.title = self.name;
    } else {
        self.title = @"";
    }
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(alpha)] forBarMetrics:UIBarMetricsDefault];
    
    YSQKitsDetailHeaderView *headerView = (id) self.tableView.tableHeaderView;
    if (offset > 0) {
        CGRect frame = headerView.imageView.frame;
        frame.origin.y = MAX(offset * 0.5, 0);
        headerView.imageView.frame = frame;
        headerView.clipsToBounds = YES;
    } else {
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, WIDTH, 240);
        delta = fabs(MIN(0.0f, offset));
        rect.origin.y -=delta;
        rect.size.height += delta;
        headerView.imageView.frame = rect;
        headerView.clipsToBounds = NO;
    }
}


@end
