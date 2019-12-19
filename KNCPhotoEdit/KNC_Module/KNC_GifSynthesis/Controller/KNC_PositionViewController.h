//
//  KNC_PositionViewController.h
//  PSLongFigure
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNC_PositionViewController : KNC_BaseViewController

-(void)setOriginalOrderImageArray:(NSMutableArray *)imgArr;

//点击按钮block回调
@property (nonatomic,copy) void(^newImageArray)(NSMutableArray *imageArr);

@end

NS_ASSUME_NONNULL_END
