//
//  MainTabBarController.m
//  weibo
//
//  Created by happy on 15/10/28.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeTableViewController.h"
#import "MessageTableViewController.h"
#import "DiscoverTableViewController.h"
#import "ProfileTableViewController.h"
#import "WBNavigationController.h"
#import "WBTabBar.h"

@interface MainTabBarController () <WBTabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomeTableViewController *homeTableViewController = [[HomeTableViewController alloc] init];
    [self addChildViewController:homeTableViewController title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    MessageTableViewController *messageTableViewController = [[MessageTableViewController alloc] init];
    [self addChildViewController:messageTableViewController title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"add" image:nil selectedImage:nil]];
    
    DiscoverTableViewController *discoverTableViewController = [[DiscoverTableViewController alloc] init];
    [self addChildViewController:discoverTableViewController title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    ProfileTableViewController *profileTableViewController = [[ProfileTableViewController alloc] init];
    [self addChildViewController:profileTableViewController title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    [self setValue:[[WBTabBar alloc] init] forKeyPath: @"tabBar"];
}

- (void)addChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //set selected text color
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [viewController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    [self addChildViewController:[[WBNavigationController alloc] initWithRootViewController:viewController]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - WBTabBar delegate

- (void)tabBarDidClickPlusButton:(UITabBar *)tabBar {
    [self presentViewController:[[UINavigationController alloc] init] animated:YES completion:nil];
}

@end
