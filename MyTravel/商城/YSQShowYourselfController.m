//
//  YSQShowYourselfController.m
//  MyTravel
//
//  Created by ysq on 2016/10/6.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQShowYourselfController.h"
#import <LFLiveKit.h>

@interface YSQShowYourselfController ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *rtmpURL;

@property (weak, nonatomic) IBOutlet UIButton *beautyFaceBtn;

@property (nonatomic, strong) LFLiveSession *session;

@property (weak, nonatomic) IBOutlet UISlider *beautyLevel;

@property (nonatomic, strong) UIView *livingPreView;

@end

@implementation YSQShowYourselfController

#pragma mark -- 懒加载

- (UIView *)livingPreView {
    if (!_livingPreView) {
        _livingPreView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _livingPreView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:_livingPreView atIndex:0];
    }
    return _livingPreView;
}

- (LFLiveSession *)session {
    if (!_session) {
        //默认音频质量 audio sample rate: 44MHz, audio bitrate: 96Kbps
        //LFLiveVideoQuality_Medium2 表示视频质量. 码率800Kps
        //这里可以根据主播需求自行切换码率
        _session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        _session.delegate = self;
        //开启捕获视频
        _session.running = YES;
        //预览层
        _session.preView = self.livingPreView;
        
    }
    return _session;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.beautyLevel.value = 5;
    self.beautyLevel.maximumValue = 10;
    self.beautyLevel.minimumValue = 1;
    self.beautyLevel.minimumTrackTintColor = [UIColor greenColor];
    self.beautyLevel.maximumTrackTintColor = [UIColor blueColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beautyFaceBtn.selected = YES;
    [self.beautyLevel addTarget:self action:@selector(changeLevel:) forControlEvents:UIControlEventValueChanged];
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeLevel:(UISlider* )slider {
    NSLog(@"%f",slider.value);
    self.session.beautyLevel = slider.value;
}

- (IBAction)startLive:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
        //推流URL
        stream.url = @"rtmp://video-center.alivecdn.com/AppName/StreamName?vhost=live.eengoo.com";
        self.rtmpURL.text = stream.url;
        [self.session startLive:stream];
    } else {
        [self.session stopLive];
        self.rtmpURL.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: rtmp://localhost:1935/rtmplive/room"];
    }
}

- (IBAction)openBeautyFace:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.session.beautyFace = !self.session.beautyFace;
}

- (IBAction)changeCamare:(UIButton *)sender {
    AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    NSLog(@"切换前置/后置摄像头");
}

- (IBAction)closeLive:(UIButton *)sender {
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --LFLiveSessionDelegate

- (void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.rtmpURL.text = [NSString stringWithFormat:@"状态: %@ \nRTMP: rtmp://localhost:1935/rtmplive/room", tempStatus];
}

- (void)liveSession:(LFLiveSession *)session debugInfo:(LFLiveDebug *)debugInfo {
    NSLog(@"%f",debugInfo.dataFlow);
    NSLog(@"%ld",(long)debugInfo.dropFrame);
    NSLog(@"%ld",(long)debugInfo.totalFrame);
    NSLog(@"%@",NSStringFromCGSize(debugInfo.videoSize));
    NSLog(@"%ld",(long)debugInfo.currentCapturedVideoCount);
}

- (void)liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode {
    NSLog(@"%lu",(unsigned long)errorCode);
}


@end
