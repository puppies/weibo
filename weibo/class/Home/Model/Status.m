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
    return [propertyName isEqualToString:@"retweeted_status"]? YES : NO;
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
