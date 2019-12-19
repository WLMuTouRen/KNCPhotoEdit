//
//  KNC_HomeViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_HomeViewController.h"
#import "KNC_FunJigsawController.h"
#import "KNC_HomeCardCollectionView.h"
#import "KNC_AddImageViewController.h"
#import "KNC_imagePickerController.h"
#import "KNC_MeituEditStyleViewController.h"
#import "KNC_HomeCardModel.h"
#import "KNC_GifSynthesisViewController.h"

@interface KNC_HomeViewController ()<KNC_HomeCardCollectionViewDelegate>

@property (nonatomic, strong) KNC_HomeCardCollectionView *cardView;
@property (nonatomic, strong) UIImageView *bannerView;
@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation KNC_HomeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.cardView.imageDataArray = [KNC_HomeCardModel ps_createHomeCardModel];

}

//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//
//}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setUpUI];
}

- (void)p_setUpUI {

    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.cardView];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(280);
    }];

    // 添加Banner点击事件
    [self knc_func_BannerAction];
}


- (void)knc_func_BannerAction{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerViewTapAction)];
    [self.bannerView addGestureRecognizer:tap];
}
//Banner点击事件
- (void)bannerViewTapAction{
    NSLog(@"Banner被点击！！！！");
    KNC_BuyViewController *buyVc = [[KNC_BuyViewController alloc]init];
    [self.navigationController pushViewController:buyVc animated:YES];
}

#pragma mark --KNC_HomeCardCollectionViewDelegate--

- (void)carCollecttionViewActionWithIndex:(NSInteger)index{
    
    if (index == 0) {
        KNC_AddImageViewController *vc = [[KNC_AddImageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (index == 1){
        
        KNC_MeituEditStyleViewController *funJigsawVC = [[KNC_MeituEditStyleViewController alloc] init];
        [self.navigationController pushViewController:funJigsawVC animated:YES];
        
    }else if (index == 2){
        KNC_WebShortController *webShortVC = [[KNC_WebShortController alloc]init];
        [self.navigationController pushViewController:webShortVC animated:YES];
    }else if (index == 3){
        KNC_GifSynthesisViewController *gifVC = [[KNC_GifSynthesisViewController alloc]init];
        [self.navigationController pushViewController:gifVC animated:YES];
    }
    
}

- (UIImageView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[UIImageView alloc]init];
        _bannerView.image = [UIImage imageNamed:@"home_banner_iamge"];
        _bannerView.userInteractionEnabled = YES;
    }
    return _bannerView;
}

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"home_bg_image"];
    }
    return _bgView;
}

- (KNC_HomeCardCollectionView *)cardView{
    if (!_cardView) {
        _cardView = [[KNC_HomeCardCollectionView alloc] initWithFrame:CGRectMake(0, 300+KNC_NavMustAdd, KNC_SCREEN_W, 310)];
        
        _cardView.delegate = self;
    }
    return _cardView;
}

@end
