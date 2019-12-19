//
//  KNC_MeituSpliceContentView.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNC_MeituSpliceContentView : UIScrollView

@property (nonatomic, strong) UIImageView *oneView;
@property (nonatomic, strong) UIImageView *twoView;
@property (nonatomic, strong) UIImageView *threeView;
@property (nonatomic, strong) UIImageView *fourView;
@property (nonatomic, strong) UIImageView *fiveView;

@property (nonatomic, strong) NSArray           *assets;
@property (nonatomic, strong) NSMutableArray    *contentViewArray;
@property (nonatomic, strong) NSString          *styleFileName;
@property (nonatomic, assign) NSInteger         styleIndex;
@property (nonatomic, strong) NSDictionary      *styleDict;

@property (nonatomic, strong) UIImageView       *boardImageView;

- (void)knc_func_setData;
- (void)pri_mmp_setBoarderImage:(UIImage *)boarderImage;

@end
