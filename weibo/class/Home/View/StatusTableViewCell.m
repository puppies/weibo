//
//  StatusTableViewCell.m
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "Picture.h"
#import "StatusToolBar.h"
#import "NSString+extension.h"
#import "StatusPicturesView.h"
#import "IconView.h"
#import "StatusTextView.h"

@implementation StatusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self setupOriginView];
    
    [self setupForwardView];
    
    [self setupToolBarView];
    
 
    
    return self;
}

- (void)setupOriginView {
    
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    IconView *iconView = [[IconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = NameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = TimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = SourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    StatusTextView *contentTextView = [[StatusTextView alloc] init];
//    contentTextView.font = ContentFont;
//    contentTextView.backgroundColor = [UIColor redColor];

    [originalView addSubview:contentTextView];
    self.contentTextView = contentTextView;
    
    StatusPicturesView *picturesView = [[StatusPicturesView alloc] init];
    [originalView addSubview:picturesView];
    self.picturesView = picturesView;

}

- (void)setupForwardView {
    /** 转发 */
    UIImageView *forwardView = [[UIImageView alloc] init];
    forwardView.image = [UIImage imageNamed:@"timeline_retweet_background"];
    forwardView.highlightedImage = [UIImage imageNamed:@"timeline_retweet_background_highlighted"];
    
    [self.contentView addSubview:forwardView];
    self.forwardView = forwardView;
    
    StatusTextView *forwardContentTextView = [[StatusTextView alloc] init];
//    forwardContentTextView.font = ContentFont;
    [forwardView addSubview:forwardContentTextView];
    self.forwardContentTextView = forwardContentTextView;
    
    StatusPicturesView *forwardPicturesView = [[StatusPicturesView alloc] init];
    [forwardView addSubview:forwardPicturesView];
    self.forwardPicturesView = forwardPicturesView;

}

- (void)setupToolBarView {
    /** 工具条 */
    StatusToolBar *toolBarView = [[StatusToolBar alloc] init];

    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame {
    
    _statusFrame = statusFrame;
    
    Status *status = self.statusFrame.status;
    User *user = status.user;
    
    Status *forwardStatus = status.retweeted_status;
    
    self.originalView.frame = statusFrame.originF;
    
    self.iconView.frame = statusFrame.iconF;
    self.iconView.user = user;
    
    self.nameLabel.frame = statusFrame.nameF;
    self.nameLabel.text = user.name;
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipF;
        NSString *vip = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vip];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    CGFloat timeX = self.nameLabel.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + Padding;
    CGSize timeSize = [status.created_at sizeWithFont:TimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = status.created_at;
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + Padding;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    self.contentTextView.frame = statusFrame.contentF;
    self.contentTextView.attributedText = status.attributedText;
    
    if (status.pic_urls.count) {
        self.picturesView.hidden = NO;
        self.picturesView.frame = statusFrame.picturesF;
        self.picturesView.pictures = status.pic_urls;
    } else {
        self.picturesView.hidden = YES;
    }
    
    if (forwardStatus) {
        /** 转发 */
        self.forwardView.hidden = NO;
        self.forwardView.frame = statusFrame.forwardF;
        
        self.forwardContentTextView.frame = statusFrame.forwardContentF;
//        NSString *forwardContent = [NSString stringWithFormat:@"@%@ : %@", forwardStatus.user.name, forwardStatus.text];
//        self.forwardContentLabel.text = forwardContent;
        self.forwardContentTextView.attributedText = status.retweetedAttributedText;
        
        if (forwardStatus.pic_urls.count) {
            self.forwardPicturesView.hidden = NO;
            self.forwardPicturesView.frame = statusFrame.forwardPicturesF;
            self.forwardPicturesView.pictures = forwardStatus.pic_urls;
        } else {
            self.forwardPicturesView.hidden = YES;
        }
    } else {
        self.forwardView.hidden = YES;
    }
    
    self.toolBarView.frame = statusFrame.toolF;
    self.toolBarView.status = status;

}


@end
