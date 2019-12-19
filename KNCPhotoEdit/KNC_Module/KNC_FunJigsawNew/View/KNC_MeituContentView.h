//
//  KNC_MeituContentView.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNC_MeituImageEditView.h"

@protocol  KNC_MeituContentViewDelegate;
@interface KNC_MeituContentView : UIView<KNC_MeituImageEditViewDelegate>
{
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    
}
@property (nonatomic, strong) KNC_MeituImageEditView *oneView;
@property (nonatomic, strong) KNC_MeituImageEditView *twoView;
@property (nonatomic, strong) KNC_MeituImageEditView *threeView;
@property (nonatomic, strong) KNC_MeituImageEditView *fourView;
@property (nonatomic, strong) KNC_MeituImageEditView *fiveView;

@property (nonatomic, strong) NSMutableArray           *assetsArr;
@property (nonatomic, strong) NSMutableArray    *contentViewArray;
@property (nonatomic, strong) NSString          *styleFileNameStr;
@property (nonatomic, assign) NSInteger         styleIndex;
@property (nonatomic, strong) NSDictionary      *styleDict;

@property (nonatomic, strong) UIImageView       *boardImageV;
@property (nonatomic, assign) id<KNC_MeituContentViewDelegate> delegateMove;

//交换时的中间变量
@property (nonatomic, strong) KNC_MeituImageEditView *tempView;

- (void)pri_mmp_setBackgroundColor:(UIColor *)backgroundColor posterImage:(UIImage *)posterImage;


+ (CGRect)pri_mmp_rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale;
+ (CGPoint)pri_mmp_pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale;
+ (CGSize)pri_mmp_sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale;

@end


@protocol  KNC_MeituContentViewDelegate <NSObject>

- (void)movedEditView;

@end

