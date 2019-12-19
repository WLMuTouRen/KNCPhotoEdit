//
//  KNC_AddImageTableViewCell.m
//  PSLongFigure
//
//  Created by 翔 on 2019/12/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_CompoundTableViewCell.h"

@implementation KNC_CompoundTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self knc_func_configUI];
    }
    return self;
}

- (void)knc_func_configUI{
    
    self.compImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.compImageView];
    
    [self.compImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
