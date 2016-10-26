//
//  YSQLiveCell.m
//  MyTravel
//
//  Created by ysq on 2016/10/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQLiveCell.h"
#import "YSQLiveItem.h"
#import "YSQCreatorItem.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface YSQLiveCell ()
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;

@property (nonatomic, strong) UIImageView *placeholderView;

@property(nonatomic, weak) CAEmitterLayer *emitterLayer;


@end

@implementation YSQLiveCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.placeholderView = [UIImageView new];
        self.placeholderView.frame = self.contentView.bounds;
        [self.contentView addSubview:self.placeholderView];
        
        UIButton *back  = [[UIButton alloc]init];
        [back setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal]
        ;
        back.tintColor = [UIColor whiteColor];
        [back addTarget:self action:@selector(quitLive) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:back];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(40);
            make.left.equalTo(self).offset(20);
        }];
        
    }
    return self;
}

- (void)setLive:(YSQLiveItem *)live {
    _live = live;
    [self stopEmitterAnimation];
    [self setUpPlaceholder];
    [self startLive];
}

- (void)startLive {
    //进行切换前 先将播放器清空.否则在切换主播的时候会造成内存奔溃.
    [_moviePlayer shutdown];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
     //帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
     //-vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
//    //服务器拉流URL
   NSURL *url = [NSURL URLWithString:_live.stream_addr];

    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options];
    moviePlayer.view.frame = self.contentView.bounds;
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    //moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    moviePlayer.shouldShowHudView = NO;
    
    [self.contentView insertSubview:moviePlayer.view atIndex:1];
    
    [moviePlayer prepareToPlay];
    
    self.moviePlayer = moviePlayer;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emitterLayer setHidden:NO];
    });
}

- (void)addObserver {
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LiveDidFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    //监听播放状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetworkStateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)LiveDidFinish {
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    

}

- (void)NetworkStateDidChange {
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled) {
        [SQProgressHUD showFailToView:self.moviePlayer.view message:@"网络不佳,请切换清晰度" shake:NO];
    }
}


- (void)stopEmitterAnimation {
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
}

- (void)setUpPlaceholder {
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_live.creator.portrait]];
    [[YYWebImageManager sharedManager] requestImageWithURL:imageUrl options:0 progress:nil transform:nil  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *blurImage = [image imageByBlurLight];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.placeholderView.image = blurImage;
            });
        });
    }];
}

- (CAEmitterLayer *)emitterLayer
{
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        //    _emitterLayer.preservesDepth = YES;
        NSMutableArray *array = [NSMutableArray array];
        // 创建粒子
        for (int i = 0; i<4; i++) {
            // 发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            // 粒子的创建速率，默认为1/s
            stepCell.birthRate = 1.5;
            // 粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1.5;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 3;
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i+1]];
            // 粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            // 粒子的名字
            //            [fire setName:@"step%d", i];
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(60) + 40;
            // 粒子速度的容差
            stepCell.velocityRange = 40;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude =  M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/5;
            // 缩放比例
            stepCell.scale = 0.4;
            [array addObject:stepCell];
        }
        
        emitterLayer.emitterCells = array;
        [self.moviePlayer.view.layer addSublayer:emitterLayer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

- (UIViewController*)viewController{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)quitLive {
    UIViewController *vc = self.viewController;
    [self.moviePlayer pause];
    [self.moviePlayer stop];
    [self.moviePlayer shutdown];
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
