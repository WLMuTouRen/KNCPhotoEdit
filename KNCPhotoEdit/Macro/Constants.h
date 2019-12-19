//
//  Constants.h
//  PSLongFigure
//
//  Created by Mac on 2019/12/10.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>

// ----------- 公共尺寸 ------
/* 屏幕宽 */
#define KNC_SCREEN_W   ([UIScreen mainScreen].bounds.size.width)
/* 屏幕高 */
#define KNC_SCREEN_H  ([UIScreen mainScreen].bounds.size.height)
/* 最大的长度 */
#define SCREEN_MAX_LENGTH (MAX(KNC_SCREEN_W, KNC_SCREEN_H))
/* 最小的长度 */
#define SCREEN_MIN_LENGTH (MIN(KNC_SCREEN_W, KNC_SCREEN_H))

// --------- 适配公共宏 ------
/** 控件缩放比例，按照宽度计算 */
#define KNC_SCALE_Length(l) (IS_PORTRAIT ? round((KNC_SCREEN_W/375.0*(l))) : round((KNC_SCREEN_W/667.0*(l))))

/** 是否是异形屏 */
#define IS_HETERO_SCREEN (KNC_iPhone_X || KNC_iPhone_X_Max)

/** 是否是竖屏 */
#define IS_PORTRAIT (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))

// -- 导航栏和Tabbar针对iPhone X 的适配  --
#define KNC_Nav_topH (IS_HETERO_SCREEN ? 88.0 : 64.0)
#define KNC_Tab_H (IS_HETERO_SCREEN ? 83.0 : 49.0)
#define KNC_NavMustAdd (IS_HETERO_SCREEN ? 34.0 : 0.0)
#define KNC_TabMustAdd (IS_HETERO_SCREEN ? 20.0 : 0.0)
#define KNC_Status_H  (IS_HETERO_SCREEN ? 44.0 : 20.0)
#define KNC_NavigationItem_H   (44.0)
#define KNC_Statue_Height (float)([[UIApplication sharedApplication] statusBarFrame].size.height)
#define KNC_NavBar_height (float)(KNC_Statue_Height +44.0f)

// 防空判断 ------------
/** 字符串防空判断 */
#define isStrEmpty(string) (string == nil || string == NULL || (![string isKindOfClass:[NSString class]]) || ([string isEqual:@""]) || [string isEqualToString:@""] || [string isEqualToString:@" "] || ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0))

/* 返回一个非空的字符串 */
#define STRINGNOTNIL(string) isStrEmpty(string) ? @"" : string

/** 数组防空判断  */
#define isArrEmpty(array) (array == nil || array == NULL || (![array isKindOfClass:[NSArray class]]) || array.count == 0)
/** 字典防空判断 */
#define isDictEmpty(dict) (dict == nil || dict == NULL || (![dict isKindOfClass:[NSDictionary class]]) || dict.count == 0)

// ---- 颜色创建宏 -----
#define KNC_RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 16进制颜色
#define KNC_HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#define KNC_HexStringColor(hexString)
// 16进制颜色带alpha通道
#define KNC_HexAlphaColor(hexValue, alpha) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:alpha]
// 随机色
#define KNC_RandomColor KNC_RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 项目中主要颜色的定义
#define KNCMianColor                           KNC_HexColor(0xFE8F53)     // 主题颜色
// 手机尺寸型号
#define KNC_iPhone_4x        (KNC_SCREEN_W == 320 && KNC_SCREEN_H == 480)
#define KNC_iPhone_5x        (KNC_SCREEN_W == 320 && KNC_SCREEN_H == 568)
#define KNC_iPhone_6x        (KNC_SCREEN_W == 375 && KNC_SCREEN_H == 667)
#define KNC_iPhone_plus      (KNC_SCREEN_W == 414 && KNC_SCREEN_H == 736)
#define KNC_iPhone_X         (KNC_SCREEN_W == 375 && KNC_SCREEN_H == 812)   // iPhone X,    iPhone XS
#define KNC_iPhone_X_Max     (KNC_SCREEN_W == 414 && KNC_SCREEN_H == 896)   // iPhone XR,   iPhone XS Max

// weak/strong self ----------
#define weakSelf(ref)           __weak __typeof(ref)weakSelf = ref;
#define strongSelf(weakRef)     __strong __typeof(weakRef)strongSelf = weakRef;

//--------------是非购买
#define isVip [KNC_HelpManager isVipPhotoEdit]
//按月购买
#define KNC_VIPMONTH @"KNCPhotoEditVipMonth"
//按年购买
#define KNC_VIPYEAR @"KNCPhotoEditVipYear"

#define KNC_POLICYURL @"https://www.jianshu.com/p/41d2bec2760a"
#define KNC_RENEWURL @"https://www.jianshu.com/p/d6624a215e28"




