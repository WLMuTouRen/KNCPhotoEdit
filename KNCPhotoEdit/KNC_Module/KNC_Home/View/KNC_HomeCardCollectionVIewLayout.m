//
//  KNC_HomeCardCollectionVIewLayout.h
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_HomeCardCollectionVIewLayout.h"

//设置item的大小
#define  ITEMW 212
#define  ITENH  310


@implementation KNC_HomeCardCollectionVIewLayout

-(instancetype)init{

    if (self = [super init]) {
        
        
        //设置item的大小
        self.itemSize = CGSizeMake(ITEMW, ITENH);
        self.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, KNC_SCREEN_W /2 - ITEMW/2, 0, KNC_SCREEN_W /2 - ITEMW/2);
        self.minimumLineSpacing = 25;
    }
    return self;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arr = [self copyAttributes: [super layoutAttributesForElementsInRect:rect]];
    //屏幕中间线
    CGFloat centerX = self.collectionView.contentOffset.x  + self.collectionView.bounds.size.width /2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        CGFloat distance = fabs(attribute.center.x - centerX);
    //移动的距离和屏幕宽的比例
        CGFloat screenScale = distance /self.collectionView.bounds.size.width;
    //卡片移动到固定范围内 -π/4 到 π/4
        CGFloat scale = fabs(cos(screenScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线  越居中越接近于1
        attribute.transform = CGAffineTransformMakeScale(1.0, scale);
        //透明度
        attribute.alpha = scale;
    }
    

    return arr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(NSArray *)copyAttributes:(NSArray  *)arr{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in arr) {
        [copyArr addObject:[attribute copy]];
    }
    
    
    return copyArr;
}
@end
