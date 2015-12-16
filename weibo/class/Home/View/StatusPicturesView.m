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
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SDWebImageManager+MJ.h"

#define PictureWH 76
#define PictureMargin 10

//#define MaxCol 3

#define MaxStatusPicturesCol(count) (count == 4? 2 : 3)

@interface StatusPicturesView ()

@property (nonatomic)NSMutableArray *photos;

@end

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
            imageView.tag = i;
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tapGR];
            
            
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

- (void)tap:(UITapGestureRecognizer *)recognizer {
    UIImageView *view = (UIImageView *)recognizer.view;
    
    self.photos = [NSMutableArray array];
    
    int i = 0;
    
    for (Picture *pic in self.pictures) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = view;
        photo.index = i;
        NSString *urlString = [pic.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        photo.url = [NSURL URLWithString:urlString];
        [self.photos addObject:photo];
        
        i++;
    }
    
    MJPhotoBrowser *photoBrower = [[MJPhotoBrowser alloc] init];
    photoBrower.currentPhotoIndex = view.tag;
    photoBrower.photos = self.photos;
    [photoBrower show];
}

@end
