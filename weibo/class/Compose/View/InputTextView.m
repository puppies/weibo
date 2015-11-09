//
//  InputTextView.m
//  weibo
//
//  Created by happy on 15/11/8.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "InputTextView.h"

@implementation InputTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        self.alwaysBounceVertical = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.hasText) return;
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = rect.size.width - 2 * x;
    CGFloat height = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, width, height);
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor? self.placeholderColor : [UIColor grayColor];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}


- (void)textDidChange {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    [self setNeedsDisplay];
}
@end
