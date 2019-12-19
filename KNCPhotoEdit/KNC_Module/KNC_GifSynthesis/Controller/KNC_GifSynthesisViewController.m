//
//  KNC_GifSynthesisViewController.m
//  PSLongFigure
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_GifSynthesisViewController.h"
#import "GifAnimatedImage.h"
#import "GifAnimatedImageView.h"
#import "KNC_GifSynthesisModel.h"
#import "KNC_GIFSettingView.h"
#import "ActionSheetView.h"
#import "KNC_PositionViewController.h"
#import "KNC_BuyViewController.h"


@interface KNC_GifSynthesisViewController ()<TZImagePickerControllerDelegate,GIFSettingViewDelegate>{
    KNC_GifSynthesisModel *model;
    NSMutableArray *changeImageArr;
    float nowSpeed;
}

@property(nonatomic,strong)NSMutableArray *imageArr,*assetsArr;//接收数据容器
@property(nonatomic,strong)GifAnimatedImageView *gifImage;//gif展示视图
@property(nonatomic,strong)UIButton *selectButton;//重新选择图片

@property(nonatomic,strong)KNC_GIFSettingView *setView;

@end

@implementation KNC_GifSynthesisViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if ([[NSFileManager defaultManager] isReadableFileAtPath:synthesisPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:synthesisPath error:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GIF图";
    nowSpeed = 0.5;

    self.view.backgroundColor = UIColor.whiteColor;
    model = [[KNC_GifSynthesisModel alloc]init];
    [self inputAlubm];
    [self setupUI];
    
    UIButton *sendB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [sendB setBackgroundImage:GetImage(@"shunxu") forState:UIControlStateNormal];
    [sendB addTarget:self action:@selector(moreSetting) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *output = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [output setBackgroundImage:GetImage(@"导出") forState:UIControlStateNormal];
    [output addTarget:self action:@selector(saveGIF) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:sendB],[[UIBarButtonItem alloc]initWithCustomView:output]];
}

-(void)saveGIF{
    
    if (isVip) {
        if ([[NSFileManager defaultManager] isReadableFileAtPath:synthesisPath]) {
            [model saveGIFImageInAlubm];
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请选择图片"];
        }

    }else{
        KNC_BuyViewController *buyVc =   [[KNC_BuyViewController alloc]init];
        [self.navigationController pushViewController:buyVc animated:YES];
    }
    

}

-(void)moreSetting{
    NSArray *titlearr = @[@"比例调整",@"顺序调整"];
    NSArray *imageArr = @[@"原比例",@"顺序"];
    ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"选择" and:ShowTypeIsShareStyle];
    WS(weakSelf);
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        runMain(^{
            switch (btnTag) {
                case 0:
                    [weakSelf selectImageSize];
                    break;
                    
                case 1:
                    [weakSelf pushEdit];
                    break;
                default:break;
            }
        });
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

-(void)pushEdit{
    KNC_PositionViewController *positionVC = [[KNC_PositionViewController alloc]init];
    [positionVC setOriginalOrderImageArray:self.imageArr];
    [self.navigationController pushViewController:positionVC animated:YES];
    
    WS(weakSelf);
    
    positionVC.newImageArray = ^(NSMutableArray * _Nonnull imageArr) {
        weakSelf.setView.imageArr = imageArr;
        weakSelf.imageArr = imageArr;
        [weakSelf SynthesisGIFImage:self->nowSpeed];
    };
}

-(void)selectImageSize{
    NSArray *titlearr = @[@"1:1",@"2:1",@"3:4",@"4:3",@"16:9"];
    ActionSheetView *actionsheet = [[ActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"比例" and:ShowTypeIsActionSheetStyle];
    
    WS(weakSelf);
    
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        runMain(^{
            switch (btnTag) {
                case 0:
                    weakSelf.gifImage.frame = CGRectMake(SCREEN_Width*0.1, Nav_topH+SCREEN_Width*0.1, SCREEN_Width*0.8, SCREEN_Width*0.8);
                    break;
                    
                case 1:
                    weakSelf.gifImage.frame = CGRectMake(SCREEN_Width*0.1, Nav_topH+SCREEN_Width*0.3, SCREEN_Width*0.8, SCREEN_Width*0.4);
                    break;
                case 2:
                    weakSelf.gifImage.frame = CGRectMake(SCREEN_Width*0.2, Nav_topH+SCREEN_Width*0.1, SCREEN_Width*0.6, SCREEN_Width*0.8);
                    break;
                    
                case 3:
                    weakSelf.gifImage.frame = CGRectMake(SCREEN_Width*0.1, Nav_topH+SCREEN_Width*0.2, SCREEN_Width*0.8, SCREEN_Width*0.6);
                    break;
                case 4:
                    weakSelf.gifImage.frame = CGRectMake(SCREEN_Width*0.1, Nav_topH+SCREEN_Width*0.275, SCREEN_Width*0.8, SCREEN_Width*0.45);
                    break;
                        
                default:break;
            }
            
            [weakSelf SynthesisGIFImage:self->nowSpeed];
        });
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

#pragma mark - UI

-(void)setupUI{
    [self.view addSubview:self.gifImage];
    [self.view addSubview:self.selectButton];
    [self.view addSubview:self.setView];
}

- (GifAnimatedImageView *)gifImage{
    if (!_gifImage) {
//        GifAnimatedImage *image = [GifAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"gifImage" ofType:@".gif"]]];
        _gifImage = [[GifAnimatedImageView alloc] init];
        _gifImage.backgroundColor = RGBColor(230, 230, 230);
//        _gifImage.animatedImage = image;
        _gifImage.contentMode = UIViewContentModeScaleAspectFill;
        _gifImage.layer.masksToBounds = YES;
        _gifImage.frame = CGRectMake(SCREEN_Width*0.1, Nav_topH+SCREEN_Width*0.1, SCREEN_Width*0.8, SCREEN_Width*0.8);
    }
    return _gifImage;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_Width*0.3, CGRectGetMaxY(_gifImage.frame)+SCREEN_Width*0.1, SCREEN_Width*0.4, SCREEN_Width*0.4/3.95)];
        [_selectButton setBackgroundImage:GetImage(@"choose picture") forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(inputAlubm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (KNC_GIFSettingView *)setView{
    if (!_setView) {
        _setView = [[KNC_GIFSettingView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_selectButton.frame), SCREEN_Width, SCREEN_Height - CGRectGetMaxY(_selectButton.frame) - BOTTOM_HEIGHT)];
        _setView.delegate = self;
        _setView.imageArr = self.imageArr;
    }
    return _setView;
}

//接收数据容器
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc]init];
    }
    return _imageArr;
}

- (NSMutableArray *)assetsArr{
    if (!_assetsArr) {
        _assetsArr = [[NSMutableArray alloc]init];
    }
    return _assetsArr;
}

#pragma mark - 合成GIF
-(void)SynthesisGIFImage:(float)speed{
    changeImageArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImage *sizeImage = [model changeIamge:self.imageArr[i] fixedSize:_gifImage.size];
        [changeImageArr addObject:sizeImage];
    }
    //合成
    [model composeGIF:changeImageArr outputPath:synthesisPath changeSpeed:speed];
    //展示
    GifAnimatedImage *image = [GifAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:synthesisPath]];
    _gifImage.animatedImage = image;
}

#pragma mark - 进入相册选择照片
-(void)inputAlubm{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:100 delegate:self];
    imagePicker.minImagesCount = 2;
    imagePicker.allowPickingOriginalPhoto = NO;
    imagePicker.allowPickingVideo = NO;
    imagePicker.allowPickingImage = YES;
    if (self.assetsArr.count != 0) {
        imagePicker.selectedAssets = self.assetsArr;
    }
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//--TZImagePickerControllerDelegate--
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
//    self.SueInfo();
    if (!isSelectOriginalPhoto) {
        self.imageArr = [[NSMutableArray alloc]initWithArray:photos];
        self.assetsArr = [[NSMutableArray alloc]initWithArray:assets];
        _setView.imageArr = self.imageArr;
        [self SynthesisGIFImage:nowSpeed];
    }
}

#pragma mark - GIFSettingViewDelegate
- (void)choseSpeed:(float)speed{
    nowSpeed = speed;
    [self SynthesisGIFImage:nowSpeed];
}

- (void)pushAdjustmentController{
    [self pushEdit];
}

@end
