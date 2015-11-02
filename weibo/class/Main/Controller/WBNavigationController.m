//
//  WBNavigationController.m
//  weibo
//
//  Created by happy on 15/10/29.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIView+extension.h"
#import "UIBarButtonItem+extension.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

+ (void)initialize {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(root) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)root {
    [self popToRootViewControllerAnimated:YES];
}

@end
