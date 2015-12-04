//
//  Status.m
//  weibo
//
//  Created by happy on 15/10/31.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "Status.h"
#import "User.h"
#import "NSDate+extension.h"
#import "RegexKitLite.h"
#import "SpecialText.h"
#import "Emotion.h"
#import "EmotionTool.h"

@implementation Status
//
//+ (instancetype)statusWithDictionary:(NSDictionary *)dic {
//    Status *status = [[Status alloc] init];
//    if (status) {
//        status.created_at = dic[@"idstr"];
//        status.created_at = dic[@"created_at"];
//        status.text = dic[@"text"];
//        status.source = dic[@"source"];
//        status.thumbnail_pic = dic[@"thumbnail_pic"];
//        status.original_pic = dic[@"original_pic"];
//        status.reposts_count = dic[@"reposts_count"];
//        status.comments_count = dic[@"comments_count"];
//        status.pic_ids = dic[@"pic_ids"];
//        status.user = [User userWithDictionary:dic[@"user"]] ;
//    }
//    return status;
//}

+ (NSString *)protocolForArrayProperty:(NSString *)propertyName {
    
    return [propertyName isEqualToString:@"pic_urls"]? @"Picture" : nil;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return ([propertyName isEqualToString:@"retweeted_status"] || [propertyName isEqualToString:@"attributedText"] || [propertyName isEqualToString:@"retweetedAttributedText"])? YES : NO;
}


- (NSAttributedString *)attributedTextWithText:(NSString *)text {
    
    NSMutableAttributedString *atrributedText = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableArray *emotions = [NSMutableArray array];
    
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    
    NSString *patterns = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    [text enumerateStringsMatchedByRegex:patterns usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [atrributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
        
        if ([*capturedStrings hasPrefix:@"["] && [*capturedStrings hasSuffix:@"]"]) {
            SpecialText *emotion = [SpecialText textWithString:*capturedStrings range:*capturedRanges];
            [emotions insertObject:emotion atIndex:0];
        }
        
    }];
    
    for (SpecialText *emotionText in emotions) {
        NSTextAttachment *attatchment = [[NSTextAttachment alloc] init];
        Emotion *emotion = [ EmotionTool emotionWithChs:emotionText.string];
        NSLog(@"%@ %@ %@", emotionText.string, emotion.chs, emotion.png);

        if (emotion.png) {
            attatchment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", emotion.png]];
            attatchment.bounds = CGRectMake(0, 0, ContentFont.lineHeight, ContentFont.lineHeight);
            NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attatchment];
            [atrributedText replaceCharactersInRange:emotionText.range withAttributedString:attributedString];
        }
        
    }
    
    [atrributedText addAttribute:NSFontAttributeName value:ContentFont range:NSMakeRange(0, atrributedText.length)];

    return atrributedText;
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    
    self.attributedText = [self attributedTextWithText:text];
}

-(void)setRetweeted_status:(Status *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    NSString *forwardContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status.user.name, retweeted_status.text];
    self.retweetedAttributedText = [self attributedTextWithText:forwardContent];
}

- (NSString *)created_at {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"cn_ZH"];
    // Mon Dec 08 11:51:33 +0800 2014
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if (components.year == 0) {
        if ([createDate isToday]) {
            if (components.hour) {
                return [NSString stringWithFormat:@"%ld小时前", (long)components.hour];
            } else if (components.minute)
            {
                return [NSString stringWithFormat:@"%ld分钟前", (long)components.minute];
            } else {
                return @"刚刚";
            }
        } else if ([createDate isYesterday]){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { //今年其他时间
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { //其它年份
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}


- (void)setSource:(NSString *)source {
    
    if (!source.length) return;
    
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    
    _source = [NSString stringWithFormat:@"来自 %@", [source substringWithRange:range]];
}

@end
