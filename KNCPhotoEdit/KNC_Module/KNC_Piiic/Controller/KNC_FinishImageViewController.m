//
//  KNC_FinishImageViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_FinishImageViewController.h"
#import "KNC_ImageTool.h"

@interface KNC_FinishImageViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation KNC_FinishImageViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"处理完成";

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = self.image;
    self.imageView.backgroundColor = UIColor.redColor;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    self.scrollView = [[UIScrollView alloc] init];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
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

    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(width, height);

    self.imageView.frame = CGRectMake(0, 0, width, height);
}

- (void)saveBtnAction{
    
    weakSelf(self);
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"是否导出带水印图片"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
        
        [weakSelf saveWatermarkImage];
        
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {

        if (isVip) {
            [weakSelf saveWithImage:weakSelf.image];
        }else{
            KNC_BuyViewController *buyVc =   [[KNC_BuyViewController alloc]init];
            [self.navigationController pushViewController:buyVc animated:YES];
        }
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    

}


- (void)saveWatermarkImage{
    weakSelf(self);
    UIImage *watermarkImage = [UIImage imageNamed:@"watermark_image"];
    UIImage *tempImage = [KNC_ImageTool GetWaterPrintedImageWithBackImage:self.image andWaterImage:watermarkImage inRect:CGRectMake(SCREEN_Width-136, 15, 121, 35) alpha:1 waterScale:YES];
    
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
        [SVProgressHUD showSuccessWithStatus:@"导出成功"];
        //保存成功
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]init];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}



@end
