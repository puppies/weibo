//
//  StatusPicturesView.m
//  weibo
//
//  Created by happy on 15/11/6.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "StatusPicturesView.h"
#import "UIImageView+WebCache.h"
#import "Picture.h"
#import "StatusPictureView.h"
#define PictureWH 76
#define PictureMargin 10

//#define MaxCol 3

#define MaxStatusPicturesCol(count) (count == 4? 2 : 3)

@implementation StatusPicturesView

+ (CGSize)sizeWithPicturesNumber:(unsigned long)count {
    int maxCol = MaxStatusPicturesCol(count);
    
    unsigned long row = (count + maxCol - 1) / maxCol;
    unsigned long col = count < maxCol? count : maxCol;
    
    unsigned long width = col * PictureWH + (col -1) * PictureMargin;
    unsigned long height = row * PictureWH + (row -1) * PictureMargin;
    
    return CGSizeMake(width, height);
}

- (void)setPictures:(NSArray *)pictures {
    _pictures = pictures;
    
    unsigned long picturesCount = self.pictures.count;
    while (self.subviews.count < picturesCount) {
        StatusPictureView *imageView = [[StatusPictureView alloc] init];
        [self addSubview:imageView];
    }
    unsigned long imageViewCount = self.subviews.count;
    for (int i = 0; i < imageViewCount; i++) {
        
        StatusPictureView *imageView = self.subviews[i];
        if (i < picturesCount) {
            imageView.hidden = NO;
            Picture *pic = self.pictures[i];
            imageView.picture = pic;
        } else {
            imageView.hidden = YES;
        }
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    unsigned long picturesCount = self.pictures.count;
    int maxCol = MaxStatusPicturesCol(picturesCount);

    for (int i = 0; i < picturesCount; i++) {
        StatusPictureView *imageView = self.subviews[i];
        
        unsigned long row = i / maxCol;
        unsigned long col = i % maxCol;
        
        CGFloat x = col * (PictureWH + PictureMargin);
        CGFloat y = row * (PictureWH + PictureMargin);
        imageView.frame = CGRectMake(x, y, PictureWH, PictureWH);
    }
}

@end
