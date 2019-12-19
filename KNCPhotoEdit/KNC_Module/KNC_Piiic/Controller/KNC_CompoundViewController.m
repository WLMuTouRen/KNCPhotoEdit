//
//  KNC_CompoundViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_CompoundViewController.h"
#import "KNC_CompoundTableViewCell.h"
#import "KNC_FinishImageViewController.h"
#import "KNC_MosaicViewController.h"
#import "QC_PS_WatermarkViewController.h"
#import "KNC_ImageTool.h"

@interface KNC_CompoundViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *compTableView;
@property (nonatomic, strong) NSMutableArray  *imageArray;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *mosaicBtn;
@property (nonatomic, strong) UIButton *watermarkBtn;
@property (nonatomic, strong) UIView *bottomLineView;

@end
static NSString * const CompoundTableViewCellID = @"CompoundTableViewCell";
@implementation KNC_CompoundViewController

- (instancetype)initWithImageArray:(NSMutableArray *)array{
    self = [super init];
    if (self) {
         // 把拿到的图片根据设备宽缩放
        for (UIImage *temp in array) {
            UIImage *tempImage = [KNC_ImageTool ps_imageCompressForWidth:temp targetWidth:SCREEN_Width];
            [self.imageArray addObject:tempImage];
        }

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self knc_func_config];
    [self knc_func_AddUI];

}

- (void)knc_func_config{
    self.title = @"图片合成";
}

- (void)knc_func_AddUI{
    [self.view addSubview:self.compTableView];
    [self.view addSubview:self.bottomLineView];
    [self.view addSubview:self.mosaicBtn];
//    [self.view addSubview:self.watermarkBtn];
    [self.view addSubview:self.saveBtn];
    
    [self.compTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabMustAdd - 50);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.compTableView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    [self.mosaicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLineView.mas_bottom);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(115);
        make.height.mas_equalTo(50);
        
    }];
//    [self.watermarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bottomLineView.mas_bottom);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(50);
//    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLineView.mas_bottom);
        make.right.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
}

#pragma mark -- 事件 --
// 马赛克
- (void)mosaicBtnAction{
    KNC_MosaicViewController *vc = [[KNC_MosaicViewController alloc]init];
    vc.originalImage = [KNC_ImageTool ps_groupImageMergeWithLongImageWithImageArray:self.imageArray];
    [self.navigationController pushViewController:vc animated:YES];
    
}

// 水印
- (void)watermarkBtnAction{

    QC_PS_WatermarkViewController *vc = [[QC_PS_WatermarkViewController alloc]init];
    vc.image = [KNC_ImageTool ps_groupImageMergeWithLongImageWithImageArray:self.imageArray];
    [self.navigationController pushViewController:vc animated:YES];
}

// 保存
- (void)saveBtnAction{
    if (isVip) {
        [self qc_pri_pushVc];
    }else{

        KNC_BuyViewController *buyVc =   [[KNC_BuyViewController alloc]init];
        [self.navigationController pushViewController:buyVc animated:YES];

    }
  
    
}
-(void)qc_pri_pushVc{
    KNC_FinishImageViewController *imageViewController = [[KNC_FinishImageViewController alloc]init];
    imageViewController.image = [KNC_ImageTool ps_groupImageMergeWithLongImageWithImageArray:self.imageArray];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

#pragma mark --UITableViewDelegate&&DataSource --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.imageArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KNC_CompoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CompoundTableViewCellID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[KNC_CompoundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CompoundTableViewCellID];
    }
    cell.compImageView.image = self.imageArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = self.imageArray[indexPath.row];
    return image.size.height;

}

- (UITableView *)compTableView{
    if (!_compTableView) {
        _compTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _compTableView.delegate = self;
        _compTableView.dataSource = self;
        _compTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _compTableView.showsVerticalScrollIndicator = NO;
        [_compTableView registerClass:[KNC_CompoundTableViewCell class] forCellReuseIdentifier:CompoundTableViewCellID];
    }
    return _compTableView;
}

- (UIButton *)mosaicBtn{
    if (!_mosaicBtn) {
        _mosaicBtn = [[UIButton alloc]init];
        [_mosaicBtn setTitle:@"马赛克处理" forState:UIControlStateNormal];
        [_mosaicBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_mosaicBtn addTarget:self action:@selector(mosaicBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mosaicBtn;
}

- (UIButton *)watermarkBtn{
    if (!_watermarkBtn) {
        _watermarkBtn = [[UIButton alloc]init];
        [_watermarkBtn setTitle:@"水印" forState:UIControlStateNormal];
        [_watermarkBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_watermarkBtn addTarget:self action:@selector(watermarkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _watermarkBtn;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.layer.borderWidth = 1;
        _bottomLineView.layer.borderColor = PSColorSeparator.CGColor;
    }
    return _bottomLineView;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"直接拼接" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}


@end
