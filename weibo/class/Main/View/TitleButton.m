//
//  TitleButton.m
//  weibo
//
//  Created by happy on 15/10/31.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "TitleButton.h"
#import "UIView+extension.h"

@implementation TitleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews {
//    NSLog(@"%@ label：%f image：%f", NSStringFromSelector(_cmd), self.titleLabel.x, self.imageView.x);
    [super layoutSubviews];
//    NSLog(@"%@ label：%f image：%f", NSStringFromSelector(_cmd), self.titleLabel.x, self.imageView.x);

    
//    self.titleLabel.x  = self.imageView.x;
    self.titleLabel.x  = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
//    NSLog(@"%@ label：%f image：%f", NSStringFromSelector(_cmd), self.titleLabel.x, self.imageView.x);
}

@end
