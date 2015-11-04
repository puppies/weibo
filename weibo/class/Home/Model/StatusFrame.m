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
    Status *forwardStatus = status.retweeted_status;
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    User *user = status.user;
    CGFloat iconX = Padding;
    CGFloat iconY = Padding;
    CGFloat iconWH = 34;
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
    
    CGFloat originH = 0;
    if (status.pic_urls.count) {
        CGFloat pictureWH = 76;
        CGFloat pictureX = contentX;
        CGFloat pictureY = CGRectGetMaxY(self.contentF) + Padding;
        self.pictureF = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);
        
        originH = CGRectGetMaxY(self.pictureF) + Padding;
    } else {
        originH = CGRectGetMaxY(self.contentF) + Padding;
    }
    
    CGFloat originW = cellWidth;
    CGFloat originX = 0;
    CGFloat originY = CellPadding;
    self.originF = CGRectMake(originX, originY, originW, originH);
    
    CGFloat toolY = 0;
    if (forwardStatus) {
        /** 转发部分*/
        CGFloat forwardContentX = iconX;
        CGFloat forwardContentY = Padding;
        //    CGFloat maxW = cellWidth - 2 * Padding;
        
        NSString *forwardContent = [NSString stringWithFormat:@"@%@ : %@", forwardStatus.user.name, forwardStatus.text];
        CGSize forwardContentSize = [NSString sizeWithText:forwardContent font:ContentFont maxWidth:maxW];
        self.forwardContentF = (CGRect){{forwardContentX, forwardContentY}, forwardContentSize};
        
        CGFloat forwardH = 0;
        if (forwardStatus.pic_urls.count) {
            CGFloat forwardPictureWH = 76;
            CGFloat forwardPictureX = forwardContentX;
            CGFloat forwardPictureY = CGRectGetMaxY(self.forwardContentF) + Padding;
            self.forwardPictureF = CGRectMake(forwardPictureX, forwardPictureY, forwardPictureWH, forwardPictureWH);
            
            forwardH = CGRectGetMaxY(self.forwardPictureF) + Padding;
        } else {
            forwardH = CGRectGetMaxY(self.forwardContentF) + Padding;
        }
        
        CGFloat forwardW = originW;
        CGFloat forwardX = self.originF.origin.x;
        CGFloat forwardY = CGRectGetMaxY(self.originF);
        self.forwardF = CGRectMake(forwardX, forwardY, forwardW, forwardH);
        

        toolY = CGRectGetMaxY(self.forwardF);
        
    } else {
        toolY = CGRectGetMaxY(self.originF);
    }
    
    /** 工具条 */
    
    CGFloat toolW = originW;
    CGFloat toolH = 35;
    CGFloat toolX = self.originF.origin.x;
    self.toolF = CGRectMake(toolX, toolY, toolW, toolH);
    
    CGFloat commentBtnW = toolW / 3;
    CGFloat commentBtnH = toolH;
    CGFloat commentBtnX = 0;
    CGFloat commentBtnY = 0;
    self.commentBtnF = CGRectMake(commentBtnX, commentBtnY, commentBtnW, commentBtnH);
    
    CGFloat forwardBtnW = commentBtnW;
    CGFloat forwardBtnH = toolH;
    CGFloat forwardBtnX = commentBtnW;
    CGFloat forwardBtnY = 0;
    self.forwardBtnF = CGRectMake(forwardBtnX, forwardBtnY, forwardBtnW, forwardBtnH);
    
    CGFloat likeBtnW = commentBtnW;
    CGFloat likeBtnH = toolH;
    CGFloat likeBtnX = commentBtnW * 2;
    CGFloat likeBtnY = 0;
    self.likeBtnF = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    self.cellHeight = CGRectGetMaxY(self.toolF);
    
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
