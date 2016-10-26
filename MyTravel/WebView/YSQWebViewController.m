//
//  MTWebViewController.m
//  MyTravel
//
//  Created by ysq on 16/1/22.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQWebViewController.h"
#import <WebKit/WebKit.h>
#import "UMSocial.h"

@interface YSQWebViewController ()<WKUIDelegate,WKNavigationDelegate,UMSocialUIDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSURL *webURL;
@end

@implementation YSQWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[YSQHelp imageWithBgColor:YSQWhiteColor(0.995792)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self createWebView];
    [self createShareItem];
    [self createProgress];
    [self loadRequest];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)loadRequest {
    if (self.ID) {
        self.webURL = [NSURL URLWithString:[NSString stringWithFormat:MT_DISCOUNT_URL,self.ID]];
    } else {
        self.webURL = [NSURL URLWithString:self.url];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:self.webURL];
    [self.wkWebView loadRequest:request];
}

- (void)createWebView {
    self.wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    self.wkWebView.allowsBackForwardNavigationGestures = YES;
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
}

- (void)createProgress {
    self.progressView = [[UIProgressView alloc]init];
    self.progressView.frame = CGRectMake(0, 64, WIDTH, 10);
    self.progressView.progressViewStyle = UIProgressViewStyleDefault;
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.trackTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
}

- (void)createShareItem {
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_detail_share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)share {
    [YSQHelp shareToSecondsPlatWithURLString:[NSString stringWithFormat:@"%@",self.webURL] shareImage:[UIImage imageNamed:@"UMS_place_map" ] presentTargert:self delegate:self];
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    if(response.responseCode == UMSResponseCodeSuccess) {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.wkWebView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.wkWebView.estimatedProgress animated:YES];
            if(self.wkWebView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.self.wkWebView) {
            self.title = self.self.wkWebView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [YSQHelp networkActivityIndicatorVisible:YES toView:self.view];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
    NSLog(@"%@",error);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [YSQHelp networkActivityIndicatorVisible:NO toView:self.view];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.wkWebView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}


@end
