//
//  EmotionGroup.m
//  weibo
//
//  Created by happy on 15/12/4.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "EmotionGroup.h"
#import "JSONModel.h"

@implementation EmotionGroup

+ (NSString *)protocolForArrayProperty:(NSString *)propertyName {
    
    return [propertyName isEqualToString:@"emoticon_group_emoticons"]? @"Emotion" : nil;
}

@end
