//
//  KNC_HelpManager.h
//  PSLongFigure
//
//  Created by lg on 2019/12/09.
//  Copyright © 2019年 lg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KNC_HelpManager : NSObject
#pragma mark 判断是否是中文
+(BOOL)isAllChinese:(NSString *)str;
#pragma mark NSUserDefaults操作
+(id)objectForKey:(NSString *)defaultName;
+(void)setObject:(id)value forKey:(NSString *)defaultName;
#pragma mark 从服务器取字符串、字典、数组数据-防止服务器返回非法数据类型
+(NSString *)getStr:(id)str;
+(NSDictionary *)getDic:(id)dic;
+(NSArray *)getArray:(id)array;
#pragma mark 关于对象和josn串互转的
+(NSString *)changeObjectToJsonStr:(id)object;
+(id)changeJsonStrToObject:(NSString *)jsonStr;
#pragma mark 获取当前时间
+(NSString *)getNowTime;
+(NSString *)getNowTime1;
+(NSString *)getNowTime2;
#pragma mark 获取当前时间戳精确到毫秒
+(NSString *)getNowTime3;
+(NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+(NSString *)getToNowTimeWithIntervalString:(NSString *)timeString;
+(NSString *)changeMiaoToHMS:(NSString*)miao;
#pragma mark 根据字符串计算字符串高度
+(float)getHeightWithStr:(NSString *)str font:(float)strFont width:(float)width;
#pragma mark 根据字符串计算字符串宽度
+(float)getWidthWithStr:(NSString *)str font:(float)strFont height:(float)height;
#pragma mark 根据字符串计算有行间距的字符串高度
+(float)getHeightWithStr:(NSString *)str font:(float)strFont width:(float)width lineSpacing:(float)lineSpacing;
#pragma mark 获取最上层controller
+ (UIViewController *)topViewController;



#pragma mark 彩图变黑白
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;//透明变黑
+ (UIImage*)grayscaleImageForImage:(UIImage*)image;//透明还是透明
#pragma mark 颜色生成图片的方法，可用于给按钮设置选中颜色
+(UIImage*) createImageWithColor:(UIColor*) color;
#pragma mark 改变按钮图片和文字的位置右侧
+(void)changeBtnImageToRight:(UIButton *)btn;
#pragma mark 禁用返回手势
+(void)disableRightSlipBack;
#pragma mark 开启返回手势
+(void)ableRightSlipBack;
#pragma mark 显示及隐藏提示框
+(void)showHUDWithTitle:(NSString *)str;
+(void)hideHUDWithTitle:(NSString *)str;
+(void)hideHUD;


#pragma mark 获取图片缓存地址-文件夹
+(NSString *)getImagePath;
#pragma mark 获取沙河目录图片
+(UIImage*)getImgWithImgName:(NSString*)name;
#pragma mark 向沙河存入图片
+(BOOL)saveImgWithImg:(UIImage*)image andImgName:(NSString*)name;
#pragma mark 删除图片数据
+(BOOL)deleteImgWithImgName:(NSString*)name;
+(NSArray*)getLanguageArrayHaveAuto:(BOOL)isHaveAuto andExcludeName:(NSString*)nameStr;


+(BOOL)isVipPhotoEdit;
+(NSString *)getSystemLanuge;

@end
