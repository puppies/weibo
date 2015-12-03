//
//  StatusPictureView.m
//  weibo
//
//  Created by happy on 15/11/6.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "StatusPictureView.h"
#import "UIImageView+WebCache.h"
#import "Picture.h"
#import "UIView+extension.h"

@interface StatusPictureView ()

@property (nonatomic)UIImageView *gifView;

@end

@implementation StatusPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
    }
    return self;
}


- (UIImageView *)gifView {
    if (!_gifView) {
        _gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:_gifView];
    }
    return _gifView;
}

- (void)setPicture:(Picture *)picture {
    _picture = picture;
    
    [self sd_setImageWithURL:[NSURL URLWithString:picture.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![picture.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
