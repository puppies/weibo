//
//  SpecialText.m
//  weibo
//
//  Created by happy on 15/12/3.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "SpecialText.h"

@implementation SpecialText

+ (instancetype)textWithString:(NSString *)string range:(NSRange)range {
    SpecialText *text = [[SpecialText alloc] init];
    text.string = string;
    text.range = range;
    
    return text;
}
@end
