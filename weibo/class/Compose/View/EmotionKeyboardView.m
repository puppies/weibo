//
//  EmotionKeyboardView.m
//  weibo
//
//  Created by happy on 15/11/10.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "EmotionKeyboardView.h"

@interface EmotionKeyboardView ()

@property (nonatomic, weak)UIView *emotionView;
@property (nonatomic, weak)UIView *emotionToolbar;



@end

@implementation EmotionKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *emotionView = [[UIView alloc] init];
        [self addSubview:emotionView];
        self.emotionView = emotionView;
        
        UIView *emotionToolbar = [[UIView alloc] init];
        [self addSubview:emotionToolbar];
        self.emotionToolbar = emotionToolbar;
    }
    return self;
}

- (void)layoutSubviews {
    self.emotionToolbar.width = self.width;
    self.emotionToolbar.height = 44;
    self.emotionToolbar.x = 0;
    self.emotionToolbar.y = self.height - self.emotionToolbar.height;
    
    self.emotionView.width = self.width;
    self.emotionView.height = self.emotionView.y;

}

@end
