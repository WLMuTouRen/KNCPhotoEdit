//
//  KNC_HomeCardModel.h
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNC_HomeCardModel : NSObject
@property (nonatomic, copy) NSString *cardImageStr;
@property (nonatomic, assign) BOOL isShowVip;

+(NSMutableArray *)ps_createHomeCardModel;

@end

NS_ASSUME_NONNULL_END
