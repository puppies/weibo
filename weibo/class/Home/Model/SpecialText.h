//
//  SpecialText.h
//  weibo
//
//  Created by happy on 15/12/3.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialText : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign)NSRange range;

+ (instancetype)textWithString:(NSString *)string range:(NSRange)range;

@end
