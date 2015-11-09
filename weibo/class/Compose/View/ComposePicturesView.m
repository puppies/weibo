//
//  ComposePicturesView.m
//  weibo
//
//  Created by happy on 15/11/9.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "ComposePicturesView.h"

@implementation ComposePicturesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _pictures = [NSMutableArray array];
    }
    return self;
}

- (void)addPicture:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    [_pictures addObject:image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    unsigned long picturesCount = self.subviews.count;
    int maxCol = 4;
    
    CGFloat PictureWH = 70;
    CGFloat PictureMargin = 10;
    
    for (int i = 0; i < picturesCount; i++) {
        UIImageView *imageView = self.subviews[i];
        
        unsigned long row = i / maxCol;
        unsigned long col = i % maxCol;
        
        CGFloat x = col * (PictureWH + PictureMargin);
        CGFloat y = row * (PictureWH + PictureMargin);
        imageView.frame = CGRectMake(x, y, PictureWH, PictureWH);
    }
}

@end
