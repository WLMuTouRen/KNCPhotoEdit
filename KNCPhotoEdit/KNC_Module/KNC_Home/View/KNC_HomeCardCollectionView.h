//
//  KNC_HomeCardCollectionView.h
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_BaseView.h"

@protocol KNC_HomeCardCollectionViewDelegate <NSObject>
- (void)carCollecttionViewActionWithIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_BEGIN

@interface KNC_HomeCardCollectionView : KNC_BaseView

@property (nonatomic, strong) NSMutableArray *imageDataArray;
@property (nonatomic, weak) id<KNC_HomeCardCollectionViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
