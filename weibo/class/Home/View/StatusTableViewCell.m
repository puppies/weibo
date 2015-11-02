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

@implementation StatusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIView *originalView = [[UIView alloc] init];
//    originalView.backgroundColor = [UIColor redColor];
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
    
    return self;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame {
    
    _statusFrame = statusFrame;
    
    Status *status = self.statusFrame.status;
    User *user = status.user;
    
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

}


@end
