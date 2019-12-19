//
//  KNC_FunJigsawView.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_FunJigsawView.h"
#import "KNC_JigsawViewCell.h"
#import "KNC_FunJigsawItem.h"
#import "KNC_FunJigsawModel.h"

@interface KNC_FunJigsawView ()<UICollectionViewDelegate, UICollectionViewDataSource, KNC_WaterFlowLayoutDelegate>

@property (nonatomic, weak) KNC_BaseViewController *targetVC;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) KNC_FunJigsawModel *model;

@property (nonatomic, strong) KNC_WaterFlowLayout *flowLayout;

@property (nonatomic, assign) CGFloat boardWidth;

@end

@implementation KNC_FunJigsawView

- (instancetype)initWithTargetVC:(KNC_BaseViewController *)targetVC {
    if (self = [super init]) {
        self.targetVC = targetVC;
        
        [self p_initialize];
        
        [self p_setUpUI];
    }
    return self;
}

- (void)p_initialize {
    self.boardWidth = 5.0;
}

- (void)p_setUpUI {
    
    [self addSubview:self.collectionView];
    
    [self p_layout];
    
}

- (void)p_layout {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self);
        make.right.bottom.equalTo(self);
    }];
}

#pragma mark - public Method --

- (void)pri_mmp_updateWithModel:(KNC_FunJigsawModel *)model {

    self.model = model;
    
    [self.collectionView reloadData];
}

#pragma mark - UIcollectionView delegate --

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KNC_JigsawViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KNC_JigsawViewCell class]) forIndexPath:indexPath];
    
    KNC_FunJigsawItem *item = self.model.items[indexPath.item];
    
    if (item) {
        [cell pri_mmp_updateCellWithItem:item];
    }
    
    return cell;
}

#pragma mark - flowLayout delegate --

- (CGSize)waterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KNC_FunJigsawItem *item = self.model.items[indexPath.item];
    
    return item.itemSize;
}

-(CGSize )waterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section {
    return CGSizeZero;
}

-(CGSize )waterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section {
    return CGSizeZero;
}

/** 列数*/
-(CGFloat)columnCountInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout {
    return self.model.list;
}
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout {
    return self.model.row;
}

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout {
    return self.model.boardWidth;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout {
    return self.model.boardWidth;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(KNC_WaterFlowLayout *)waterFlowLayout {
    return UIEdgeInsetsMake(self.model.boardWidth, self.model.boardWidth, self.model.boardWidth, self.model.boardWidth);
}

#pragma mark - lazy load ---

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[KNC_JigsawViewCell class] forCellWithReuseIdentifier:NSStringFromClass([KNC_JigsawViewCell class])];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (KNC_WaterFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[KNC_WaterFlowLayout alloc] init];
        _flowLayout.flowLayoutStyle = KNC_WaterFlowCoustom;
        _flowLayout.delegate = self;
    }
    return _flowLayout;
}

@end
