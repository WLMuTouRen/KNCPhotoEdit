//
//  KNC_FunJigsawModel.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_FunJigsawModel.h"
#import "KNC_FunJigsawItem.h"

@implementation KNC_FunJigsawModel

+ (instancetype)funJigsawModelWithItems:(NSArray <KNC_FunJigsawItem *>*)items {
    KNC_FunJigsawModel *model = [[KNC_FunJigsawModel alloc] init];
    
    model.items = items;
    
    return model;
}

#pragma mark - setter --

- (void)setItems:(NSArray<KNC_FunJigsawItem *> *)items {
    _items = items;
    
    if (_items && _items.count > 0) {
        [self knc_func_updateItemSize];
    }
}

- (void)setRow:(CGFloat)row {
    
    if (_row != row) {
        _row = row;
        
        if (_row >= 1.0) {
            [self knc_func_updateItemSize];
        }
    }
}

- (void)setList:(CGFloat)list {
    if (_list != list) {
        _list = list;
        
        if (_list >= 1.0) {
            [self knc_func_updateItemSize];
        }
    }
}

- (void)setBoardWidth:(CGFloat)boardWidth {
    if (_boardWidth != boardWidth) {
        _boardWidth = boardWidth;
        
        if (_boardWidth >= 0) {
            [self knc_func_updateItemSize];
        }
    }
}

- (void)setFunJigsawViewSize:(CGSize)funJigsawViewSize {
    
    if (!CGSizeEqualToSize(_funJigsawViewSize, funJigsawViewSize)) {
        _funJigsawViewSize = funJigsawViewSize;
        
        if (!CGSizeEqualToSize(CGSizeZero, _funJigsawViewSize)) {
            [self knc_func_updateItemSize];
        }
    }
    
}

- (void)knc_func_updateItemSize {
    
    if (self.items != nil && self.items.count > 0 && self.boardWidth >= 0 && !CGSizeEqualToSize(self.funJigsawViewSize, CGSizeZero)) {
     
        CGFloat widthUnit = (self.funJigsawViewSize.width - (self.boardWidth * (self.list + 1))) / self.list;
        CGFloat heightUnit = (self.funJigsawViewSize.height - (self.boardWidth * (self.row + 1))) / self.row;
        
        for (int index = 0; index < self.items.count ; index ++) {
            
            KNC_FunJigsawItem *tmpItem = self.items[index];
            
            tmpItem.itemSize = CGSizeMake(tmpItem.sizeRatio.x * widthUnit + (self.boardWidth * (tmpItem.sizeRatio.x - 1.0)), tmpItem.sizeRatio.y * heightUnit + (self.boardWidth * (tmpItem.sizeRatio.y - 1.0)));
        }
    }
}


@end
