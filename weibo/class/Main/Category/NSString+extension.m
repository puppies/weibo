//
//  NSString+extension.m
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)

- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(float)MaxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(MaxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxWidth:MAXFLOAT];
}

@end
