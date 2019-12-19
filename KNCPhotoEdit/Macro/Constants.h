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
#define SCREEN_Width   ([UIScreen mainScreen].bounds.size.width)
/* 屏幕高 */
#define SCREEN_Height  ([UIScreen mainScreen].bounds.size.height)
/* 最大的长度 */
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
/* 最小的长度 */
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// --------- 适配公共宏 ------
/** 控件缩放比例，按照宽度计算 */
#define SCALE_Length(l) (IS_PORTRAIT ? round((SCREEN_Width/375.0*(l))) : round((SCREEN_Width/667.0*(l))))

/** 是否是异形屏 */
#define IS_HETERO_SCREEN (PS_iPhone_X || PS_iPhone_X_Max)

/** 是否是竖屏 */
#define IS_PORTRAIT (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))

// -- 导航栏和Tabbar针对iPhone X 的适配  --
#define Nav_topH (IS_HETERO_SCREEN ? 88.0 : 64.0)
#define Tab_H (IS_HETERO_SCREEN ? 83.0 : 49.0)
#define NavMustAdd (IS_HETERO_SCREEN ? 34.0 : 0.0)
#define TabMustAdd (IS_HETERO_SCREEN ? 20.0 : 0.0)
#define Status_H  (IS_HETERO_SCREEN ? 44.0 : 20.0)
#define NavigationItem_H   (44.0)
#define Statue_Height (float)([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NavBar_height (float)(Statue_Height +44.0f)

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
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 16进制颜色
#define HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#define HexStringColor(hexString) 
// 16进制颜色带alpha通道
#define HexAlphaColor(hexValue, alpha) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:alpha]
// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 项目中主要颜色的定义
#define PSColorTheme                           HexColor(0x0061FF)     // 主题颜色
#define PSColorLong                            HexColor(0x28A351)     // 上涨颜色(绿色)
#define PSColorShort                           HexColor(0xcc3366)     // 下跌颜色(红色)
#define PSColorLongBG                          HexColor(0xEDF7EB)     // 上涨背景颜色(绿色背景)
#define PSColorShortBG                         HexColor(0xFDE7EE)     // 下跌背景颜色(红色背景)
#define PSColorTitle                           HexColor(0x333333)     // 用于主要文字提示，标题，重要文字
#define PSColorNormalText                      HexColor(0x666666)     // 正常字体颜色，二级文字，标签栏
#define PSColorTipText                         HexColor(0xB4B4B4)     // 提示文字，提示性文字，重要级别较低的文字信息
#define PSColorBorder                          HexColor(0xcccccc)     // 边框颜色，提示性信息
#define PSColorSeparator                       HexColor(0xeeeeee)     // 分割线颜色，宽度1像素
#define PSColorGap                             HexColor(0xF8F8F8)     // 背景间隔色彩
#define PSColorBackGround                      HexColor(0xffffff)     // 白色背景色
#define PSColorText_000000                     HexColor(0x000000)     // 黑色背景色
#define PSColorAlert_f8f8f8                    HexColor(0xf8f8f8)     // 首页收藏视图弹框颜色
#define PSColorWarning                         HexColor(0xFA0000)     // 警告颜色
#define PSColorMarketDetail                    HexColor(0xffffff)      // 行情详情页背景
#define PSColorAlert_BGColor                   HexAlphaColor(0x000000,0.4) //背景透明色

// 手机尺寸型号
#define PS_iPhone_4x        (SCREEN_Width == 320 && SCREEN_Height == 480)
#define PS_iPhone_5x        (SCREEN_Width == 320 && SCREEN_Height == 568)
#define PS_iPhone_6x        (SCREEN_Width == 375 && SCREEN_Height == 667)
#define PS_iPhone_plus      (SCREEN_Width == 414 && SCREEN_Height == 736)
#define PS_iPhone_X         (SCREEN_Width == 375 && SCREEN_Height == 812)   // iPhone X,    iPhone XS
#define PS_iPhone_X_Max     (SCREEN_Width == 414 && SCREEN_Height == 896)   // iPhone XR,   iPhone XS Max

// weak/strong self ----------
#define weakSelf(ref)           __weak __typeof(ref)weakSelf = ref;
#define strongSelf(weakRef)     __strong __typeof(weakRef)strongSelf = weakRef;

//--------------是非购买
#define isVip [KNC_HelpManager isVipLongFigure]

//按月购买
#define INVIPMONTH @"longFigureVipMonth"
//按年购买
#define INVIPYEAR @"longFigureVipYear"


#define PROTOCOLURL @"https://www.jianshu.com/p/41d2bec2760a"
#define AUTOFUFEI @"https://www.jianshu.com/p/d6624a215e28"

//-------广告Key---------
#define BaseADAPPID @"ca-app-pub-6864430072527422~8970632497"
//banner
#define BannerADID @"ca-app-pub-6864430072527422/8337025918"
//原生广告
#define NomalADID @"ca-app-pub-6864430072527422/5031387480"
//插屏广告
#define InteredADID @"ca-app-pub-6864430072527422/4049478303"
//激励广告
#define GULIADID @"ca-app-pub-6864430072527422/6344469154"

//测试Key
//#define BaseADAPPID @"ca-app-pub-3940256099942544~1458002511"
////banner
//#define BannerADID @"ca-app-pub-3940256099942544/2934735716"
////插屏广告
//#define InteredADID @"ca-app-pub-3940256099942544/4411468910"
////原生广告
//#define NomalADID @"ca-app-pub-3940256099942544/3986624511"
////激励广告
//#define GULIADID @"ca-app-pub-3940256099942544/1712485313"





