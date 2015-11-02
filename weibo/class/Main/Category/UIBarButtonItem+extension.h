//
//  UIBarButtonItem+extension.h
//  weibo
//
//  Created by happy on 15/10/29.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;

@end
