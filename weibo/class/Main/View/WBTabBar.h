//
//  WBTabBar.h
//  weibo
//
//  Created by happy on 15/10/29.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(UITabBar *)tabBar;
@end

@interface WBTabBar : UITabBar
@property (nonatomic, weak) id<WBTabBarDelegate> delegate;
@end
