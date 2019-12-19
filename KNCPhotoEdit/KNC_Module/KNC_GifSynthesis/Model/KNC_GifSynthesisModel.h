//
//  KNC_GifSynthesisModel.h
//  PSLongFigure
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
NS_ASSUME_NONNULL_BEGIN

@interface KNC_GifSynthesisModel : NSObject

- (void)composeGIF:(NSMutableArray *)imageArray outputPath:(NSString *)gifPath changeSpeed:(CGFloat)speed;//多张图片合成gif

- (UIImage *)changeIamge:(UIImage *)image fixedSize:(CGSize)size;

-(void)saveGIFImageInAlubm;

@end

NS_ASSUME_NONNULL_END
