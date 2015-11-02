//
//  AccountTool.m
//  weibo
//
//  Created by happy on 15/10/30.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "AccountTool.h"

#define AccountArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@interface AccountTool ()

//@property (nonatomic)Account *account;

@end

@implementation AccountTool

+ (void)saveAccount:(Account *)account {
    
    account.auth_time = [NSDate date];
    
    [NSKeyedArchiver archiveRootObject:account toFile:AccountArchivePath];

}

+ (Account *)account {
    
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountArchivePath];
    
    long long expires_in = account.expires_in;
    
    NSDate *expiresTime = [account.auth_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    return account;
}

@end
