//
//  KNC_WebShortController.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_WebShortController.h"

@interface KNC_WebShortController ()

@property (nonatomic,strong) UITextField *urlTextField;
@property (nonatomic,strong) NSArray *urlTitleArr;
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,strong) UIButton *startBtn;

@end

@implementation KNC_WebShortController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网页截图";
    self.view.backgroundColor = UIColor.whiteColor;
    self.urlTitleArr = @[@"https://",@"http://",@"www.",@".com",@".cn",@".net",@"复制地址"];
    [self qc_pri_configUI];
    
    
}

-(void)qc_pri_configUI{

    [self.view addSubview:self.urlTextField];
    [self.urlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(10 + Nav_topH);
        make.height.mas_equalTo(25);
    }];

    for (int i = 0; i < self.urlTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 10;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.borderColor = UIColor.grayColor.CGColor;
        btn.layer.cornerRadius = 15;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:self.urlTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        if (i > 3) {
            btn.frame = CGRectMake(((SCREEN_Width - 100)/4 + 20) * (i - 4) + 20 ,Nav_topH + 110, (SCREEN_Width - 100)/4, 30);
        }else{
            btn.frame = CGRectMake(((SCREEN_Width - 100)/4 + 20) * i + 20 ,Nav_topH + 70, (SCREEN_Width - 100)/4, 30);
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    [self.view addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(190 + Nav_topH);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(44);
    }];
    
}

#pragma  mark -============按钮点击事件==============
-(void)btnClick:(UIButton *)sider{
    if (sider.tag - 10 == self.urlTitleArr.count - 1) {
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = self.urlTextField.text;
        if (pboard == nil) {
            [SVProgressHUD showErrorWithStatus:@"复制失败"];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"已复制"];
        }
    }else{
        self.urlTextField.text = [NSString stringWithFormat:@"%@%@",self.urlTextField.text,self.urlTitleArr[sider.tag - 10]];
    }
}

-(void)startBtnClick{
    [self.urlTextField resignFirstResponder];
    
    if (self.urlTextField.text == nil || [self.urlTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@" 请输入网址"];
        return;
    }
    self.urlString  = self.urlTextField.text;
    [self pushVcWithString:self.urlString];
    
}

- (void)clearBtnAction{
    self.urlTextField.text = @"";
}

-(void)pushVcWithString:(NSString *)urlString{
    KNC_WebViewController *webShortVC = [[KNC_WebViewController alloc]init];
    webShortVC.url_Str = urlString;
    webShortVC.titleStr = urlString;
    [self.navigationController pushViewController:webShortVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.urlTextField resignFirstResponder];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
}

#pragma mark ================ 懒加载 ==================

-(UITextField *)urlTextField{
    if (!_urlTextField) {
        _urlTextField = [[UITextField alloc]init];
        _urlTextField.font = [UIFont systemFontOfSize:14];
        _urlTextField.textColor = UIColor.blackColor;
        _urlTextField.keyboardType = UIKeyboardTypeURL;
        _urlTextField.placeholder = @"请输入网址...";
        _urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _urlTextField;
}


-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _startBtn.backgroundColor = RGBColor(131, 102, 255);
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_startBtn setTitle:@"开始截图" forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.layer.masksToBounds = YES;
        _startBtn.layer.cornerRadius = 22;
    }
    return _startBtn;
}


@end
