//
//  KNC_ClipViewController.m
//  PSLongFigure
//
//  Created by mac on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_ClipViewController.h"

@interface KNC_ClipViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *saveBtn;

@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation KNC_ClipViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.view addSubview:self.imageView];
    self.imageView.image = self.image;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Status_H);
        make.left.equalTo(self.view).offset(SCREEN_Width/4);
        make.width.mas_equalTo(SCREEN_Width/2);
        make.height.mas_equalTo(SCREEN_Height - Status_H);
    }];
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    
    // Do any additional setup after loading the view.
}




-(void)saveBtnClick{

    [SVProgressHUD show];
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
}

-(void)closeBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pinchAction:(UIPinchGestureRecognizer*)recognizer{
    
    if (recognizer.state==UIGestureRecognizerStateBegan || recognizer.state==UIGestureRecognizerStateChanged)
        
    {
        
        UIView *view=[recognizer view];
        
        //扩大、缩小倍数
        
        view.transform=CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale);
        
        recognizer.scale=1;
        
    }
}
// 允许多个手势并发

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
    
}

#pragma mark ============lanjiazai===============

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
        UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
        
        pinchGR.delegate = self; //
        
        [_imageView addGestureRecognizer:pinchGR];
    }
    return _imageView;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
