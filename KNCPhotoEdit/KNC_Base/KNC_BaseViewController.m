//
//  KNC_BaseViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/09.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_BaseViewController.h"
#import <objc/message.h>
@interface KNC_BaseViewController ()

/** 返回按钮 */
@property (strong, nonatomic) UIButton *___backBtn;

/**  返回事件执行者 */
@property (assign, nonatomic) id ___backTarget;

/**  返回事件 */
@property (assign, nonatomic) SEL ___backAction;

@end

@implementation KNC_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buySucessClick) name:@"paySuccess" object:nil];
    // Do any additional setup after loading the view.
}

-(void)buySucessClick{
    dispatch_async(dispatch_get_main_queue(), ^{
           [self.navigationController popViewControllerAnimated:YES];
    });
 
}
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.___backBtn];
    
    self.___backTarget = target;
    
    self.___backAction = action;
    
    return item;
}

#pragma mark - 私有方法 --

/**
 返回按钮事件

 @param backBtn 返回按钮
 */
- (void)p_backBtnAction:(UIButton *)backBtn {
    
    if (self.shouldBackBlock) {
        
        BOOL isCanBack = self.shouldBackBlock(backBtn);
        
        if (isCanBack && self.___backTarget && [self.___backTarget respondsToSelector:self.___backAction]) {
            // 可返回
            ((void(*)(id,SEL,UIButton *))objc_msgSend)(self.___backTarget,self.___backAction,self.___backBtn);
        }
        
    }else {
        // 可返回
        if (self.___backTarget && [self.___backTarget respondsToSelector:self.___backAction]) {
            ((void(*)(id,SEL,UIButton *))objc_msgSend)(self.___backTarget,self.___backAction,self.___backBtn);
        }
    }
}

#pragma mark - 懒加载 --

- (UIButton *)___backBtn {
    if (!____backBtn) {
        ____backBtn = [[UIButton alloc] init];
        [____backBtn setImage:[UIImage imageNamed:@"back_nor"] forState:UIControlStateNormal];
        [____backBtn addTarget:self action:@selector(p_backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return ____backBtn;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
