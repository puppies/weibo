//
//  EmotionTool.m
//  weibo
//
//  Created by happy on 15/12/4.
//  Copyright © 2015年 happy. All rights reserved.
//

#import "EmotionTool.h"
#import "JSONModel.h"
#import "Emotion.h"
#import "EmotionGroup.h"
#import "JSONModel.h"

@implementation EmotionTool

static NSArray *_defaultEmotions, *_lxhEmotions;

+ (NSArray *)defaultEmotions {
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons/default/info.plist" ofType:nil];
        EmotionGroup *defaultGroup = [[EmotionGroup alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:path] error:nil];

        _defaultEmotions = defaultGroup.emoticon_group_emoticons;
    }
    return _defaultEmotions;
}

+ (NSArray *)lxhEmotions {
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Emoticons/lxh/info.plist" ofType:nil];
        EmotionGroup *lxhGroup = [[EmotionGroup alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:path] error:nil];

        _lxhEmotions = lxhGroup.emoticon_group_emoticons;
    }
    return _lxhEmotions;
}

+ (Emotion *)emotionWithChs:(NSString *)chs {
    
    for (Emotion *emotion in [self defaultEmotions]) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    for (Emotion *emotion in [self lxhEmotions]) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    return nil;
}

@end
