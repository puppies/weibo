//
//  NSDate+extension.m
//  weibo
//
//  Created by happy on 15/11/5.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "NSDate+extension.h"

@implementation NSDate (extension)

- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MMM-dd";
    
    NSString *dateString = [fmt stringFromDate:self];
    
    NSDate *now = [NSDate date];
    NSString *nowString = [fmt stringFromDate:now];
    
    return [dateString isEqualToString:nowString];
}

- (BOOL)isYesterday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MMM-dd";
    
    NSString *dateString = [fmt stringFromDate:self];
    NSDate *date = [fmt dateFromString:dateString];
    
    NSDate *now = [NSDate date];
    NSString *nowString = [fmt stringFromDate:now];
    now = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *dateComponet = [calendar components:unit fromDate:date toDate:now options:0];
    
    return dateComponet.year == 0 && dateComponet.month == 0 && dateComponet.day == 1;
}

@end
