//
//  QC_PS_WatermarkViewController.m
//  PictureStitch
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "QC_PS_WatermarkViewController.h"
#import "KNC_ImageTool.h"
#import "KNC_FinishImageViewController.h"

@interface QC_PS_WatermarkViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *watermarkBtn;
@property (nonatomic, strong) UIImage *watermarkImage;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation QC_PS_WatermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加水印";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    self.scrollView = [[UIScrollView alloc] init];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    [self.view addSubview:self.watermarkBtn];
    [self.watermarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-TabMustAdd);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (self.image.size.height == UIScreen.mainScreen.bounds.size.height) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.frame.size.height);
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    CGFloat height = self.image.size.height;
    CGFloat width = self.image.size.width;
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TabMustAdd - 50);
    self.scrollView.contentSize = CGSizeMake(width, height);
    self.imageView.frame = CGRectMake(0, 0, width, height);
}

- (void)addWatermarkBtnAction{
    
//    self.watermarkImage = [UIImage imageNamed:@"watermark_image"];
//    self.imageView.image = [QC_PS_ImageTool GetWaterPrintedImageWithBackImage:self.image andWaterImage:self.watermarkImage inRect:CGRectMake(SCREEN_Width-136, 15, 121, 30) alpha:1 waterScale:YES];
    
    [self knc_func_openPhoto];
}


- (void)saveBtnAction{
    
    if (self.watermarkImage == nil) {
        [SVProgressHUD showInfoWithStatus:@"请添加水印"];
        return;
    }
    
    KNC_FinishImageViewController *imageViewController = [[KNC_FinishImageViewController alloc]init];
    UIImage *oooImage = [KNC_ImageTool ps_imageCompressForWidth:self.imageView.image targetWidth:SCREEN_Width];
    imageViewController.image = oooImage;
    [self.navigationController pushViewController:imageViewController animated:YES];
    
}
// 打开相册
- (void)knc_func_openPhoto{
   
     TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
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
    self.watermarkImage = photos.firstObject;
    self.imageView.image = [KNC_ImageTool GetWaterPrintedImageWithBackImage:self.image andWaterImage:self.watermarkImage inRect:CGRectMake(15, 15, 80, 60) alpha:0.5 waterScale:YES];
    
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.layer.borderWidth = 1;
        _bottomLineView.layer.borderColor = PSColorSeparator.CGColor;
    }
    return _bottomLineView;
}

- (UIButton *)watermarkBtn{
    if (!_watermarkBtn) {
        _watermarkBtn = [[UIButton alloc]init];
        [_watermarkBtn setTitle:@"选择水印" forState:UIControlStateNormal];
        [_watermarkBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_watermarkBtn addTarget:self action:@selector(addWatermarkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _watermarkBtn;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

@end
