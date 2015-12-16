//
//  WebViewController.m
//  weibo
//
//  Created by happy on 15/12/10.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "WebViewController.h"
#import "UMSocial.h"

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];

    [webView loadRequest:request];
}

- (void)share {
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5670ee64e0f55a7071002940" shareText:self.url.absoluteString shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToWechatSession, UMShareToQQ, UMShareToWechatTimeline, UMShareToQzone, UMShareToDouban, nil] delegate:nil];
}

@end
