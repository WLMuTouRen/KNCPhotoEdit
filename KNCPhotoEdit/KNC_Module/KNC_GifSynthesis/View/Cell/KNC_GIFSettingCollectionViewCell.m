//
//  KNC_GIFSettingCollectionViewCell.m
//  PSLongFigure
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_GIFSettingCollectionViewCell.h"

@implementation KNC_GIFSettingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        gif_W = frame.size.width;
        gif_H = frame.size.height;
        [self addSubview:self.imageView];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, gif_W, gif_H)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

@end
