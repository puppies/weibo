//
//  UIWindow+extension.m
//  weibo
//
//  Created by happy on 15/10/30.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "UIWindow+extension.h"
#import "MainTabBarController.h"
#import "NewFeatureViewController.h"

#define VerKey @"CFBundleVersion"

@implementation UIWindow (extension)

+ (void)switchRootViewController {
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[VerKey];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] valueForKey:VerKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        window.rootViewController = [[MainTabBarController alloc] init];
    } else {
        window.rootViewController = [[NewFeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VerKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

@end
