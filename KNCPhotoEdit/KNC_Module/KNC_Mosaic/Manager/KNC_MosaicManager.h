//
//  KNC_MosaicManager.h
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNC_MosaicManager : NSObject

-(instancetype)initWithOriImage:(UIImage*)originalImage;

//重做
-(UIImage*)redo;

//撤销
-(UIImage*)undo;

//当前操作数index
@property(nonatomic,assign)NSInteger currentIndex;
//操作数
@property(nonatomic,assign)NSInteger operationCount;

-(void)writeImageToCache:(UIImage*)image;

-(void)releaseAllImage;

@end

NS_ASSUME_NONNULL_END
