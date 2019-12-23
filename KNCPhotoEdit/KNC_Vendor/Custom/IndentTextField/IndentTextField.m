//
//  IndentTextField.m
//  ASO
//
//  Created by kk_ghostlord on 2019/12/11.
//  Copyright © ASO. All rights reserved.
//

#import "IndentTextField.h"
#import <objc/message.h>
@implementation IndentTextField

/**
 重写初始化方法
 */
- (instancetype)init {
    
    return [self initWithFrame:CGRectZero indentWidth:10.0f];
}

/**
 重写初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:CGRectZero indentWidth:10.0f];
}

/**
 从xib创建时的初始化方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        _indentWidth = 10.f;
        // 初始化
        [self p_initialize];;
    }
    return self;
}

/**
 初始化一个带有左缩进的TextField
 
 @param frame 尺寸
 @param indentWidth 左缩进量
 */
- (instancetype)initWithFrame:(CGRect)frame indentWidth:(CGFloat)indentWidth {
    if (self = [super initWithFrame:frame]) {
        self.indentRightWidth = 0;
        if (indentWidth >= 0) {
            _indentWidth = indentWidth;
        }else {
            _indentWidth = 10.f;
        }
        
        // 初始化
        [self p_initialize];;
    }
    return self;
}

///**
// 从xib创建时的初始化设置
// */
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    _indentWidth = 10.f;
//    // 初始化
//    [self p_initialize];;
//}

#pragma mark - overWrite display rect method ---
/** 显示区域 */
- (CGRect)textRectForBounds:(CGRect)bounds {
    
    if (self.clearButtonMode != UITextFieldViewModeNever) {  // clear btn 存在
        if(self.leftViewMode != UITextFieldViewModeNever) {
            return CGRectMake(CGRectGetMaxX(self.leftView.frame) + self.indentWidth, 0, bounds.size.width - CGRectGetMaxX(self.leftView.frame) - self.indentWidth - 19.0f - self.indentRightWidth - self.rightView.frame.size.width, bounds.size.height);
        }else {
            return CGRectMake(self.indentWidth, 0, bounds.size.width - self.indentWidth - 19.0f -self.indentRightWidth - self.rightView.frame.size.width, bounds.size.height);
        }
        
    }else {
        return CGRectMake(self.indentWidth, 0, bounds.size.width - self.indentWidth - self.indentRightWidth - self.rightView.frame.size.width, bounds.size.height);
    }
}

/** 编辑区域 */
- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    if (self.clearButtonMode != UITextFieldViewModeNever) { // clearBtn 存在
        if(self.leftViewMode != UITextFieldViewModeNever) {
            return CGRectMake(CGRectGetMaxX(self.leftView.frame) + self.indentWidth, 0, bounds.size.width - CGRectGetMaxX(self.leftView.frame) - self.indentWidth - 19.0f - self.rightView.frame.size.width, bounds.size.height);
        }else {
            return CGRectMake(self.indentWidth, 0, bounds.size.width - self.indentWidth - 19.0f - self.rightView.frame.size.width, bounds.size.height);
        }
        
    }else {
        return CGRectMake(self.indentWidth, 0, bounds.size.width - self.indentWidth - self.rightView.frame.size.width, bounds.size.height);
    }
}

/**
 替换清除按钮的图片
 clearButton 大小是19*19
 clearButton 距离右边边界5
 图标大小是14*14
 */
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    [super clearButtonRectForBounds:bounds];
    
    // 此处稳定性有待测试
    Ivar clearBtn = class_getInstanceVariable([self class], "_clearButton");
    UIButton *btn = (UIButton *)object_getIvar(self, clearBtn);
    if (btn) {
        [btn setImage:self.clearBtnImage forState:UIControlStateNormal];
    }
    
    CGRect rect = CGRectMake(bounds.size.width - (19.0f + 5.0f), (bounds.size.height - 19.0) / 2.0, 19.0f, 19.0f);
    return rect;
}

#pragma mark - 重写弹出菜单的方法 ---
/**
 自定义弹出的菜单
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if(action == @selector(paste:) && self.isPasteEnable) {
        return YES;
    }
    
    if(action == @selector(selectAll:) && self.isSelectAllEnable) {
        return YES;
    }
    
    if (action == @selector(select:) && self.isSelectEnable) {
        return YES;
    }
    
    if (action == @selector(copy:) && self.isCopyEnable) {
        return YES;
    }
    
    return NO;
}

- (void)dealloc {
    // 移除观察者
    [self p_removeNotification];
    NSLog(@"indentTextField dealloc --- %p",self);
}

#pragma mark - set方法 --

/**
 设置placeHolderColor
 
 @param placeholderColor 占位文本颜色
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    if(placeholderColor && [placeholderColor isKindOfClass:[UIColor class]]) {
        _placeholderColor = placeholderColor;
        // 更新placeHolder
        [self p_updatePlaceHolderColorWithPlaceHolder:self.placeholder];
    }
}

/**
 设置placeHolder，重写父类set方法
 
 @param placeholder 占位文本
 */
- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    
    if (placeholder) {
        [self p_updatePlaceHolderColorWithPlaceHolder:placeholder];
    }
}

/** 替换清空按钮的图片 */
- (void)setClearBtnImage:(UIImage *)clearBtnImage {
    
    if (clearBtnImage && [clearBtnImage isKindOfClass:[UIImage class]]) {
        
        _clearBtnImage = clearBtnImage;
    }
}

#pragma mark - 懒加载等get方法 ---

- (BOOL)isSelectEnable {
    return _selectEnable;
}

- (BOOL)isSelectAllEnable {
    return _selectAllEnable;
}

- (BOOL)isCopyEnable {
    return _copyEnable;
}

- (BOOL)isPasteEnable {
    return _pasteEnable;
}

#pragma mark - 私有方法 ----

/**
 初始化方法
 */
- (void)p_initialize {
    
    self.selectEnable = YES;
    self.pasteEnable = YES;
    self.selectAllEnable = YES;
    self.copyEnable = YES;
    self.lenLimit = -1;
    
    // 添加观察者
    [self p_addNotification];
}

/**
 添加观察者
 */
- (void)p_addNotification {
    // 防止重复注册
    [self p_removeNotification];
    
    // 文字已经改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    // 开始编辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_textDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    // 结束编辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_textDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}


/**
 移除观察者
 */
- (void)p_removeNotification {
    
    // 文字已经改变
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
    // 开始编辑
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    // 结束编辑
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
}


/**
 设置placeHolder
 */
- (void)p_updatePlaceHolderColorWithPlaceHolder:(NSString *)placeHolder {
    
    if (placeHolder && placeHolder.length >= 1) {
        
        if (_placeholderColor) {
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:_placeholderColor}];
            self.attributedPlaceholder = attributeString;
        }
    }
}

/**
 文字已经改变
 */
- (void)p_textDidChange:(NSNotification *)notification {
    if (![notification.object isEqual:self]) {
        return;
    }
    // 空格过滤
    if(self.isFilterSpace) {
        NSString *tempString = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.text = tempString;
    }
    // 统一小数点显示
    if (self.keyboardType == UIKeyboardTypeDecimalPad && self.isUniteDecimalPointType) {
        NSString *tempString = [self.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
        self.text = tempString;
    }
    
    NSDictionary *info = nil;
    
    if (notification.userInfo) {
        info = notification.userInfo;
    }
    
    // 小数位数限制
    if (self.isNum) {
        // 判断小数位数
        NSArray *array = [self.text componentsSeparatedByString:@"."];
        
        if (array.count >= 2) { // 限制小数位数为8，只有一个小数点
            NSMutableString *decimalStr = @"".mutableCopy;
            for (int a = 0;  a < array.count; a ++) {
                if (a >= 1) {
                    [decimalStr appendString:[array objectAtIndex:a]];
                }
            }
            
            if (decimalStr.length > self.decimal) {
                decimalStr = [decimalStr substringToIndex:self.decimal].mutableCopy;
            }
            
            NSMutableString *interString = [[array firstObject] mutableCopy];
            if (self.decimal >= 1) {
                [interString appendFormat:@".%@",decimalStr];
            }
            
            self.text = interString;
        }
    }
    
    // 字符串个数限制
    if(self.lenLimit > 0 && self.text.length > self.lenLimit) {
        // 已超出字符串限制
        self.text = [self.text substringToIndex:self.lenLimit];
        
        !self.beyondLengthLimitBlock ? : self.beyondLengthLimitBlock( self , self.lenLimit);
    }
    
    
    !self.textChangeBlock ? : self.textChangeBlock(self, info);
    
    if(_indentTextFieldDelegate && [_indentTextFieldDelegate respondsToSelector:@selector(textField:textDidChangeWithUserInfo:)]) {
        [_indentTextFieldDelegate textField:self textDidChangeWithUserInfo:info];
    }
}

/**
 开始编辑
 */
- (void)p_textDidBeginEditing:(NSNotification *)notification {
    if (![notification.object isEqual:self]) {
        return;
    }
    
    
    NSDictionary *info = nil;
    
    if (notification.userInfo) {
        info = notification.userInfo;
    }
    
    !self.beginEditingBlock ? : self.beginEditingBlock(self , info);
    
    if(_indentTextFieldDelegate && [_indentTextFieldDelegate respondsToSelector:@selector(textField:textDidBeginEditingWithUserInfo:)]) {
        [_indentTextFieldDelegate textField:self textDidBeginEditingWithUserInfo:info];
    }
}

/**
 结束编辑
 */
- (void)p_textDidEndEditing:(NSNotification *)notification {
    
    if (![notification.object isEqual:self]) {
        return;
    }
    
    NSDictionary *info = nil;
    
    if (notification.userInfo) {
        info = notification.userInfo;
    }
    
    !self.endEditingBlock ? : self.endEditingBlock(self, info);
    
    if(_indentTextFieldDelegate && [_indentTextFieldDelegate respondsToSelector:@selector(textField:textDidEndEditingWithUserInfo:)]) {
        [_indentTextFieldDelegate textField:self textDidEndEditingWithUserInfo:info];
    }
}

@end
