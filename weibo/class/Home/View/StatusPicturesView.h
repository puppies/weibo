//
//  StatusPicturesView.h
//  weibo
//
//  Created by happy on 15/11/6.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusPicturesView : UIView

@property (nonatomic)NSArray *pictures;

+ (CGSize)sizeWithPicturesNumber:(unsigned long)count;

@end
