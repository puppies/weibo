//
//  Emotion.h
//  weibo
//
//  Created by happy on 15/12/4.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Emotion : JSONModel

@property (nonatomic, copy) NSString *chs;
@property (nonatomic, copy) NSString *png;

@end
