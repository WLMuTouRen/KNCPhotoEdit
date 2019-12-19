//
//  KNC_MosaicViewController.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_MosaicViewController.h"
#import "KNC_MosaicView.h"
#import "KNC_FinishImageViewController.h"

#define headerViewHeight 45
#define footViewHeight 45

@interface KNC_MosaicViewController ()<UIScrollViewDelegate,MosaiViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) KNC_MosaicView *mosaicView;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *nextStepBtn;
@property (nonatomic, strong) UIButton *lastStepBtn;
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation KNC_MosaicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模糊处理";
    [self knc_func_addUI];
}    

- (void)knc_func_addUI{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self createMosaicsView:self.originalImage withFrame:CGRectMake(0, Nav_topH, SCREEN_Width, SCREEN_Height - TabMustAdd  - 50 - Nav_topH)];
    [self.view addSubview:self.bottomLineView];
    [self.view addSubview:self.lastStepBtn];
    [self.view addSubview:self.nextStepBtn];
//    [self.view addSubview:self.clearBtn];
    

    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainScrollView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
        
    }];
    [self.lastStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLineView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(30);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(25);
        
    }];
//    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bottomLineView.mas_bottom);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(50);
//    }];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLineView.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-30);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(25);
    }];

}

- (void)setOriginalImage:(UIImage *)originalImage{
    _originalImage = originalImage;
}

-(void)nextStepBtnAction{
    [self.mosaicView redo];
}

-(void)lastStepBtnAction{
    [self.mosaicView undo];
};

-(void)clearBtnAction{
    [self.mosaicView resetMosaiImage];
}

- (void)saveBtnAction{
    KNC_FinishImageViewController *imageViewController = [[KNC_FinishImageViewController alloc]init];
    imageViewController.image = self.mosaicView.resultImage;
    [self.navigationController pushViewController:imageViewController animated:YES];
    
}

/**
 创建马赛克画板

 @param image 原图
 @param frame 画板frame
 */
- (void)createMosaicsView:(UIImage *)image withFrame:(CGRect)frame {
    if (self.mainScrollView != nil) {
        [self.mainScrollView removeFromSuperview];
        self.mainScrollView = nil;
    }
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.mainScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    self.mainScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.delegate = self;
    self.mainScrollView.clipsToBounds = YES;
    self.mainScrollView.y = frame.origin.y;
    [self.view addSubview:self.mainScrollView];
    
    CGFloat img_Width = (image.size.width * self.mainScrollView.height)/image.size.height;
    CGRect showRect = CGRectMake(0, 0, img_Width, self.mainScrollView.height);
    if (image.size.width > image.size.height) {
        CGFloat img_Height = (image.size.height * self.mainScrollView.width)/image.size.width;
        showRect = CGRectMake(0, 0, self.mainScrollView.width,img_Height);
        showRect.origin.y = (self.mainScrollView.height - img_Height)*0.5;
    }

    self.mosaicView = [[KNC_MosaicView alloc] initWithFrame:showRect];
    self.mosaicView.centerX = self.mainScrollView.width * 0.5;
    self.mosaicView.deleagate = self;
    self.mosaicView.originalImage = image;//原图
    self.mosaicView.mosaicImage = [UIImage imageNamed:@"btn_meitu_edit_normal"];//马赛克图
    [self.mainScrollView addSubview:self.mosaicView];
    
    self.mainScrollView.maximumZoomScale = 2.0;
    self.mainScrollView.minimumZoomScale = 1;
    self.mainScrollView.panGestureRecognizer.minimumNumberOfTouches = 2;
    self.mainScrollView.panGestureRecognizer.delaysTouchesBegan = NO;
    self.mainScrollView.pinchGestureRecognizer.delaysTouchesBegan = NO;
    
}


#pragma mark -UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.mosaicView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat Ws = self.mainScrollView.frame.size.width - self.mainScrollView.contentInset.left - self.mainScrollView.contentInset.right;
    CGFloat Hs = self.mainScrollView.frame.size.height - self.mainScrollView.contentInset.top - self.mainScrollView.contentInset.bottom;
    CGFloat W = self.mainScrollView.frame.size.width;
    CGFloat H = self.mainScrollView.frame.size.height;
    
    CGRect rct = self.mosaicView.frame;
    rct.origin.x = MAX((Ws-W)/2, (SCREEN_Width - self.mosaicView.width)/2);
    rct.origin.y = MAX((Hs-H)/2, (self.mainScrollView.height - self.mosaicView.height)/2);
    self.mosaicView.frame = rct;
}


- (UIButton *)lastStepBtn{
    if (!_lastStepBtn) {
        _lastStepBtn = [[UIButton alloc]init];
//        [_lastStepBtn setTitle:@"<-" forState:UIControlStateNormal];
        [_lastStepBtn setBackgroundImage:[UIImage imageNamed:@"mosaic_last_icon"] forState:UIControlStateNormal];
//        [_lastStepBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_lastStepBtn addTarget:self action:@selector(lastStepBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastStepBtn;
}

- (UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn = [[UIButton alloc]init];
//        [_nextStepBtn setTitle:@"->" forState:UIControlStateNormal];
        [_nextStepBtn setBackgroundImage:[UIImage imageNamed:@"mosaic_next_icon"] forState:UIControlStateNormal];
//        [_nextStepBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(nextStepBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}

- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc]init];
        [_clearBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
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
        [_saveBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:PSColorTheme forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}



@end



