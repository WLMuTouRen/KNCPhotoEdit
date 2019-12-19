//
//  KNC_AddImageTableViewCell.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_AddImageTableViewCell.h"

@implementation KNC_AddImageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self knc_func_configUI];
    }
    return self;
}

- (void)knc_func_configUI{
    
    self.psImageView = [[UIImageView alloc] init];
    self.psImageView.layer.masksToBounds = YES;
    self.psImageView.layer.cornerRadius = 5;
    self.psImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.psImageView];
    
    [self.psImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
}



@end
