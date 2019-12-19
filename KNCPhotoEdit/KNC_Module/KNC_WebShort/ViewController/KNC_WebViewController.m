//
//  KNC_WebViewController.m
//  PSLongFigure
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_WebViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD.h>
@interface KNC_WebViewController ()<WKNavigationDelegate,PPSnapshotHandlerDelegate>
@property (nonatomic ,strong) WKWebView *onlineWebView;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,assign) BOOL isLookAd;//是否看过广告
@end

@implementation KNC_WebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
 
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelectorOnMainThread:@selector(showProgress) withObject:nil waitUntilDone:NO];
    self.view.backgroundColor = UIColor.whiteColor;
    self.isLookAd = NO;
    self.navigationItem.title = self.titleStr;
    
    if (!self.ishiddenBottom) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截图"  style:UIBarButtonItemStylePlain target:self action:@selector(popmessageCurrent)];
    }
    
    WKWebViewConfiguration *confifg = [[WKWebViewConfiguration alloc] init];
    confifg.selectionGranularity = WKSelectionGranularityCharacter;
    self.onlineWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height ) configuration:confifg];
    self.onlineWebView.opaque = NO;
    [self.onlineWebView.scrollView setShowsVerticalScrollIndicator:NO];
    [self.onlineWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url_Str]]];
    _onlineWebView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.onlineWebView];
    
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    // 给webview添加监听
    [self.onlineWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

}

-(void)showProgress{
    [SVProgressHUD show];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.onlineWebView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.onlineWebView.estimatedProgress animated:YES];
        if (self.onlineWebView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:1.5 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
                [SVProgressHUD dismiss];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
                [SVProgressHUD dismiss];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        [SVProgressHUD dismiss];
    }
}

#pragma mark - PPSnapshotHandlerDelegate

- (void)snapshotHandler:(KNC_SnapshotHandler *)snapshotHandler didFinish:(UIImage *)captureImage forView:(UIView *)view{
    KNC_SnapshotHandler.defaultHandler.delegate = nil;
    
    KNC_ClipViewController *clipVc = [[KNC_ClipViewController alloc]init];
    clipVc.image = captureImage;
    weakSelf(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [SVProgressHUD dismiss];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController pushViewController:clipVc animated:YES];
        }) ;
    });
    
    
}

- (void)popmessageCurrent{
    
    if (!isVip) {
        KNC_BuyViewController *buyVc =   [[KNC_BuyViewController alloc]init];
        [self.navigationController pushViewController:buyVc animated:YES];
    }else{
        [SVProgressHUD showWithStatus:@"截图中..."];
        KNC_SnapshotHandler.defaultHandler.delegate = self;
        
        [KNC_SnapshotHandler.defaultHandler snapshotForView:self.onlineWebView];
    }

    
}

@end
