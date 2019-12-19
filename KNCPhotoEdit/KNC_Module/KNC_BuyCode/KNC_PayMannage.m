//
//  KNC_PayMannage.m
//  PSLongFigure
//
//  Created by mdyuwen on 2019/12/10.
//  Copyright © 2019年 lg. All rights reserved.
//

#import "KNC_PayMannage.h"
@interface KNC_PayMannage ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic ,assign )BOOL  isRestore;

@end

@implementation KNC_PayMannage
+(KNC_PayMannage*)sharePayHelp{
    static KNC_PayMannage * help=nil;
    if(help==nil){
        help=[[KNC_PayMannage alloc]init];
    }
    return help;
}
-(id)init{
    self = [super init];
    if(self){
        // 4.设置支付服务-APP内购
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        self.isRestore = NO;
    }
    return self;
}

#pragma mark 购买内购
-(void)applePayWithProductId:(NSString*)productId{
       [SVProgressHUD show];
    self.isRestore = NO;
    //判断app是否允许apple支付
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"yes");// 6.请求苹果后台商品
        //注释的是
        [SVProgressHUD show];
        [KNC_HelpManager disableRightSlipBack];//关闭右滑动返回手势
        [self getRequestAppleProductWithProductId:productId];
    }
    else {
        NSLog(@"not");
        
        /** 手机不支持支付 在这里做提示*/
//        [Help hideHUDWithTitle:SKPLocalizedString(@"Your phone is not open for in-app purchases")];
        //开启右滑动返回手势
    }
}

//请求苹果商品
- (void)getRequestAppleProductWithProductId:(NSString *)productId{
    // 7.这里的com.czchat.CZChat01就对应着苹果后台的商品ID,他们是通过这个ID进行联系的。
    NSArray *product = [[NSArray alloc] initWithObjects:productId,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    // 8.初始化请求
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    // 9.开始请求
    [request start];
    
}
// 10.接收到产品的返回信息,然后用返回的商品信息进行发起购买请求
- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *product = response.products;
    //如果服务器没有产品
    if([product count] == 0){
        NSLog(@"nothing");
        //获取商品信息失败
        [SVProgressHUD showErrorWithStatus:@"获取商品失败"];
        //开启右滑动返回手势
        return;
    }
    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        // 11.如果后台消费条目的ID与我这里需要请求的一样（用于确保订单的正确性）
        requestProduct = pro;
    }
    // 12.发送购买请求
    SKPayment *payment = [SKPayment paymentWithProduct:requestProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error:%@", error);
    [SVProgressHUD dismiss];
    //开启右滑动返回手势
}
//反馈请求的产品信息结束后
- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"信息反馈结束");
     [SVProgressHUD dismiss];
//    [SVProgressHUD dismiss];
}

#pragma mark 恢复内购
-(void)restorePurchase{
//    [Help showHUDWithTitle:SKPLocalizedString(@"Restoring...")];
    [SVProgressHUD show];
    self.isRestore = YES;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];//回调已经购买过的项目
  

}
//获取已经购买过的内购项目
- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    NSLog(@"received restored transactions: %ld", queue.transactions.count);
    
    if (queue.transactions.count==0) {
        //提示用户恢复失败
        [SVProgressHUD showErrorWithStatus:@"恢复购买项目失败"];
    }
    for (SKPaymentTransaction *transaction in queue.transactions){
        NSString *productID = transaction.payment.productIdentifier;
        NSLog(@"%@",productID);
        NSLog(@"%ld",(long)transaction.transactionState);
        if (transaction.transactionState==SKPaymentTransactionStateRestored) {
            
        }
    }
}
//恢复内购失败调用-比如用户没有登录apple id 手动取消恢复
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    [KNC_HelpManager setObject:@"NO" forKey:@"ISBuyVip"];
//    [SVProgressHUD showErrorWithStatus:VE_LocalizedString(@"RestoreFailed")];
}
#pragma mark 购买和恢复都会回调
// 13.监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
  
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
//                    [SVProgressHUD dismiss];
                break;
            case SKPaymentTransactionStatePurchased:
                    
                //购买成功-第一次购买和恢复已购项目都会回调这个
//                [SVProgressHUD showSuccessWithStatus:VE_LocalizedString(@"Buy_sucess")];
                [self addUseCount];//-为用户添加权益
                  
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateRestored:
                //购买已经购买过的商品的商品会回调这个
              
                    [self addUseCount];
                
              //用户已经购买过-为用户恢复权益
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateFailed:
                    [SVProgressHUD dismiss];
//                [SVProgressHUD showErrorWithStatus:VE_LocalizedString(@"BuyFailed")];
//                [SVProgressHUD showErrorWithStatus:VE_LocalizedString(@"BUY_Failed")];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            default:
                [SVProgressHUD dismiss];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
        }
    }
}


//购买成功之后 给用户权限
-(void)addUseCount{
    
    [SVProgressHUD dismiss];
//     [SVProgressHUD showSuccessWithStatus:VE_LocalizedString(@"Buy_sucess")];
    [KNC_HelpManager setObject:@"YES" forKey:@"ISBuyVip"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:nil];
}

//结束后一定要销毁
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}


/**
 *  验证购买凭据
 *
 *  @param ProductID 商品ID
 */
- (void)verifyPruchaseWithID:(NSString *)ProductID
{
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    // 发送网络POST请求，对购买凭据进行验证
    //In the test environment, use https://sandbox.itunes.apple.com/verifyReceipt
    //In the real environment, use https://buy.itunes.apple.com/verifyReceipt
    // Create a POST request with the receipt data.
    NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];

    // 国内访问苹果服务器比较慢，timeoutInterval需要长一点
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];

    request.HTTPMethod = @"POST";

    // 在网络中传输数据，大多情况下是传输的字符串而不是二进制数据
    // 传输的是BASE64编码的字符串
    /**
     BASE64 常用的编码方案，通常用于数据传输，以及加密算法的基础算法，传输过程中能够保证数据传输的稳定性
     BASE64是可以编码和解码的
     */
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\", \"exclude-old-transactions\" : \"true\", \"password\" : \"1f0aae19eb7f344a818216af37d3c3f456\"}", encodeStr];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];

    request.HTTPBody = payloadData;

    // 提交验证请求，并获得官方的验证JSON结果
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    // 官方验证结果为空
    if (result == nil) {
        //NSLog(@"验证失败");
        //验证失败,通知代理
       
        return;
    }

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result
                                                         options:NSJSONReadingAllowFragments error:nil];

    //NSLog(@"RecivedVerifyPruchaseDict：%@", dict);

    if (dict != nil) {
        // 验证成功,通知代理
        // bundle_id&application_version&product_id&transaction_id
        
    }else{
        //验证失败,通知代理
       
    }
}


@end
