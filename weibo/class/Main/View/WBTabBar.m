//
//  WBTabBar.m
//  weibo
//
//  Created by happy on 15/10/29.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "WBTabBar.h"
#import "UIView+extension.h"

@interface WBTabBar ()

@property (nonatomic)UIButton *plusBtn;

@end

@implementation WBTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height *0.5);
    
    CGFloat tabBarButtonW = self.width / 5;
    int index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.x = index * tabBarButtonW;
            view.width = tabBarButtonW;
            index++;
            
            if (index == 2) {
                index ++;
            }
        }
    }
}

- (void)plusClicked {
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

@end
