//
//  User.h
//  weibo
//
//  Created by happy on 15/10/31.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface User : JSONModel

@property (nonatomic, copy)NSString *idstr;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *profile_image_url;
@property (nonatomic, assign)int mbrank;
@property (nonatomic, assign)int mbtype;
@property (nonatomic, assign, getter=isVip)BOOL vip;



//+ (instancetype)userWithDictionary:(NSDictionary *)dic;

@end
