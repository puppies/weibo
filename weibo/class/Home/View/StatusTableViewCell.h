//
//  StatusTableViewCell.h
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface StatusTableViewCell : UITableViewCell

@property (nonatomic)UIView *originalView;

@property (nonatomic)UIImageView *iconView;
@property (nonatomic)UIImageView *vipView;

@property (nonatomic)UILabel *nameLabel;
@property (nonatomic)UILabel *timeLabel;
@property (nonatomic)UILabel *sourceLabel;
@property (nonatomic)UILabel *contentLabel;
@property (nonatomic)UIImageView *pictureView;

@property (nonatomic)UIImageView *forwardView;
@property (nonatomic)UILabel *forwardContentLabel;
@property (nonatomic)UIImageView *forwardPictureView;


@property (nonatomic)UIView *toolView;


@property (nonatomic)StatusFrame *statusFrame;

@end
