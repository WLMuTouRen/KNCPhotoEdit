//
//  KNC_MeituEditStyleViewController.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_MeituEditStyleViewController.h"
#import "KNC_MeituImageEditView.h"
#import "KNC_StoryboardSelectView.h"
#import "KNC_MeituContentView.h"
#import "KNC_MeituSpliceContentView.h"
#import "AppDelegate.h"
#import "KNC_ImagePickerController.h"
#import "KNC_ImageTool.h"

@interface KNC_MeituEditStyleViewController ()<KNC_MeituContentViewDelegate,KNC_StoryboardSelectViewDelegate>
// 导出按钮
@property (nonatomic, strong) UIButton *preBtn;
// ➕按钮
@property (nonatomic, strong) UIButton *addImgBtn;
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, strong) UIButton *editbutton;
//分镜 ， 自由（海报） ， 拼接的样式选择
@property (nonatomic, strong) KNC_StoryboardSelectView *storyboardView;
@property (nonatomic, assign) NSInteger selectStoryBoardStyleIndex;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, strong) KNC_MeituContentView *meituContentView;
@end

@implementation KNC_MeituEditStyleViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isFirst) {
        [self knc_func_setData];
        self.isFirst = NO;
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self knc_func_addSubViews];
    [self knc_func_coginData];
}

- (void)knc_func_coginData{
    self.title = @"趣味拼图";
    self.view.backgroundColor = UIColor.whiteColor;
    self.selectStoryBoardStyleIndex = 1;
    self.isFirst = YES;
    
}

- (void)knc_func_addSubViews{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.preBtn];
    [self.view addSubview:self.meituContentView];
    [self.meituContentView addSubview:self.addImgBtn];
    [self.view addSubview:self.editbutton];
    [self.view addSubview:self.storyboardView];
}

- (void)knc_func_setData{
    if (self.assets && self.assets.count > 0) {
        self.addImgBtn.hidden = YES;
    }else {
        self.addImgBtn.hidden = NO;
    }
    [self.meituContentView setAssetsArr:[self.assets mutableCopy]];
    [SVProgressHUD showWithStatus:@"正在处理"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.meituContentView setStyleIndex:1];
        [SVProgressHUD dismiss];
    });
}

// 添加图片
- (void)addImageButtonAction{
    
    KNC_ImagePickerController *imgPicker = [[KNC_ImagePickerController alloc] init];
    imgPicker.minImagesCount = 2;
    imgPicker.maxImagesCount = 5;
    imgPicker.selectedAssets = [self.assets mutableCopy];
    imgPicker.allowPickingVideo = NO;
    imgPicker.allowTakeVideo = NO;
    
    imgPicker.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.assets = assets;
            self.isFirst = YES;
            self.storyboardView.picCount = self.assets.count;
            [self knc_func_setData];
            
        });
    };
    
    [self presentViewController:imgPicker animated:YES completion:nil];
}


//分镜的选择
- (void)didSelectedStoryboardPicCount:(NSInteger)picCount styleIndex:(NSInteger)styleIndex{
    
    [SVProgressHUD showWithStatus:@"正在处理"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetViewByStyleIndex:styleIndex imageCount:self.assets.count];
        [SVProgressHUD dismiss];
        
    });
}

#pragma mark 不同的分镜的样式

- (void)resetViewByStyleIndex:(NSInteger)index imageCount:(NSInteger)count{

    @synchronized(self){
        self.selectStoryBoardStyleIndex = index;
        [self.meituContentView setStyleIndex:self.selectStoryBoardStyleIndex];
    }
}



#pragma mark 导出 预览图
- (void)exportBtnAction:(UIButton *)btn {
    
    UIImage *img = [self cutImageWithView:self.meituContentView];
    if (self.assets.count <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请添加图片"];
        return;
    }

    weakSelf(self);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"是否导出带水印图片"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        
  
        [weakSelf saveWatermarkImage:img];

    
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
        
        if (isVip) {
            [self saveWithImage:img];
        }else{
            KNC_BuyViewController *buyVc =   [[KNC_BuyViewController alloc]init];
            [weakSelf.navigationController pushViewController:buyVc animated:YES];
        }
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

// 拼接图片
- (UIImage *)cutImageWithView:(UIView *)contentView{
    if(UIGraphicsBeginImageContextWithOptions != NULL){
        UIGraphicsBeginImageContextWithOptions(contentView.frame.size, NO, 2.0);
    } else {
        UIGraphicsBeginImageContext(contentView.frame.size);
    }
    
    [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)saveWatermarkImage:(UIImage *)image {
    weakSelf(self);
    UIImage *watermarkImage = [UIImage imageNamed:@"watermark_image"];
    UIImage *tempImage = [KNC_ImageTool GetWaterPrintedImageWithBackImage:image andWaterImage:watermarkImage inRect:CGRectMake(SCREEN_Width-136-55, 15, 121, 30) alpha:1 waterScale:YES];
    
    [weakSelf saveWithImage:tempImage];
}


- (void)saveWithImage:(UIImage *)image{
    //保存完后调用的方法
    SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
    //保存
    UIImageWriteToSavedPhotosAlbum(image, self, selector, NULL);
}

//图片保存完后调用的方法
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error){
        //保存失败
        [SVProgressHUD showSuccessWithStatus:@"导出失败，请重试"];
        
    }else {
        [SVProgressHUD showSuccessWithStatus:@"导出到相册成功"];
        //保存成功
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void)dealloc{
    _assets = nil;

    [_editbutton removeFromSuperview];
    _editbutton = nil;
    [_storyboardView removeFromSuperview];
    _storyboardView = nil;

    [_meituContentView removeFromSuperview];
    _meituContentView = nil;

}

- (UIButton *)preBtn {
    if (!_preBtn) {
        _preBtn = [[UIButton alloc] init];
        [_preBtn setTitle:@"导出" forState:UIControlStateNormal];
        [_preBtn addTarget:self action:@selector(exportBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_preBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _preBtn;
}

- (UIButton *)addImgBtn {
    if (!_addImgBtn) {
        
        _addImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _addImgBtn.center = CGPointMake(self.meituContentView.width / 2.0, self.meituContentView.height / 2.0);
        [_addImgBtn setImage:[UIImage imageNamed:@"icon_jigsaw_add"] forState:(UIControlStateNormal)];
        [_addImgBtn addTarget:self action:@selector(addImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImgBtn;
}

- (KNC_StoryboardSelectView *)storyboardView{
    if (!_storyboardView) {
        _storyboardView =
        _storyboardView = [[KNC_StoryboardSelectView alloc] initWithFrame:CGRectMake(0, SCREEN_Height - Tab_H, SCREEN_Width, 50) picCount:[self.assets count]];
        [_storyboardView setBackgroundColor:HexColor(0xFDF5E6)];
        _storyboardView.delegateSelect = self;
    }
    return _storyboardView;
}

- (KNC_MeituContentView *)meituContentView{
    if (!_meituContentView) {
         CGSize contentSize = CGSizeMake(SCREEN_Width - 40, (SCREEN_Width - 40) * 1.3334);
        _meituContentView =[[KNC_MeituContentView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - contentSize.width)/2.0f, (SCREEN_Height - 33 - TabMustAdd - contentSize.height)/2.0f, contentSize.width,contentSize.height)];
        self.meituContentView.delegateMove = self;
        
    }
    return _meituContentView;
}


- (UIButton *)editbutton{
    if (!_editbutton) {
        _editbutton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width*0.4, 40)];
        _editbutton.center = CGPointMake(self.view.width/2.0, CGRectGetMaxY(self.meituContentView.frame)+ 40);
        [_editbutton setBackgroundImage:GetImage(@"choose picture") forState:UIControlStateNormal];
//        [_editbutton setTitle:@"选择图片" forState:UIControlStateNormal];
//        [_editbutton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
//        [_editbutton.layer setCornerRadius:5.0f];
//        [_editbutton setClipsToBounds:YES];
//        [_editbutton.layer setBorderColor:UIColor.whiteColor.CGColor];
//        [_editbutton.layer setBorderWidth:1];
        [_editbutton addTarget:self action:@selector(addImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editbutton;
}


@end
