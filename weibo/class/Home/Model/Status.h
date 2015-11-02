//
//  Status.h
//  weibo
//
//  Created by happy on 15/10/31.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@class User;

@interface Status : JSONModel

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
//@property (nonatomic, copy) NSString *thumbnail_pic;
//@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, copy) NSString *reposts_count;
@property (nonatomic, copy) NSString *comments_count;
//@property (nonatomic)NSArray *pic_ids;

@property (nonatomic)User *user;

//+ (instancetype)statusWithDictionary:(NSDictionary *)dic;

@end
