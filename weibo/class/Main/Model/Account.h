//
//  Account.h
//  weibo
//
//  Created by happy on 15/10/30.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

@property (nonatomic, copy)NSString *access_token;
@property (nonatomic, assign)long long expires_in;
@property (nonatomic, assign)long long uid;
@property (nonatomic)NSDate *auth_time;

+ (instancetype)accountWithDictionary:(NSDictionary *)dic;

@end
