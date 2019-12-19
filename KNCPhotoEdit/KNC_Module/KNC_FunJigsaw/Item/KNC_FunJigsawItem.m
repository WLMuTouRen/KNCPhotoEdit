//
//  KNC_FunJigsawItem.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_FunJigsawItem.h"

@implementation KNC_FunJigsawItem


+ (instancetype)pri_mmp_funJigsawItemWithSizeRatio:(CGPoint)sizeRatio img:(UIImage * _Nullable)img {

    KNC_FunJigsawItem *item = [[KNC_FunJigsawItem alloc] init];
    
    item.sizeRatio = sizeRatio;
    item.imgiView = img;
    
    return item;
}


@end
