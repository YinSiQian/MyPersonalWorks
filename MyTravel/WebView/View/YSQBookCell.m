//
//  YSQBookCell.m
//  MyTravel
//
//  Created by ysq on 16/6/14.
//  Copyright © 2016年 ysq. All rights reserved.
//

#import "YSQBookCell.h"
#import <WebKit/WebKit.h>

@interface YSQBookCell ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkwebView;
@property (nonatomic, strong) UIWebView *web;

@end

@implementation YSQBookCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
//    self.wkwebView = [[WKWebView alloc]initWithFrame:self.bounds];
//    self.wkwebView.allowsBackForwardNavigationGestures = YES;
//    self.wkwebView.navigationDelegate = self;
//    self.wkwebView.UIDelegate = self;
//    [self.contentView addSubview:self.wkwebView];
    
    self.web = [[UIWebView alloc]initWithFrame:self.bounds];
    self.web.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.web];
    
}

- (void)loadHTMLWithHTMLPath:(NSString *)path baseURL:(NSString *)URLString{
    NSError *error = nil;
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.web loadHTMLString:htmlString baseURL:url];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //[YSQHelp networkActivityIndicatorVisible:YES toView:self];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //[YSQHelp networkActivityIndicatorVisible:NO toView:self];
    NSLog(@"%@",error);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //[YSQHelp networkActivityIndicatorVisible:NO toView:self];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@",navigationAction.request);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.wkwebView loadRequest:navigationAction.request];
    }
    return nil;
}


@end
