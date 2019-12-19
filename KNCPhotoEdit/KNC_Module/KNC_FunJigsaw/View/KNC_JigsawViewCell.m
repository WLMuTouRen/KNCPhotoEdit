//
//  KNC_JigsawViewCell.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_JigsawViewCell.h"
#import "KNC_FunJigsawItem.h"

@interface KNC_JigsawViewCell ()

@property (nonatomic, strong) KNC_FunJigsawItem *item;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation KNC_JigsawViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self qc_pri_initialize];
        [self qc_pri_setUpUI];
    }
    return self;
}

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)pri_mmp_updateCellWithItem:(KNC_FunJigsawItem *)item {
    
    if (item) {
        self.item = item;
    }
    
    [self qc_pri_refreshUI];
}

- (void)qc_pri_refreshUI {
    
    [self.imgView setImage:self.item.imgiView];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIImage *addImg = [UIImage imageNamed:@"icon_jigsaw_add"];
    
    if (addImg) {
        [self.imgView drawRect:[self gl_centerRectWithSize:CGSizeMake(40, 40)]];
    }
}

#pragma mark - private method --

- (void)qc_pri_initialize {
    
    self.contentView.backgroundColor = UIColor.redColor;
}

- (void)qc_pri_setUpUI {
    
    [self.contentView addSubview:self.imgView];
    
    
    [self qc_pri_layout];
}


- (void)qc_pri_layout {
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    
}

#pragma mark - lazy load --

- (UIImageView *)imgView {
    if(!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleToFill;
        _imgView.backgroundColor = UIColor.clearColor;
    }
    return _imgView;
}

@end
