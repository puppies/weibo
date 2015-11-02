//
//  User.m
//  weibo
//
//  Created by happy on 15/10/31.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "User.h"

@implementation User
//
//+ (instancetype)userWithDictionary:(NSDictionary *)dic {
//    User *user = [[self alloc] init];
//    if (user) {
//        user.idstr = dic[@"idstr"];
//        user.name = dic[@"name"];
//        user.profile_image_url = dic[@"profile_image_url"];
//    }
//    return user;
//}

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"vip"]) {
        return YES;
    }
    return NO;
}

@end
