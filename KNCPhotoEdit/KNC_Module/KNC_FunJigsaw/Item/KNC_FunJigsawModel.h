//
//  QC_PS_FunJigsawModel.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

// 拼图布局管理类

#import <Foundation/Foundation.h>
@class KNC_FunJigsawItem;
NS_ASSUME_NONNULL_BEGIN

@interface KNC_FunJigsawModel : NSObject

@property (nonatomic, assign) CGFloat boardWidth;

@property (nonatomic, assign) CGSize funJigsawViewSize;

@property (nonatomic, assign) CGFloat row;       // 行

@property (nonatomic, assign) CGFloat list;      // 列

@property (nonatomic, strong) NSArray <KNC_FunJigsawItem *>*items;

+ (instancetype)funJigsawModelWithItems:(NSArray <KNC_FunJigsawItem *>*)items;

@end

NS_ASSUME_NONNULL_END
