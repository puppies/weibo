//
//  EmotionTool.h
//  weibo
//
//  Created by happy on 15/12/4.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Emotion;

@interface EmotionTool : NSObject

+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;

+ (Emotion *)emotionWithChs:(NSString *)chs;

@end
