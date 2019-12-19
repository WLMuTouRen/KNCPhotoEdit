//
//  KNC_FunJigsawController.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_FunJigsawController.h"

#import "KNC_FunJigsawView.h"
#import "KNC_FunJigsawItem.h"


#import "KNC_FunJigsawModel.h"


@interface KNC_FunJigsawController ()

@property (nonatomic, strong) KNC_FunJigsawView *jigsawView;

@end

@implementation KNC_FunJigsawController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_initialize];
    
    [self p_setUpUI];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self test];
}

- (void)p_initialize {
    
    self.title = @"趣味拼图";
    
    self.view.backgroundColor = PSColorTheme;
}

- (void)p_setUpUI {
    
    [self.view addSubview:self.jigsawView];
    
    [self p_layout];
}

- (void)p_layout {
    
    [self.jigsawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(Nav_topH + 20);
        make.height.equalTo(self.jigsawView.mas_width);
    }];
}

- (void)test {
    
    NSArray *items = @[
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(2, 2) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 2) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
        [KNC_FunJigsawItem pri_mmp_funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
//        [QC_PS_FunJigsawItem funJigsawItemWithSizeRatio:CGPointMake(1, 1) img:nil],
    ];
    
    KNC_FunJigsawModel *model = [KNC_FunJigsawModel funJigsawModelWithItems:items];
    model.boardWidth = 5.0;
    model.funJigsawViewSize = self.jigsawView.frame.size;
    model.row = 3.0;
    model.list = 3.0;
    
    [self.jigsawView pri_mmp_updateWithModel:model];
    
}

#pragma mark - lazy load --

- (KNC_FunJigsawView *)jigsawView {
    if (!_jigsawView) {
        _jigsawView = [[KNC_FunJigsawView alloc] initWithTargetVC:self];
        _jigsawView.backgroundColor = UIColor.redColor;
    }
    return _jigsawView;
}

@end
