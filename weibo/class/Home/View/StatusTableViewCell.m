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
    
    UIImageView *iconView = [[UIImageView alloc] init];
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
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = SourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = ContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *pictureView = [[UIImageView alloc] init];
    [originalView addSubview:pictureView];
    self.pictureView = pictureView;

}

- (void)setupForwardView {
    /** 转发 */
    UIImageView *forwardView = [[UIImageView alloc] init];
    forwardView.image = [UIImage imageNamed:@"timeline_retweet_background"];
    forwardView.highlightedImage = [UIImage imageNamed:@"timeline_retweet_background_highlighted"];
    
    [self.contentView addSubview:forwardView];
    self.forwardView = forwardView;
    
    UILabel *forwardContentLabel = [[UILabel alloc] init];
    forwardContentLabel.font = ContentFont;
    forwardContentLabel.numberOfLines = 0;
    [forwardView addSubview:forwardContentLabel];
    self.forwardContentLabel = forwardContentLabel;
    
    UIImageView *forwardPictureView = [[UIImageView alloc] init];
    [forwardView addSubview:forwardPictureView];
    self.forwardPictureView = forwardPictureView;

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
    
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    self.iconView.frame = statusFrame.iconF;
    [self.iconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
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
    
    self.timeLabel.frame = statusFrame.timeF;
    self.timeLabel.text = status.created_at;
    
    self.sourceLabel.frame = statusFrame.sourceF;
    self.sourceLabel.text = status.source;
    
    self.contentLabel.frame = statusFrame.contentF;
    self.contentLabel.text = status.text;
    
    if (status.pic_urls.count) {
        self.pictureView.hidden = NO;
        self.pictureView.frame = statusFrame.pictureF;
        Picture *pic = [status.pic_urls firstObject];
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:pic.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    } else {
        self.pictureView.hidden = YES;
    }
    
    if (forwardStatus) {
        /** 转发 */
        self.forwardView.hidden = NO;
        self.forwardView.frame = statusFrame.forwardF;
        
        self.forwardContentLabel.frame = statusFrame.forwardContentF;
        NSString *forwardContent = [NSString stringWithFormat:@"@%@ : %@", forwardStatus.user.name, forwardStatus.text];
        self.forwardContentLabel.text = forwardContent;
        
        if (forwardStatus.pic_urls.count) {
            self.forwardPictureView.hidden = NO;
            self.forwardPictureView.frame = statusFrame.forwardPictureF;
            Picture *pic = [forwardStatus.pic_urls firstObject];
            [self.forwardPictureView sd_setImageWithURL:[NSURL URLWithString:pic.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            self.forwardPictureView.hidden = YES;
        }
    } else {
        self.forwardView.hidden = YES;
    }
    
    self.toolBarView.frame = statusFrame.toolF;
    self.toolBarView.status = status;

}


@end
