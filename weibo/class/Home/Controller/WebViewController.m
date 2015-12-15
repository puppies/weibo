//
//  WebViewController.m
//  weibo
//
//  Created by happy on 15/12/10.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];

    [webView loadRequest:request];
}

@end
