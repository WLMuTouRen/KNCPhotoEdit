//
//  IndentTextField.h
//  ASO
//
//  Created by kk_ghostlord on 2019/12/11.
//  Copyright © ASO. All rights reserved.
//

/* 可以设置缩进、长按弹出菜单、监听文本变化代理的TextFiled子类 */

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class IndentTextField;
/* 文字已经改变的block */
typedef void(^TextDidChangeBlocke)(IndentTextField *field , NSDictionary *info);

/* 文本框开始编辑的block */
typedef void(^TextFieldBeginEditingBlock)(IndentTextField *field , NSDictionary *info);

/* 文本框结束编辑的block */
typedef void(^TextFieldDidEndEditingBlock)(IndentTextField *field , NSDictionary *info);

/* 文本框超出文字个数限制的block */
typedef void(^TextFieldDidMoreThanLengthLimitBlock)(IndentTextField *field, NSInteger limit);

@protocol UITextFieldOtherProtocol <NSObject>
@optional
/**
 输入框文字改变的回调
 
 @param textField 输入框
 @param info 其他信息
 */
- (void)textField:(IndentTextField *)textField textDidChangeWithUserInfo:(NSDictionary * _Nullable)info;

/**
 输入框开始编辑的回调
 
 @param textField 输入框
 @param info 其他信息
 */
- (void)textField:(IndentTextField *)textField textDidBeginEditingWithUserInfo:(NSDictionary * _Nullable)info;

/**
 输入框结束编辑的回调
 
 @param textField 输入框
 @param info 其他信息
 */
- (void)textField:(IndentTextField *)textField textDidEndEditingWithUserInfo:(NSDictionary * _Nullable)info;

@end

@interface IndentTextField : UITextField
/** 是否允许选择 默认为YES(允许) */
@property (assign, nonatomic, getter=isSelectedEnable) BOOL selectEnable;

/** 是否允许选择全部 默认为YES(允许) */
@property (assign, nonatomic, getter=isSelectAllEnable) BOOL selectAllEnable;

/** 是否允许粘贴 默认为YES(允许) */
@property (assign, nonatomic, getter=isPasteEnable) BOOL pasteEnable;

/** 是否允许复制 默认为YES(允许) */
@property (assign, nonatomic, getter=isCopyEnable) BOOL copyEnable;

/** 左缩进的宽度 */
@property (assign, nonatomic) CGFloat indentWidth;

/** 右缩进的宽度 */
@property (assign, nonatomic) CGFloat indentRightWidth;

/** placeHolder颜色 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**  小数点位数限制 */
@property (assign, nonatomic) NSInteger decimal;

/**  是否是纯数字 */
@property (assign, nonatomic) BOOL isNum;

/**  输入字符个数限制 ,默认为 -1,不限个数 */
@property (assign, nonatomic) NSInteger lenLimit;

/**  是否需要统一小数点,默认不统一，只在keyBoradType 为UIKeyboardTypeDecimalPad生效 */
@property (assign, nonatomic) BOOL isUniteDecimalPointType;

/**  是否过滤空格,默认为NO */
@property (assign, nonatomic) BOOL isFilterSpace;

/** 文字改变的block */
@property (copy, nonatomic) TextDidChangeBlocke textChangeBlock;

/** 文本框开始编辑的block */
@property (copy, nonatomic) TextFieldBeginEditingBlock beginEditingBlock;

/** 文本框结束编辑的block */
@property (copy, nonatomic) TextFieldDidEndEditingBlock endEditingBlock;

/** 文本框超出个数限制的block */
@property (copy, nonatomic) TextFieldDidMoreThanLengthLimitBlock beyondLengthLimitBlock;

/**
 清空按钮的图片
 
 clearButton 大小是19*19
 图标大小是14*14
 */
@property (strong, nonatomic) UIImage *clearBtnImage;

/**
 代理
 */
@property (weak, nonatomic) id<UITextFieldOtherProtocol> indentTextFieldDelegate;

/**
 初始化一个带有左缩进的TextField
 
 @param frame 尺寸
 @param indentWidth 左缩进量 ,默认是10
 */
- (instancetype)initWithFrame:(CGRect)frame indentWidth:(CGFloat)indentWidth NS_DESIGNATED_INITIALIZER;

/* 初始化方法*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end
NS_ASSUME_NONNULL_END
