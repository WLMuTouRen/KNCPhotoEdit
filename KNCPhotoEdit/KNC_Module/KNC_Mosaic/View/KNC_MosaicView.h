//
//  KNC_MosaicView.h
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNC_MosaicView;

@protocol MosaiViewDelegate<NSObject>

@optional
-(void)mosaiView:(KNC_MosaicView*)view TouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

-(void)mosaiView:(KNC_MosaicView*)view TouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)mosaiView:(KNC_MosaicView*)view TouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KNC_MosaicView : UIView

//底图为马赛克图
@property (nonatomic, strong) UIImage *mosaicImage;
//表图为正常图片
@property (nonatomic, strong) UIImage *originalImage;
//OperationCount
@property (nonatomic, assign, readonly) NSInteger operationCount;
//CurrentIndex
@property (nonatomic, assign, readonly) NSInteger currentIndex;
//Delegate
@property (nonatomic, weak) id<MosaiViewDelegate> deleagate;

//ResetMosai
-(void)resetMosaiImage;

//下一步
-(void)redo;

//上一步
-(void)undo;

-(BOOL)canUndo;

-(BOOL)canRedo;

-(UIImage*)resultImage;

@end

NS_ASSUME_NONNULL_END
