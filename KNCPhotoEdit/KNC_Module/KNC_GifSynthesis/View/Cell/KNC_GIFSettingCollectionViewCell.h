//
//  KNC_GIFSettingCollectionViewCell.h
//  PSLongFigure
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNC_GIFSettingCollectionViewCell : UICollectionViewCell{
    CGFloat gif_W,gif_H;
}
@property(nonatomic,strong)UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
