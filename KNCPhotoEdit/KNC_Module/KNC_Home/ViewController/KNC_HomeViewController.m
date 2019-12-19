//
//  KNC_HomeViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_HomeViewController.h"
#import "KNC_HomeCardCollectionView.h"
#import "KNC_AddImageViewController.h"
#import "KNC_imagePickerController.h"
#import "KNC_MeituEditStyleViewController.h"
#import "KNC_HomeCardModel.h"
#import "KNC_GifSynthesisViewController.h"
//KNC_HomeCardCollectionViewDelegate,
@interface KNC_HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) KNC_HomeCardCollectionView *cardView;
@property (nonatomic, strong) UIImageView *bannerView;
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic , strong)UITableView *hh_tbv;

@end

@implementation KNC_HomeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.cardView.imageDataArray = [KNC_HomeCardModel ps_createHomeCardModel];

}

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
//    [self.view addSubview:self.cardView];
    [self hh_tbv];
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.left.equalTo(self.view);
//        make.height.mas_equalTo(280);
//    }];
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.left.equalTo(self.view.mas_left).mas_offset(0);
//           make.top.equalTo(self.view.mas_top).mas_offset(0);
//           make.right.equalTo(self.view.mas_right).mas_offset(0);
//           make.height.mas_equalTo(280);
//    }];

    // 添加Banner点击事件
    [self knc_func_BannerAction];
}

//懒加载表格
-(UITableView *)hh_tbv{
    if(!_hh_tbv){
        _hh_tbv = [[UITableView alloc]initWithFrame:CGRectMake(0, -KNC_Status_H, KNC_SCREEN_W, KNC_SCREEN_H+KNC_Status_H) style:UITableViewStylePlain];
        _hh_tbv.delegate = self;
        _hh_tbv.dataSource = self;
        _hh_tbv.showsVerticalScrollIndicator = NO;
        _hh_tbv.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_hh_tbv];
//        [self.hh_tbv mas_makeConstraints:^(MASConstraintMaker *make) {
//               make.left.equalTo(self.view.mas_left).mas_offset(0);
//               make.top.equalTo(self.view.mas_top).mas_offset(-KNC_NavMustAdd);
//               make.right.equalTo(self.view.mas_right).mas_offset(0);
//               make.height.mas_equalTo(KNC_SCREEN_H);
//        }];
        _hh_tbv.tableHeaderView = self.bannerView;
        
    }
    return _hh_tbv;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    if(indexPath.section == 0){
        UIButton *long_Btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, (KNC_SCREEN_W - 80) / 2 , 120)];
        [long_Btn setImage:[UIImage imageNamed:@"long_image"] forState:UIControlStateNormal];
        [long_Btn addTarget:self action:@selector(clickLongBtn) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:long_Btn];
        
        UIButton *web_Btn = [[UIButton alloc]initWithFrame:CGRectMake(60 + (KNC_SCREEN_W - 80) / 2 , 5, (KNC_SCREEN_W - 80) / 2 , 120)];
        [web_Btn setImage:[UIImage imageNamed:@"Web_image"] forState:UIControlStateNormal];
        [web_Btn addTarget:self action:@selector(clickWebBtn) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:web_Btn];
    }else{
        if(indexPath.row == 0){
            UIButton *fun_Btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, KNC_SCREEN_W - 40 , 120)];
            [fun_Btn setImage:[UIImage imageNamed:@"fun_image"] forState:UIControlStateNormal];
            [fun_Btn addTarget:self action:@selector(clickFunBtn) forControlEvents:UIControlEventTouchUpInside];

            [cell addSubview:fun_Btn];
        }else{
            UIButton *gif_Btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, KNC_SCREEN_W - 40 , 120)];
            [gif_Btn setImage:[UIImage imageNamed:@"gif_image"] forState:UIControlStateNormal];
            [gif_Btn addTarget:self action:@selector(clickGifBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:gif_Btn];
        }
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else{
        return 130;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KNC_SCREEN_W, 22)];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 15)];
    lab.font = [UIFont systemFontOfSize:16 weight:0.4];
    if (section == 0) {
        lab.text = @"热门功能";
    }else{
        lab.text = @"VIP推荐";
    }
    [headV addSubview:lab];
    return headV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

- (void)knc_func_BannerAction{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerViewTapAction)];
    [self.bannerView addGestureRecognizer:tap];
}

-(void)clickLongBtn{
    KNC_AddImageViewController *vc = [[KNC_AddImageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)clickWebBtn{
    KNC_WebShortController *webShortVC = [[KNC_WebShortController alloc]init];
    [self.navigationController pushViewController:webShortVC animated:YES];
}
-(void)clickFunBtn{
    KNC_MeituEditStyleViewController *funJigsawVC = [[KNC_MeituEditStyleViewController alloc] init];
    [self.navigationController pushViewController:funJigsawVC animated:YES];
}
-(void)clickGifBtn{
    KNC_GifSynthesisViewController *gifVC = [[KNC_GifSynthesisViewController alloc]init];
    [self.navigationController pushViewController:gifVC animated:YES];
}

//Banner点击事件
- (void)bannerViewTapAction{
    NSLog(@"Banner被点击！！！！");
    KNC_BuyViewController *buyVc = [[KNC_BuyViewController alloc]init];
    [self.navigationController pushViewController:buyVc animated:YES];
}
//
//#pragma mark --KNC_HomeCardCollectionViewDelegate--
//
//- (void)carCollecttionViewActionWithIndex:(NSInteger)index{
//
//    if (index == 0) {
//        KNC_AddImageViewController *vc = [[KNC_AddImageViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else if (index == 1){
//
//        KNC_MeituEditStyleViewController *funJigsawVC = [[KNC_MeituEditStyleViewController alloc] init];
//        [self.navigationController pushViewController:funJigsawVC animated:YES];
//
//    }else if (index == 2){
//        KNC_WebShortController *webShortVC = [[KNC_WebShortController alloc]init];
//        [self.navigationController pushViewController:webShortVC animated:YES];
//    }else if (index == 3){
//        KNC_GifSynthesisViewController *gifVC = [[KNC_GifSynthesisViewController alloc]init];
//        [self.navigationController pushViewController:gifVC animated:YES];
//    }
//
//}

- (UIImageView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KNC_SCREEN_W, 240)];
        _bannerView.image = [UIImage imageNamed:@"home_banner"];
        _bannerView.userInteractionEnabled = YES;
        
       
    }
    return _bannerView;
}

//
//- (KNC_HomeCardCollectionView *)cardView{
//    if (!_cardView) {
//        _cardView = [[KNC_HomeCardCollectionView alloc] initWithFrame:CGRectMake(0, 300+KNC_NavMustAdd, KNC_SCREEN_W, 310)];
//        
//        _cardView.delegate = self;
//    }
//    return _cardView;
//}


@end
