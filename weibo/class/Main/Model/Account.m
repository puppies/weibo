//
//  Account.m
//  weibo
//
//  Created by happy on 15/10/30.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)accountWithDictionary:(NSDictionary *)dic {
    Account *account = [[Account alloc] init];
    account.access_token = dic[@"access_token"];
    account.expires_in = [dic[@"expires_in"] longLongValue];
    account.uid = [dic[@"uid"] longLongValue];
    
    return account;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeInt64:self.expires_in forKey:@"expires_in"];
    [coder encodeInt64:self.uid forKey:@"uid"];
    [coder encodeObject:self.auth_time forKey:@"auth_time"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self.access_token = [coder decodeObjectForKey:@"access_token"];
    self.expires_in = [coder decodeInt64ForKey:@"expires_in"];
    self.uid = [coder decodeInt64ForKey:@"uid"];
    self.auth_time = [coder decodeObjectForKey:@"auth_time"];
    
    return self;
}

@end
