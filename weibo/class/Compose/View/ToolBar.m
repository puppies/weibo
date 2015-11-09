//
//  ToolBar.m
//  weibo
//
//  Created by happy on 15/11/9.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "ToolBar.h"
#import "UIView+extension.h"

@implementation ToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
    }
    return self;
}

- (void)addButton:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat width = self.width / count;
    CGFloat height = self.height;
    CGFloat y = 0;
    for (NSUInteger i = 0; i < count; i++) {
        CGFloat x = i * width;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, width, height);
    }
}

@end
