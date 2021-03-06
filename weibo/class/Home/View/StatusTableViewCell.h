//
//  StatusTableViewCell.h
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;
@class StatusToolBar;
@class StatusPicturesView;
@class IconView;
@class StatusTextView;

@interface StatusTableViewCell : UITableViewCell

@property (nonatomic)UIView *originalView;

@property (nonatomic)IconView *iconView;
@property (nonatomic)UIImageView *vipView;

@property (nonatomic)UILabel *nameLabel;
@property (nonatomic)UILabel *timeLabel;
@property (nonatomic)UILabel *sourceLabel;
@property (nonatomic)StatusTextView *contentTextView;
@property (nonatomic)StatusPicturesView *picturesView;

@property (nonatomic)UIView *forwardView;
@property (nonatomic)StatusTextView *forwardContentTextView;
@property (nonatomic)StatusPicturesView *forwardPicturesView;


@property (nonatomic)StatusToolBar *toolBarView;

@property (nonatomic)StatusFrame *statusFrame;

@end
