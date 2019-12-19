//
//  KNC_HomeCardCollectionVIewLayout.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_HomeCardCollectionViewCell.h"
#import "KNC_HomeCardModel.h"

@interface KNC_HomeCardCollectionViewCell ()
@property (nonatomic, strong) UIImageView *psImageView;
@property (nonatomic, strong) UIImageView *vipImageView;
@end



@implementation KNC_HomeCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self knc_func_addUI];
    }
    return self;
}

- (void)knc_func_addUI{
    self.psImageView = [[UIImageView alloc] init];
    self.psImageView.layer.masksToBounds = YES;
    self.psImageView.layer.cornerRadius = 5;
    [self addSubview:self.psImageView];
    [self.psImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    

    self.vipImageView = [[UIImageView alloc] init];
//    self.vipImageView.frame = CGRectMake(-50, 5, 40, 40);
    self.vipImageView.image = [UIImage imageNamed:@"home_vip_image"];
    [self.psImageView addSubview:self.vipImageView];
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.psImageView.mas_top).offset(5);
        make.centerX.equalTo(self.psImageView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(40, 40));
           
    }];
}


- (void)setCardModel:(KNC_HomeCardModel *)cardModel{
    _cardModel = cardModel;
    self.psImageView.image = [UIImage imageNamed:cardModel.cardImageStr];
    if (cardModel.isShowVip) {
        self.vipImageView.hidden = NO;
    }else{
        self.vipImageView.hidden = YES;
    }
}
@end
