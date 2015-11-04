//
//  StatusToolBar.m
//  weibo
//
//  Created by happy on 15/11/4.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "StatusToolBar.h"
#import "Status.h"

@interface StatusToolBar ()

@property (nonatomic)UIButton *commentButton;
@property (nonatomic)UIButton *forwardButton;
@property (nonatomic)UIButton *likeButton;

@property (nonatomic)NSMutableArray *buttons;
@property (nonatomic)NSMutableArray *seperators;

@end

@implementation StatusToolBar

- (NSMutableArray *)seperators {
    if (!_seperators) {
        _seperators = [NSMutableArray array];
    }
    return _seperators;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.userInteractionEnabled = YES;
    
    self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
    self.highlightedImage = [UIImage imageNamed:@"timeline_card_bottom_background_highlighted"];
    
    self.commentButton =[self newButtonWithImage:@"timeline_icon_comment"];
    self.forwardButton =[self newButtonWithImage:@"timeline_icon_retweet"];
    self.likeButton =[self newButtonWithImage:@"timeline_icon_unlike"];
    
    [self addSeperator];
    [self addSeperator];

    return self;
}

- (UIButton *)newButtonWithImage:(NSString *)image {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
//    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];

    [self addSubview:button];
    [self.buttons addObject:button];
    
    return button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    unsigned long buttonCount = self.buttons.count;
    CGFloat buttonWidth = self.frame.size.width / buttonCount;
    CGFloat buttonHeight = self.frame.size.height;
    CGFloat buttonY = 0;

    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = self.buttons[i];
        CGFloat buttonX = buttonWidth * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
    
    unsigned long seperatorCount = self.seperators.count;
    CGFloat seperatorWidth = 1;
    CGFloat seperatorY = 0;
    
    for (int i = 0; i < seperatorCount;) {
        UIImageView *seperator = self.seperators[i];
        CGFloat seperatorX = buttonWidth * ++i;
        seperator.frame = CGRectMake(seperatorX, seperatorY, seperatorWidth, buttonHeight);
    }
}

- (void)setButton:(UIButton *)button count:(NSString *)count title:(NSString *)title {
    if (count.intValue) {
        if (count.intValue < 10000) {
            title = count;
        } else {
            double wan = count.intValue / 10000.0;
            title = [NSString stringWithFormat:@"%.1f", wan];
            /** 去除.0 */
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)addSeperator {
    UIImageView *seperator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"] highlightedImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
    [self addSubview:seperator];
    [self.seperators addObject:seperator];
}

- (void)setStatus:(Status *)status {
    [self setButton:self.commentButton count:status.comments_count title:@"评论"];
    [self setButton:self.forwardButton count:status.reposts_count title:@"转发"];
    [self setButton:self.likeButton count:status.attitudes_count title:@"赞"];
}

@end
