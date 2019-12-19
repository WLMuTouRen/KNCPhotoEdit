//
//  KNC_AddImageViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_AddImageViewController.h"
#import "KNC_AddImageTableViewCell.h"
#import "KNC_CompoundViewController.h"

@interface KNC_AddImageViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *assetEditTableView;
@property (nonatomic, strong) NSMutableArray  *assetArray;
@property (nonatomic, strong) UIButton *addBgBtn;
@property (nonatomic, strong) UIButton *mergeBtn;
@property (nonatomic, strong) UIButton *emptyBtn;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIButton *bottomAddBtn;
@property (nonatomic, strong) UIView *bottomView;

@end

static NSString * const AddImageTableViewCellID = @"AddImageTableViewCell";
@implementation KNC_AddImageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self knc_func_setInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self knc_func_addUI];
    
}

- (void)knc_func_setInfo{
    if (self.assetArray.count > 0) {
        self.title = [NSString stringWithFormat:@"已添加%ld张图片",self.assetArray.count];
        self.mergeBtn.hidden = NO;
        self.assetEditTableView.hidden = NO;
        self.addBgBtn.hidden = YES;
        self.emptyBtn.hidden = NO;
    }else{
       self.title = @"点击添加照片";
        self.mergeBtn.hidden = YES;
        self.assetEditTableView.hidden = YES;
        self.addBgBtn.hidden = NO;
        self.emptyBtn.hidden = YES;
    }
    [self.assetEditTableView reloadData];
    
}
 
- (void)knc_func_addUI{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.mergeBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.setBtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
    [self.view addSubview:self.addBgBtn];
    [self.view addSubview:self.assetEditTableView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.bottomAddBtn];
    [self.view addSubview:self.emptyBtn];
    [self.addBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    [self.assetEditTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabMustAdd - 50);
        make.height.mas_equalTo(1);
    }];
    [self.bottomAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView.mas_bottom);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(50);
    }];
    [self.emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark -- 点击事件 --

- (void)addBgBtnAction{
    [self knc_func_openPhoto];
}

- (void)mergeBtnAction{
    if (self.assetArray.count > 0) {
        KNC_CompoundViewController *vc = [[KNC_CompoundViewController alloc]initWithImageArray:self.assetArray];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)emptyBtnAction{
    
    weakSelf(self);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定清空？"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {

        NSLog(@"取消清空");
    }];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        
        
        [weakSelf.assetArray removeAllObjects];
        [weakSelf knc_func_setInfo];
    }];

    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    

    
}
- (void)setBtnAction{
    
}

- (void)bottomAddBtnAction{
     [self knc_func_openPhoto];
}

// 打开相册
- (void)knc_func_openPhoto{
    
//    NSInteger maxCount = 5;
//    if (isVip) {
//        maxCount = 9;
//    }
   
     TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
     imagePicker.allowPickingOriginalPhoto = NO;
     imagePicker.allowPickingVideo = NO;
     imagePicker.allowPickingImage = YES;
     imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
     [self presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark --TZImagePickerControllerDelegate--
-(void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    NSLog(@"已选择的图片----%@",assets);
    [self.assetArray addObjectsFromArray:photos];
    [self knc_func_setInfo];
    
}


#pragma mark --UITableViewDelegate&&DataSource --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.assetArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KNC_AddImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddImageTableViewCellID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[KNC_AddImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddImageTableViewCellID];
    }
    cell.psImageView.image = self.assetArray[indexPath.row];
    return cell;
} 

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.assetArray removeObjectAtIndex:indexPath.row];
    [self.assetEditTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self knc_func_setInfo];
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleNone;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    UIImage *image = self.assetArray[sourceIndexPath.row];
    [self.assetArray removeObjectAtIndex:sourceIndexPath.row];
    [self.assetArray insertObject:image atIndex:destinationIndexPath.row];
    
}
 
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableView *)assetEditTableView{
    if (!_assetEditTableView) {
        _assetEditTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _assetEditTableView.delegate = self;
        _assetEditTableView.dataSource = self;
        [_assetEditTableView setEditing:YES animated:YES];
        _assetEditTableView.contentInset = UIEdgeInsetsMake(20, 0,TabMustAdd , 0);
        _assetEditTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_assetEditTableView registerClass:[KNC_AddImageTableViewCell class] forCellReuseIdentifier:AddImageTableViewCellID];
    }
    return _assetEditTableView;
}

- (UIButton *)addBgBtn{
    if (!_addBgBtn) {
        _addBgBtn = [[UIButton alloc]init];
        [_addBgBtn setTitle:@"点击添加照片" forState:UIControlStateNormal];
        [_addBgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBgBtn addTarget:self action:@selector(addBgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBgBtn;
}

- (UIButton *)mergeBtn{
    if (!_mergeBtn) {
        _mergeBtn = [[UIButton alloc]init];
        [_mergeBtn setTitle:@"合并" forState:UIControlStateNormal];
        [_mergeBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_mergeBtn addTarget:self action:@selector(mergeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mergeBtn;
}

- (UIButton *)emptyBtn{
    if (!_emptyBtn) {
        _emptyBtn = [[UIButton alloc]init];
        _emptyBtn.layer.masksToBounds = YES;
        _emptyBtn.layer.cornerRadius = 20;
        _emptyBtn.backgroundColor = PSColorTheme;
        [_emptyBtn setTitle:@"清空" forState:UIControlStateNormal];
        [_emptyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_emptyBtn addTarget:self action:@selector(emptyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emptyBtn;
}
- (UIButton *)setBtn{
    if (!_setBtn) {
        _setBtn = [[UIButton alloc]init];
        [_setBtn setTitle:@"设置" forState:UIControlStateNormal];
        [_setBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.layer.borderWidth = 1;
        _bottomView.layer.borderColor = PSColorSeparator.CGColor;
    }
    return _bottomView;
}

- (UIButton *)bottomAddBtn{
    if (!_bottomAddBtn) {
        _bottomAddBtn = [[UIButton alloc]init];
        [_bottomAddBtn setTitle:@"添加照片" forState:UIControlStateNormal];
        [_bottomAddBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_bottomAddBtn addTarget:self action:@selector(bottomAddBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomAddBtn;
}

- (NSMutableArray *)assetArray{
    if (!_assetArray) {
        _assetArray = [[NSMutableArray alloc]init];
    }
    return _assetArray;
}

@end
