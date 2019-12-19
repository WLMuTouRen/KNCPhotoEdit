//
//  KNC_MosaicPath.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_MosaicPath.h"


@implementation PathPoint

- (instancetype)init{
    self = [super init];
    if (self) {
        _xPoint = _yPoint = 0;
    }
    return self;
}
@end

@interface KNC_MosaicPath()<NSCopying,NSMutableCopying>

@end

@implementation KNC_MosaicPath

- (instancetype)init{
    self = [super init];
    if (self) {
        _startPoint = CGPointZero;
        _endPoint = CGPointZero;
        _pathPointArray = [[NSMutableArray alloc]init];
    }
    return self;
}


-(void)resetStatus{
    _startPoint = CGPointZero;
    _endPoint = CGPointZero;
    [_pathPointArray removeAllObjects];
}

- (id)copyWithZone:(NSZone *)zone{
    
    KNC_MosaicPath *obj = [[[self class] allocWithZone:zone] init];
    obj.pathPointArray = [self.pathPointArray copyWithZone:zone];
    obj.startPoint = self.startPoint;
    obj.endPoint = self.endPoint;
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    
    KNC_MosaicPath *obj = [[[self class] allocWithZone:zone] init];
    obj.pathPointArray = [self.pathPointArray copyWithZone:zone];
    obj.startPoint = self.startPoint;
    obj.endPoint = self.endPoint;
    return obj;
}

@end



