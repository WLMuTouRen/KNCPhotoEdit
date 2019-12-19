//
//  KNC_FunJigsawView.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_BaseView.h"
@class KNC_FunJigsawModel;
NS_ASSUME_NONNULL_BEGIN

@interface KNC_FunJigsawView : KNC_BaseView

- (instancetype)initWithTargetVC:(KNC_BaseViewController *)TargetVC;

- (void)pri_mmp_updateWithModel:(KNC_FunJigsawModel *)model;
@end

NS_ASSUME_NONNULL_END
