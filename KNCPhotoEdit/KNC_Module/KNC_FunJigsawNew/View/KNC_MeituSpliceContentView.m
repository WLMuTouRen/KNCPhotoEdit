//
//  KNC_MeituSpliceContentView.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_MeituSpliceContentView.h"

@implementation KNC_MeituSpliceContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self knc_func_setResource];
    }
    return self;
}



- (void)knc_func_setResource
{
    self.backgroundColor = [UIColor whiteColor];
    _boardImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [_boardImageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_boardImageView];
    
    
    _oneView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _twoView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _threeView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _fourView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _fiveView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self resetAllView];
    if (_contentViewArray == nil) {
        _contentViewArray = [NSMutableArray arrayWithCapacity:5];
    }
    
    _oneView.tag = 1;
    _twoView.tag = 2;
    _threeView.tag = 3;
    _fourView.tag = 4;
    _fiveView.tag = 5;
    
    
    [_contentViewArray addObject:_oneView];
    [_contentViewArray addObject:_twoView];
    [_contentViewArray addObject:_threeView];
    [_contentViewArray addObject:_fourView];
    [_contentViewArray addObject:_fiveView];
    
    
    [self addSubview:_oneView];
    [self addSubview:_twoView];
    [self addSubview:_threeView];
    [self addSubview:_fourView];
    [self addSubview:_fiveView];
    
    
}

- (void)resetAllView
{
    [self styleSettingWithView:_oneView];
    [self styleSettingWithView:_twoView];
    [self styleSettingWithView:_threeView];
    [self styleSettingWithView:_fourView];
    [self styleSettingWithView:_fiveView];
    
}


- (void)pri_mmp_setBoarderImage:(UIImage *)boarderImage;
{
    [_boardImageView setBackgroundColor:[UIColor colorWithPatternImage:boarderImage]];
}


- (void)knc_func_setData
{
    
    CGRect rect = CGRectZero;
    rect.origin.x = 0;
    rect.origin.y = 10;
    for (int i = 0; i < [self.assets count]; i++) {
        ALAsset *asset = [self.assets objectAtIndex:i];
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        CGFloat height = image.size.height;
        CGFloat width = image.size.width;
        rect.size.width = self.frame.size.width - 20;
        rect.size.height = height*((self.frame.size.width - 20)/width);
        rect.origin.x = 10;//(_contentView.frame.size.width - rect.size.width)/2.0f + 10;
        //        rect.size.width = rect.size.width - 20;
        if (i < [self.contentViewArray count]) {
            UIImageView *imageView = (UIImageView *)[self.contentViewArray objectAtIndex:i];
            imageView.frame = rect;
            rect.origin.y += rect.size.height+5;
            imageView.image = image;
        }
    }
    self.contentSize = CGSizeMake(self.frame.size.width, rect.origin.y+5);
    self.boardImageView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
}



- (void)styleSettingWithView:(UIImageView *)view
{
    view.frame = CGRectZero;
}


- (void)releaseViewWith:(UIImageView *)view
{
    [view removeFromSuperview];
    view = nil;
}

- (void)dealloc
{
    [_contentViewArray removeAllObjects];
    _contentViewArray = nil;
    _assets = nil;
    _styleFileName = nil;
    _styleDict = nil;
    
    [self releaseViewWith:_oneView];
    [self releaseViewWith:_twoView];
    [self releaseViewWith:_threeView];
    [self releaseViewWith:_fourView];
    [self releaseViewWith:_fiveView];
    
    [_boardImageView removeFromSuperview];
    _boardImageView = nil;

    NSLog(@"meitu content view release");
}

@end
