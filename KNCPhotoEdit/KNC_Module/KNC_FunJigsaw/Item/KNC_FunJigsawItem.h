//
//  KNC_FunJigsawItem.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNC_FunJigsawItem : NSObject
@property (nonatomic, assign, readonly) CGSize imgSize;
@property (nonatomic, strong) UIImage *imgiView;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) CGPoint sizeRatio;    // 宽高占行列的倍数，最小值为1
@property (nonatomic, assign) CGSize itemSize;      // 显示时占据的item的尺寸

+ (instancetype)pri_mmp_funJigsawItemWithSizeRatio:(CGPoint)sizeRatio img:(UIImage * _Nullable)img;

@end

NS_ASSUME_NONNULL_END
