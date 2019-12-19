//
//  KNC_ImageTool.h
//  PictureStitch
//
//  Created by 翔 on 2019/12/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNC_ImageTool : NSObject

/**
 *  生成带水印的图片
 *
 *  @param backImage  背景图片
 *  @param waterImage 水印图片
 *  @param waterRect  水印位置及大小
 *  @param alpha      水印透明度
 *  @param waterScale 水印是否根据Rect改变长宽比
 *
 *  @return 新生成的图片
 */
+(UIImage *)GetWaterPrintedImageWithBackImage:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale;
/**
 *
 *   生成带（文字）水印的图片
 *
 *  @param markString   将要添加的文字
 *  @param point    将要添加的文字在图片上的位置
 *  @param font      文字大小
 *  @param image  将要添加文字的图片
 *
 *  @return 已打好水印的图片
 */
+ (UIImage *)imageWithStringWaterMark:(NSString *)markString
                              atPoint:(CGPoint)point
                               atFont:(UIFont*)font
                               andImg:(UIImage *)image;


/**
 * 将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;

/**
 * 将图片已设备宽为标准缩放
 * UIImage image 原始的图片
 */
+(UIImage*)ps_screenWidthWithImage:(UIImage *)image;



/**
 * 把一组图片拼接为一张长图
 *
 * imageArray 图片资源
 */
+(UIImage *)ps_groupImageMergeWithLongImageWithImageArray:(NSArray *)imageArray;

//指定宽度按比例缩放
+ (UIImage *)ps_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;


@end

NS_ASSUME_NONNULL_END
