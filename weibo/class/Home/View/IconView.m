//
//  IconView.m
//  weibo
//
//  Created by happy on 15/11/6.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "IconView.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "UIView+extension.h"

@interface IconView ()

@property (nonatomic)UIImageView *verifiedView;

@end

@implementation IconView

- (UIImageView *)verifiedView {
    if (!_verifiedView) {
        _verifiedView = [[UIImageView alloc] init];
        [self addSubview:_verifiedView];
    }
    return _verifiedView;
}

- (void)setUser:(User *)user {
    _user = user;
    
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        case VerifiedTypePersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case VerifiedTypeDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        case VerifiedTypeEnterprice:
        case VerifiedTypeWebsite:
        case VerifiedTypeMedia:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float scale = 0.7;
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

@end
