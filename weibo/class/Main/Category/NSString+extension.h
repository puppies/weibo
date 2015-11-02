//
//  NSString+extension.h
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+extension.h"

@interface NSString (extension)

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(float)MaxW;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
@end
