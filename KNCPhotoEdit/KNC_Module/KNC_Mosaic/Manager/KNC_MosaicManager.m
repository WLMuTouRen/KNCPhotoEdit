//
//  KNC_MosaicManager.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_MosaicManager.h"

@interface KNC_MosaicManager()

@property(nonatomic,strong)NSMutableArray *cacheArray;
@property(nonatomic,strong)UIImage *originalImage;
@end

@implementation KNC_MosaicManager

-(instancetype)initWithOriImage:(UIImage *)originalImage{
    if (!originalImage) return nil;
    if (self = [super init]) {
        _currentIndex = 0;
        _cacheArray = [[NSMutableArray alloc]init];
        [_cacheArray addObject:originalImage];
        _originalImage = originalImage;
    }
    return self;
}


-(UIImage *)redo{
    if (_currentIndex + 1 < _cacheArray.count) {
        _currentIndex++;
        return _cacheArray[_currentIndex];
    }
    return nil;
}

-(UIImage*)undo{
    if (_currentIndex - 1 >= 0) {
        _currentIndex--;
        return _cacheArray[_currentIndex];
    }

    return nil;
}


-(void)writeImageToCache:(UIImage *)image{
    if (!image) return;
    if (_currentIndex < _cacheArray.count -1) {
        [_cacheArray removeObjectsInRange:NSMakeRange(_currentIndex+1 , _cacheArray.count - 1 - _currentIndex)];
    }
    [_cacheArray addObject:image];
    _currentIndex++;
    _operationCount = _currentIndex;
}

-(void)releaseAllImage{
    [self.cacheArray removeAllObjects];
    _currentIndex = 0;
}

@end
