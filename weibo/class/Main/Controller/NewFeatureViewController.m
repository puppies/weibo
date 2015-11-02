//
//  NewFeatureViewController.m
//  weibo
//
//  Created by happy on 15/10/29.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "UIView+extension.h"
#import "MainTabBarController.h"

#define PageCount 4

@interface NewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic) UIPageControl *pageControl;
@end

@implementation NewFeatureViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    CGFloat pageWidth = scrollView.size.width;
    CGFloat pageHeight = scrollView.size.height;
    scrollView.contentSize = CGSizeMake(pageWidth * PageCount, 0);
    
    for (int i = 0; i < PageCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d", i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.size = scrollView.size;
        imageView.x = pageWidth * i;
        imageView.y = 0;
        
        if (i == PageCount - 1) {
            UIButton *shareBtn = [[UIButton alloc] init];
            shareBtn.size = CGSizeMake(150, 50);
            shareBtn.centerX = pageWidth * 0.5;
            shareBtn.centerY = pageHeight * 0.7;

            [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            [shareBtn setTitle:@"分享好友" forState:UIControlStateNormal];
            [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [shareBtn addTarget:self action:@selector(shareCheck:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:shareBtn];
            
            UIButton *startBtn = [[UIButton alloc] init];
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            startBtn.size = startBtn.currentBackgroundImage.size;
            startBtn.centerX = shareBtn.centerX;
            startBtn.centerY = pageHeight * 0.8;
            [startBtn setTitle:@"进入微博" forState:UIControlStateNormal];
            [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:startBtn];

            
            imageView.userInteractionEnabled = YES;
        }
        
        [scrollView addSubview:imageView];
    }
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = PageCount;
    pageControl.centerX = self.view.centerX;
    pageControl.centerY = pageHeight - 50;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
}

- (void)shareCheck:(UIButton *)button {
    button.selected = ! button.isSelected;
}

- (void)startClick {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarController alloc] init];
}

#pragma mark - scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX  = scrollView.contentOffset.x;
    
    double page = offsetX / scrollView.width;
    
    self.pageControl.currentPage = (int)(page + 0.5);
    
}

@end
