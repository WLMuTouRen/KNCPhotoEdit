//
//  UIButton+Help.h
//  PSLongFigure
//
//  Created by ghostlord on 2019/12/10.
//  Copyright © 2019年 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Help)

- (void)setBackgroundColorNormal:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor;

- (void)            buttonWithNormalImageName:(NSString *)normalImageName
                         highlightedImageName:(NSString *)highlightedImageName
                                   edgeInsets:(UIEdgeInsets)edgeInsets
                               layerImageName:(NSString *)layerImageName
                                    titleName:(NSString *)titleName
                                    titleFont:(float)titleFont
                                       target:(id)target
                                       action:(SEL)sel;

- (void)        buttonWithSelectedImageName:(NSString*)selectedImageName
                          disabledImageName:(NSString*)disabledImageName
                                 edgeInsets:(UIEdgeInsets)edgeInsets;

- (void)        buttonWithNormalTitleColor:(UIColor *)normalColor
                     highlightedTitleColor:(UIColor *)highlightedColor;

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                       target:(id)target
                       action:(SEL)action;
@end    
