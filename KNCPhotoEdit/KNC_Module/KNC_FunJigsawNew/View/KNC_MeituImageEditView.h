//
//  KNC_MeituImageEditView.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNC_MeituImageEditView;
@protocol KNC_MeituImageEditViewDelegate <NSObject>

- (void)tapWithEditView:(KNC_MeituImageEditView *_Nullable)sender;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KNC_MeituImageEditView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView  *contentScrView;
@property (nonatomic, retain) UIBezierPath  *realCellArea;
@property (nonatomic, retain) UIImageView   *imageview;
@property (nonatomic, assign) id<KNC_MeituImageEditViewDelegate> tapDelegate;
@property (nonatomic, assign) CGRect        oldRect;
- (void)pri_mmp_setImageViewData:(UIImage *)imageData;
- (void)pri_mmp_setImageViewData:(UIImage *)imageData rect:(CGRect)rect;

- (void)setNotReloadFrame:(CGRect)frame;

@end




NS_ASSUME_NONNULL_END
