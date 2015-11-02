//
//  AccountTool.h
//  weibo
//
//  Created by happy on 15/10/30.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
@class Account;

@interface AccountTool : NSObject

+ (void)saveAccount:(Account *)account;
+ (Account *)account;

@end
