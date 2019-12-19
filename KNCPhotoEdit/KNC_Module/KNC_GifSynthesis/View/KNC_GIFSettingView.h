//
//  KNC_GIFSettingView.h
//  PictureStitch
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GIFSettingViewDelegate <NSObject>

-(void)choseSpeed:(float)speed;
-(void)pushAdjustmentController;

@end

@interface KNC_GIFSettingView : UIView

@property(nonatomic,strong)id<GIFSettingViewDelegate> delegate;

@property(nonatomic,copy)NSMutableArray *imageArr;

- (instancetype)initWithFrame:(CGRect)frame withSelectIamgeArray:(NSArray *)imageArr;



@end

NS_ASSUME_NONNULL_END
