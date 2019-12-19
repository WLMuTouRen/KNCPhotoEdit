//
//  KNC_HomeCardModel.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_HomeCardModel.h"

@implementation KNC_HomeCardModel

+(NSMutableArray *)ps_createHomeCardModel{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    KNC_HomeCardModel *model1 = [[KNC_HomeCardModel alloc]init];
    model1.cardImageStr = @"home_card_11";
    model1.isShowVip = NO;
    [modelArray addObject:model1];
    KNC_HomeCardModel *model2 = [[KNC_HomeCardModel alloc]init];
    model2.cardImageStr = @"home_card_22";
    model2.isShowVip = NO;
    [modelArray addObject:model2];
    KNC_HomeCardModel *model3 = [[KNC_HomeCardModel alloc]init];
    model3.cardImageStr = @"home_card_33";
    model3.isShowVip = NO;
    [modelArray addObject:model3];
    KNC_HomeCardModel *model4 = [[KNC_HomeCardModel alloc]init];
    model4.cardImageStr = @"home_box_44";
    model4.isShowVip = !isVip;
    [modelArray addObject:model4];
    return modelArray;
    
}

@end
