//
//  StatusFrame.h
//  weibo
//
//  Created by happy on 15/11/2.
//  Copyright © 2015年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+extension.h"
@class Status;

#define Padding 10
#define CellPadding 20
#define NameFont [UIFont systemFontOfSize:13]
#define TimeFont [UIFont systemFontOfSize:10]
#define SourceFont TimeFont
#define ContentFont [UIFont systemFontOfSize:14]

@interface StatusFrame : NSObject

@property (nonatomic, assign)CGRect originF;
@property (nonatomic, assign)CGRect iconF;
@property (nonatomic, assign)CGRect nameF;
@property (nonatomic, assign)CGRect vipF;
@property (nonatomic, assign)CGRect timeF;
@property (nonatomic, assign)CGRect sourceF;
@property (nonatomic, assign)CGRect contentF;
@property (nonatomic, assign)CGRect pictureF;

@property (nonatomic, assign)CGRect forwardF;
@property (nonatomic, assign)CGRect forwardContentF;
@property (nonatomic, assign)CGRect forwardPictureF;


@property (nonatomic, assign)CGRect toolF;
@property (nonatomic, assign)CGRect commentBtnF;
@property (nonatomic, assign)CGRect forwardBtnF;
@property (nonatomic, assign)CGRect likeBtnF;


@property (nonatomic, assign)CGFloat cellHeight;


@property (nonatomic)Status *status;

+ (NSArray *)framesWithStatuses:(NSArray *)statuses;

@end
