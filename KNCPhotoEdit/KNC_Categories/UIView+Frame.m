//
//  UIView+Frame.m
//  PSLongFigure
//
//  Created by ghostlord on 2019/12/10.
//  Copyright © 2019年 ghostlord. All rights reserved.
//
#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGPoint)origin {
    return self.frame.origin;
}

#pragma mark - 扩展方法 --

/// 根据传入大小计算一个中间区域
/// @param size 所需大小
- (CGRect)gl_centerRectWithSize:(CGSize)size {
    
    CGPoint centerPoint = CGPointMake(self.size.width / 2.0, self.size.height / 2.0);
    
    CGRect centerRect = CGRectMake(centerPoint.x, centerPoint.y, 0, 0);
    
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        
        centerRect = CGRectMake(centerPoint.x - (size.width / 2.0), centerPoint.y - (size.height / 2.0), size.width, size.height);
    }
    
    return centerRect;
}

@end
