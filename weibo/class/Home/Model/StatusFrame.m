//
//  StatusFrame.m
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "NSString+extension.h"
#import "User.h"

@implementation StatusFrame

- (void)setStatus:(Status *)status {
    
    _status = status;
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    User *user = status.user;
    CGFloat iconX = Padding;
    CGFloat iconY = Padding;
    CGFloat iconWH = 50;
    self.iconF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    CGFloat nameX = CGRectGetMaxX(self.iconF) + Padding;
    CGFloat nameY = iconY;
    CGSize nameSize = [NSString sizeWithText:status.user.name font:NameFont];
    self.nameF = (CGRect){{nameX, nameY}, nameSize};
    
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameF) + Padding;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 15;
        self.vipF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameF) + Padding;
    CGSize timeSize = [NSString sizeWithText:status.created_at font:TimeFont];
    self.timeF = (CGRect){{timeX, timeY}, timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(self.timeF) + Padding;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [NSString sizeWithText:status.source font:SourceFont];
    self.sourceF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.nameF), CGRectGetMaxY(self.iconF)) + Padding;
    CGFloat maxW = cellWidth - 2 * Padding;
    CGSize contentSize = [NSString sizeWithText:status.text font:ContentFont maxWidth:maxW];
    self.contentF = (CGRect){{contentX, contentY}, contentSize};
    
    CGFloat originW = cellWidth;
    CGFloat originH = CGRectGetMaxY(self.contentF) + Padding;
    self.originF = (CGRect){CGPointZero, {originW, originH}};
    
    self.cellHeight = CGRectGetMaxY(self.originF);
    
    
}

+ (NSArray *)framesWithStatuses:(NSArray *)statuses {
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *frame = [[StatusFrame alloc] init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

@end
