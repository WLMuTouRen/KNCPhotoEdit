//
//  KNC_JigsawViewCell.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNC_FunJigsawItem;
NS_ASSUME_NONNULL_BEGIN

@interface KNC_JigsawViewCell : UICollectionViewCell
- (void)pri_mmp_updateCellWithItem:(KNC_FunJigsawItem *)item;
@end

NS_ASSUME_NONNULL_END
