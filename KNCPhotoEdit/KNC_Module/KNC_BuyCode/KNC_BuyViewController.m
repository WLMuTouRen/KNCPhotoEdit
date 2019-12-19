//
//  QC_PS_BuyViewController.m
//  PictureStitch
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#import "KNC_BuyViewController.h"
#import "TTTAttributedLabel.h"

 
@interface KNC_BuyViewController ()<TTTAttributedLabelDelegate>
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UILabel *titleLB;
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@property (nonatomic,strong) UIButton *yearBtn;
@property (nonatomic,strong) TTTAttributedLabel *rebackLB;
@property (nonatomic,strong) UIButton *restoreBtn;
@property (nonatomic,strong) UILabel *buyTipsLB;

@property (nonatomic,strong) UIImageView *topImagV;

@property (nonatomic,strong) UIButton *protolBtn;//隐私协议
@property (nonatomic,strong) UIButton *termUesBtn;//使用政策

@end

@implementation KNC_BuyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self qc_pri_configUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


-(void)qc_pri_configUI{
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.layer.masksToBounds = YES;
    backImage.image = [UIImage imageNamed:@"buyBack"];
    [self.view insertSubview:backImage atIndex:0];
    
    [self.view addSubview:self.topImagV];
    
    [self.view addSubview:self.closeBtn];
       [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.view).offset(Status_H + 5);
           make.left.equalTo(self.view).offset(10);
           make.width.mas_equalTo(20);
           make.height.mas_equalTo(20);
       }];
    
//    [self.view addSubview:self.titleLB];
//    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(Status_H + 10);
//        make.left.equalTo(self.view).offset(SCREEN_Width/4);
//        make.width.mas_equalTo(SCREEN_Width/2);
//        make.height.mas_equalTo(20);
//    }];
    
    [self.view addSubview:self.mainScrollView];
   
    [self.mainScrollView addSubview:self.buyTipsLB];//50, 20, SCREEN_Width -100, 60
    [self.buyTipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainScrollView).offset(20);
        make.left.equalTo(self.mainScrollView).offset(20);
        make.width.mas_equalTo(SCREEN_Width -30);
        make.height.mas_equalTo(60);
    }];
    
     [self.mainScrollView addSubview:self.buyBtn];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.buyTipsLB.mas_bottom).offset(20);
           make.left.equalTo(self.mainScrollView).offset(20);
           make.width.mas_equalTo(SCREEN_Width/2 - 40);
           make.height.mas_equalTo(120);
       }];
    [self.mainScrollView addSubview:self.yearBtn];
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.buyTipsLB.mas_bottom).offset(20);
           make.left.mas_equalTo(SCREEN_Width/2 + 20);
           make.width.mas_equalTo(SCREEN_Width/2 - 40);
           make.height.mas_equalTo(120);
       }];
    [self.mainScrollView addSubview:self.restoreBtn];
    [self.restoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.yearBtn.mas_bottom).offset(20);
           make.left.equalTo(self.mainScrollView).offset(20);
           make.width.mas_equalTo(SCREEN_Width - 40);
           make.height.mas_equalTo(40);
       }];
    
    [self.mainScrollView addSubview:self.rebackLB];
    [self.rebackLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.restoreBtn.mas_bottom).offset(0);
        make.left.equalTo(self.mainScrollView).offset(20);
        make.width.mas_equalTo(SCREEN_Width - 40);
    }];
    [self.mainScrollView addSubview:self.protolBtn];
    [self.protolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.rebackLB.mas_bottom).offset(20);
           make.left.equalTo(self.mainScrollView).offset(SCREEN_Width/4 - 20);
           make.width.mas_equalTo(SCREEN_Width/4);
           make.height.mas_equalTo(30);
       }];
    [self.mainScrollView addSubview:self.termUesBtn];
    [self.termUesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.rebackLB.mas_bottom).offset(20);
           make.left.equalTo(self.protolBtn.mas_right).offset(20);
           make.width.mas_equalTo(SCREEN_Width/3);
           make.height.mas_equalTo(30);
       }];
    
    self.mainScrollView.contentSize = CGSizeMake(0, SCREEN_Height*0.9);
}


#pragma mark ==========按钮点击事件===============
-(void)closeBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)mouthBuyBtnClick{
    [[KNC_PayMannage sharePayHelp] applePayWithProductId:INVIPMONTH];
}
-(void)yearBuyBtnClick{
    [[KNC_PayMannage sharePayHelp] applePayWithProductId:INVIPYEAR];
}

-(void)restoreBtnClick{
    [[KNC_PayMannage sharePayHelp] restorePurchase];
}

-(void)protolBtnClick{
    [self qc_pri_pushVcWithWebUrl:PROTOCOLURL titleString:@"隐私政策"];
}
-(void)termUesBtnClick{
    [self qc_pri_pushVcWithWebUrl:AUTOFUFEI titleString:@"自动续费协议"];
}

-(void)qc_pri_pushVcWithWebUrl:(NSString *)urlString titleString:(NSString *)titleString{
    KNC_WebViewController *webVc = [[KNC_WebViewController alloc]init];
    webVc.titleStr =titleString;
    webVc.url_Str = urlString;
    webVc.ishiddenBottom = YES;
    [self.navigationController pushViewController:webVc animated:YES];
}
#pragma mark =============lan jiazai===============

-(UIImageView*)topImagV{
    if (!_topImagV) {
        _topImagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Width*0.5)];
        _topImagV.image = [UIImage imageNamed:@"bg1"];
        
        UILabel *labe = [[UILabel alloc]init];
        labe.text = @" 解锁所有功能";
        labe.frame = CGRectMake(0, SCREEN_Width*0.5 - 40, SCREEN_Width, 30);
        labe.textColor = UIColor.whiteColor;
        labe.font = [UIFont boldSystemFontOfSize:22];
        labe.textAlignment = NSTextAlignmentLeft;
        [_topImagV addSubview:labe];
    }
    return _topImagV;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.backgroundColor = UIColor.clearColor;
        [_mainScrollView setScrollEnabled:YES];
        _mainScrollView.frame = CGRectMake(0, CGRectGetMaxY(_topImagV.frame), SCREEN_Width, SCREEN_Height-CGRectGetMaxY(_topImagV.frame));
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}

-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setBackgroundImage:GetImage(@"mouthBuy") forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(mouthBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

-(UIButton *)yearBtn{
    if (!_yearBtn) {
        _yearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yearBtn setBackgroundImage:GetImage(@"yearBuy") forState:UIControlStateNormal];
        [_yearBtn addTarget:self action:@selector(yearBuyBtnClick)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _yearBtn;
}

-(UIButton *)protolBtn{
    if (!_protolBtn) {
        _protolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protolBtn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        _protolBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_protolBtn setTitle:@"隐私协议" forState:UIControlStateNormal];
        [_protolBtn addTarget:self action:@selector(protolBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _protolBtn.layer.cornerRadius = 5;
        _protolBtn.layer.masksToBounds = YES;
        [_protolBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    }
    return _protolBtn;
}


-(UIButton *)termUesBtn{
    if (!_termUesBtn) {
        _termUesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_termUesBtn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        _termUesBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_termUesBtn setTitle:@"自动续费协议" forState:UIControlStateNormal];
        [_termUesBtn addTarget:self action:@selector(termUesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _termUesBtn.layer.cornerRadius = 5;
        _termUesBtn.layer.masksToBounds = YES;
        [_termUesBtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    }
    return _termUesBtn;
}
-(UIButton *)restoreBtn{
    if (!_restoreBtn) {
        _restoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_restoreBtn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        _restoreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_restoreBtn setTitle:@"恢复购买项目" forState:UIControlStateNormal];
        [_restoreBtn addTarget:self action:@selector(restoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _restoreBtn.layer.cornerRadius = 5;
        _restoreBtn.layer.masksToBounds = YES;
        
    }
    return _restoreBtn;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_closeBtn setImage:[UIImage imageNamed:@"back_nor"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

//-(UILabel *)titleLB{
//    if (!_titleLB) {
//        _titleLB = [[UILabel alloc]init];
//        _titleLB.text = @"购买高级服务";
//        _titleLB.frame = CGRectMake(0, 20, SCREEN_Width, 20);
//        _titleLB.textColor = UIColor.blackColor;
//        _titleLB.font = [UIFont systemFontOfSize:17];
//        _titleLB.textAlignment = NSTextAlignmentCenter;
//    }
//    return _titleLB;
//}
-(UILabel *)buyTipsLB{
    if (!_buyTipsLB) {
        _buyTipsLB = [[UILabel alloc]init];
        _buyTipsLB.text = @"1、解锁GIF动图，趣味拼图功能\n2、去除水印，畅享体验全部功能";
        _buyTipsLB.numberOfLines = 0;
        _buyTipsLB.textColor = RGBColor(255, 255, 255);
        _buyTipsLB.font = [UIFont systemFontOfSize:16];
    }
    return _buyTipsLB;
}


-(TTTAttributedLabel *)rebackLB{
    if (!_rebackLB) {
        _rebackLB = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
        _rebackLB.textColor = RGBColor(3, 3, 3);
        _rebackLB.numberOfLines = 0;
        _rebackLB.font = [UIFont systemFontOfSize:12];
        _rebackLB.textAlignment = NSTextAlignmentLeft;
        
        _rebackLB.enabledTextCheckingTypes = NSTextCheckingTypeLink;
        _rebackLB.delegate = self;
        
        _rebackLB.text = @"1.服务名称：长图拼接会员连续包月（1个月）、长图拼接会员连续包年（12个月）\n\n2.价格：连续包月产品为30/月，连续包年产品为238/年\n\n3.购买自动订阅会员的账号，会在每个月订阅到期前24小时，从您的iTunes账号中扣款，扣款成功后顺延一个订阅周期。\n\n4.如需取消订阅，请手动打开苹果手机“设置”-->进入“iTunes Store 与 app Store” -->点击“Apple ID”，选择“查看Apple ID”，进入“账户设置”页面，点击“订阅”，选择长图拼接会员服务取消订阅即可，如未在结束的至少24小时前关闭订阅的，将视为您同意继续授权，此订阅将会自动续订。订阅可以由用户管理，购买后转到用户的帐户设置可以关闭自动续订您可以通过以下网址取消订阅：https://support.apple.com/en-us/HT202039";
        
        NSRange range = [_rebackLB.text rangeOfString:@"https://support.apple.com/en-us/HT202039"];
        [_rebackLB addLinkToURL:[NSURL URLWithString:@"https://support.apple.com/en-us/HT202039"] withRange:range];
        
    }
    return _rebackLB;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
     
    }];
}

@end
