//
//  Comment.h
//  weibo
//
//  Created by happy on 15/12/11.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@class User;
@interface Comment : JSONModel

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic)User *user;

@end
