//
//  UIView+Frame.m
//  PSLongFigure
//
//  Created by ghostlord on 2019/12/10.
//  Copyright © 2019年 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// 在分类中 @property 只会生成get, set方法,并不会生成下划线的成员属性

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

/// 根据传入大小计算一个中间区域
/// @param size 所需大小
- (CGRect)gl_centerRectWithSize:(CGSize)size;
@end
