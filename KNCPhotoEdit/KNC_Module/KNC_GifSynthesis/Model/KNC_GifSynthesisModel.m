//
//  KNC_GifSynthesisModel.m
//  PSLongFigure
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_GifSynthesisModel.h"

@implementation KNC_GifSynthesisModel


/*
 图片集合合成gif图
 imageArray: 图片路径数组
 */
- (void)composeGIF:(NSMutableArray *)imageArray outputPath:(NSString *)gifPath changeSpeed:(CGFloat)speed{
    //图像目标
    CGImageDestinationRef destination;
    CFURLRef url=CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)gifPath, kCFURLPOSIXPathStyle, false);
    //通过一个url返回图像目标
    destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, imageArray.count, NULL);
    //设置gif的信息,播放间隔时间,基本数据,和delay时间,可以自己设置
    NSDictionary *frameProperties = [NSDictionary dictionaryWithObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:speed], (NSString *)kCGImagePropertyGIFDelayTime, nil] forKey:(NSString *)kCGImagePropertyGIFDictionary];
    //设置gif信息
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    //颜色
    [dict setObject:[NSNumber numberWithBool:YES] forKey:(NSString*)kCGImagePropertyGIFHasGlobalColorMap];
    //颜色类型
    [dict setObject:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    //颜色深度
    [dict setObject:[NSNumber numberWithInt:8] forKey:(NSString*)kCGImagePropertyDepth];
    //是否重复
    [dict setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    NSDictionary * gifproperty = [NSDictionary dictionaryWithObject:dict forKey:(NSString *)kCGImagePropertyGIFDictionary];
    //合成gif
    for (UIImage *image in imageArray){
        CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)frameProperties);
    }
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifproperty);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
}

- (UIImage *)changeIamge:(UIImage *)image fixedSize:(CGSize)size{
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(size);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = size.width;
    thumbnailRect.size.height = size.height;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage ;
}

-(void)saveGIFImageInAlubm{
    NSData *gifData = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:synthesisPath]];
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypePhoto data:gifData options:nil];
    } error: nil];
}

@end
