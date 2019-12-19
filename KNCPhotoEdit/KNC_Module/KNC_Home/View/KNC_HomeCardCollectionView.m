//
//  KNC_HomeCardCollectionView.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_HomeCardCollectionView.h"
#import "KNC_HomeCardCollectionViewCell.h"
#import "KNC_HomeCardCollectionVIewLayout.h"
#import "KNC_HomeCardModel.h"

@interface KNC_HomeCardCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat  startX;
@property (nonatomic, assign) CGFloat  endX;
@property (nonatomic, assign) NSInteger  currentIndex;

@end

static NSString * const CardCollectionViewCellID = @"CardCollectionViewCel";

@implementation KNC_HomeCardCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self knc_func_AddUI];
        
    }
    return self;
}

- (void)setImageDataArray:(NSMutableArray *)imageDataArray{
    _imageDataArray = imageDataArray;
    [self.collectionView reloadData];
}

- (void)knc_func_AddUI {
    KNC_HomeCardCollectionVIewLayout *layout = [[KNC_HomeCardCollectionVIewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.clearColor;
    [self.collectionView registerClass:[KNC_HomeCardCollectionViewCell class] forCellWithReuseIdentifier:CardCollectionViewCellID];
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:self.collectionView];

    
}

#pragma mark CollectionViewDelegate&DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KNC_HomeCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CardCollectionViewCellID forIndexPath:indexPath];
    cell.cardModel = self.imageDataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(carCollecttionViewActionWithIndex:)]) {
        [self.delegate carCollecttionViewActionWithIndex:indexPath.row];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.startX = scrollView.contentOffset.x;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.endX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self knc_func_cellToCenter];
    });
}
- (void)knc_func_cellToCenter{
    //最小滚动距离
    float  dragMinDistance = self.collectionView.bounds.size.width/20.0f;
    if (self.startX - self.endX >= dragMinDistance) {
        self.currentIndex -= 1; //向右
    }else if (self.endX - self.startX >= dragMinDistance){
        self.currentIndex += 1 ;//向左
    }
    NSInteger maxIndex  = [self.collectionView numberOfItemsInSection:0] - 1;
    self.currentIndex = self.currentIndex <= 0 ? 0 :self.currentIndex;
    self.currentIndex = self.currentIndex >= maxIndex ? maxIndex : self.currentIndex;
    
//    KNC_HomeCardModel *currentModel = self.imageDataArray[self.currentIndex];
    
//    for (KNC_HomeCardModel *tempModel in self.imageDataArray) {
//        if (currentModel == tempModel) {
//            tempModel.isAddMark = NO;
//        }else{
//            tempModel.isAddMark = YES;
//        }
//    }
//
//    [self.collectionView reloadData];

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

@end
