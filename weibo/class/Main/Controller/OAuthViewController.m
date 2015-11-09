//
//  OAuthViewController.m
//  weibo
//
//  Created by happy on 15/10/30.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "MainTabBarController.h"
#import "NewFeatureViewController.h"
#import "MBProgressHUD.h"
#import "AccountTool.h"
#import "UIWindow+extension.h"

@interface OAuthViewController () <UIWebViewDelegate>

@property (nonatomic)MBProgressHUD *hud;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *OAuthWebView = [[UIWebView alloc] init];
    OAuthWebView.delegate = self;
    self.view = OAuthWebView;
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1329867940&redirect_uri=https://api.weibo.com/oauth2/default.html"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [OAuthWebView loadRequest:req];
}

#pragma mark - web view delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSLog(@"%@", url);

    NSRange range = [url rangeOfString:@"code="];
    if (range.length) {
        unsigned long fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        
        return NO;
    }
    return YES;
}

- (NSString *)accessTokenWithCode:(NSString *)code {
    
    NSLog(@"%@", code);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1329867940";
    params[@"client_secret"] = @"41d09a42522e27fe1de2b0ff7fc9aa00";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"https://api.weibo.com/oauth2/default.html";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *responseObject) {
        
        Account *account = [Account accountWithDictionary:responseObject];
        [AccountTool saveAccount:account];
        
        [UIWindow switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    return nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.hud = [MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"loading";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
}

@end
