//
//  KNC_ImageTool.m
//  PictureStitch
//
//  Created by 翔 on 2019/12/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_ImageTool.h"

@implementation KNC_ImageTool

/**
 *  生成带（图片）水印的图片
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
                                   waterScale:(BOOL)waterScale{
  //说明，在最后UIImageView转UIImage的时候，View属性的size会压缩成1倍像素的size,所以本方法内涉及到Size的地方需要乘以2或3，才能保证最后的清晰度
    
    //默认制作X2像素，也可改成3或其它
    CGFloat clear = 3;
    
    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    backIMGV.frame = CGRectMake(0,
                                0,
                                backImage.size.width*clear,
                                backImage.size.height*clear);
    backIMGV.contentMode = UIViewContentModeScaleAspectFill;
    backIMGV.image = backImage;
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(waterRect.origin.x*clear,
                                 waterRect.origin.y*clear,
                                 waterRect.size.width*clear,
                                 waterRect.size.height*clear);
    if (waterScale) {
        waterIMGV.contentMode = UIViewContentModeScaleToFill;
    }else{
        waterIMGV.contentMode = UIViewContentModeScaleAspectFill;
    }
    waterIMGV.alpha = alpha;
    waterIMGV.image = waterImage;
    
    [backIMGV addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:backIMGV];
    return outImage;
}

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
+ (UIImage *)imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point atFont:(UIFont*)font andImg:(UIImage *)image {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([image size], NO, 0.0);
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([image size]);
    }
#endif
    
    //文字颜色
    UIColor *magentaColor   = [UIColor whiteColor];
    [magentaColor set];
    //原图
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIFont *helveticaBold = font;
    //水印文字
    [markString drawInRect:CGRectMake(point.x, point.y, image.size.width, image.size.height)
            withAttributes:@{NSFontAttributeName: helveticaBold,
                             NSForegroundColorAttributeName: magentaColor
            }];
    //返回新的图片
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

/**
 *  把UIView渲染成图片
 注 : ios 编程像素和实际显示像素不同，在X2和X3的retina屏幕设备上，使用此方法生成的图片大小将会被还原成1倍像素，
 从而导致再次显示到UIImageView上显示时，清晰度下降。所以使用此方法前，请先将要转换的UIview及它的所有SubView
 的frame里的坐标和大小都根据需要X2或X3。
 *
 *  @param view 想渲染的UIView
 *
 *  @return 渲染出的图片
 */
+(UIImage *)imageWithUIView:(UIView *)view{

    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
}

/**
 * 将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+(UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size{

    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    
    // 将图片按照指定大小绘制
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;

}

/**
 * 将图片已设备宽为标准缩放
 * UIImage image 原始的图片
 */
+(UIImage*)ps_screenWidthWithImage:(UIImage *)image{
    CGSize size;
    size.width = KNC_SCREEN_W;
    size.height = (image.size.height /KNC_SCREEN_H) *KNC_SCREEN_W;
    
    
    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    
    // 将图片按照指定大小绘制
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;

}


/**
 * 把一组图片拼接为一张长图
 *
 * imageArray 图片资源
 */
+(UIImage *)ps_groupImageMergeWithLongImageWithImageArray:(NSArray *)imageArray{
    
    NSMutableArray *tempArray = imageArray.mutableCopy;
    UIImage *longImage = tempArray.firstObject;
    [tempArray removeObjectAtIndex:0];
    
     for (UIImage *tempImage in tempArray) {
         longImage = [self addSlaveImage:tempImage toMasterImage:longImage];
     }
    
//    UIImage * outImage = [self ps_screenWidthWithImage:longImage];
    
    return longImage;
    
}


/**
 *  图片拼接
 *  slaveImage     拼接图
 *  masterImage  主图
 */
+ (UIImage *)addSlaveImage:(UIImage *)slaveImage toMasterImage:(UIImage *)masterImage {
    CGSize size;
    size.width = masterImage.size.width;
    size.height = masterImage.size.height + slaveImage.size.height;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    [masterImage drawInRect:CGRectMake(0, 0, masterImage.size.width, masterImage.size.height)];
    
    [slaveImage drawInRect:CGRectMake(0, masterImage.size.height, masterImage.size.width, slaveImage.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}


//指定宽度按比例缩放
+ (UIImage *)ps_imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{

    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
