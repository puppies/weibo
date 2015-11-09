//
//  ComposePicturesView.h
//  weibo
//
//  Created by happy on 15/11/9.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposePicturesView : UIView

@property (nonatomic, readonly)NSMutableArray *pictures;

- (void)addPicture:(UIImage *)image;

@end
