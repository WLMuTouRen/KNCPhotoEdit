//
//  KNC_MosaicPath.h
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PathPoint:NSObject

@property(nonatomic)float xPoint;

@property(nonatomic)float yPoint;

@end

@interface KNC_MosaicPath : NSObject

@property(nonatomic)CGPoint startPoint;
@property(nonatomic)NSMutableArray *pathPointArray;
@property(nonatomic)CGPoint endPoint;

-(void)resetStatus;

@end

NS_ASSUME_NONNULL_END
