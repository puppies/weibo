//
//  Status.m
//  weibo
//
//  Created by happy on 15/10/31.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "Status.h"
#import "User.h"

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


@end
