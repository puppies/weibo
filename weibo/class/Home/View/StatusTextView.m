//
//  StatusTextView.m
//  weibo
//
//  Created by happy on 15/12/7.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "StatusTextView.h"

@implementation StatusTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.editable = NO;
        self.font = ContentFont;
        self.backgroundColor = [UIColor clearColor];
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsZero;
    }
    return self;
}



@end
