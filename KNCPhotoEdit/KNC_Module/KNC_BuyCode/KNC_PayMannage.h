//
//  KNC_PayMannage.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019年 lg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


@interface KNC_PayMannage : NSObject

+(KNC_PayMannage*)sharePayHelp;

/**
*开始购买
 * productId 产品ID   
*/
-(void)applePayWithProductId:(NSString*)productId;
/**
 *恢复交易
 */
-(void)restorePurchase;
/*
 * 验证是否购买
 */
- (void)verifyPruchaseWithID:(NSString *)ProductID;

@end
