//
//  ToolBar.h
//  weibo
//
//  Created by happy on 15/11/9.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBar : UIView

- (void)addButton:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end
