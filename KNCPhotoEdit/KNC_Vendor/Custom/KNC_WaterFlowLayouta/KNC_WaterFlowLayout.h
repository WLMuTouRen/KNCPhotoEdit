//
//  KNC_WaterFlowLayout.h
//  KNCPhotoEdit
//
//  Created by 翔 on 2019/12/19.
//  Copyright © 2019 com.BaseProject.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    KNC_WaterFlowVerticalEqualWidth = 0, /** 竖向瀑布流 item等宽不等高 */
    KNC_WaterFlowHorizontalEqualHeight = 1, /** 水平瀑布流 item等高不等宽 不支持头脚视图*/
    KNC_WaterFlowVerticalEqualHeight = 2,  /** 竖向瀑布流 item等高不等宽 */
    KNC_WaterFlowHorizontalGrid = 3,  /** 特为国务院客户端原创栏目滑块样式定制-水平栅格布局  仅供学习交流*/
    KNC_LineWaterFlow = 4, /** 线性布局 待完成，敬请期待 */
    KNC_WaterFlowCoustom = 5 /** 自定义宽高 */
} KNC_WaterFlowLayoutStyle; //样式

@class KNC_WaterFlowLayout;

@protocol KNC_WaterFlowLayoutDelegate <NSObject>

/**
 返回item的大小
 注意：根据当前的瀑布流样式需知的事项：
 当样式为WSLWaterFlowVerticalEqualWidth 传入的size.width无效 ，所以可以是任意值，因为内部会根据样式自己计算布局
 WSLWaterFlowHorizontalEqualHeight 传入的size.height无效 ，所以可以是任意值 ，因为内部会根据样式自己计算布局
 WSLWaterFlowHorizontalGrid   传入的size宽高都有效， 此时返回列数、行数的代理方法无效，
 WSLWaterFlowVerticalEqualHeight 传入的size宽高都有效， 此时返回列数、行数的代理方法无效
 */
- (CGSize)waterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** 头视图Size */
-(CGSize )waterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section;
/** 脚视图Size */
-(CGSize )waterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section;

@optional //以下都有默认值
/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout;
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout;

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout;
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout;

@end

@interface KNC_WaterFlowLayout : UICollectionViewLayout

/** delegate*/
@property (nonatomic, weak) id<KNC_WaterFlowLayoutDelegate> delegate;
/** 瀑布流样式*/
@property (nonatomic, assign) KNC_WaterFlowLayoutStyle  flowLayoutStyle;

@end
NS_ASSUME_NONNULL_END
