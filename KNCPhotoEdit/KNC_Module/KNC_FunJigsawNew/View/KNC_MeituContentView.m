//
//  KNC_MeituContentView.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import "KNC_MeituContentView.h"
#import "UIImage+Help.h"
#define Duration 0.2


@implementation KNC_MeituContentView

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
    
    self.backgroundColor = KNC_RGBColor(230, 230, 230);
    _oneView = [[KNC_MeituImageEditView alloc] initWithFrame:CGRectZero];
    _twoView = [[KNC_MeituImageEditView alloc] initWithFrame:CGRectZero];
    _threeView = [[KNC_MeituImageEditView alloc] initWithFrame:CGRectZero];
    _fourView = [[KNC_MeituImageEditView alloc] initWithFrame:CGRectZero];
    _fiveView = [[KNC_MeituImageEditView alloc] initWithFrame:CGRectZero];
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
    
    
    _boardImageV = [[UIImageView alloc] initWithFrame:self.bounds];
    [_boardImageV setBackgroundColor:UIColor.clearColor];
    [self addSubview:_boardImageV];
    
}

- (void)setassetsArr:(NSMutableArray *)assetsArr
{
    _assetsArr = [NSMutableArray arrayWithArray:assetsArr];
}


- (void)pri_mmp_setBackgroundColor:(UIColor *)backgroundColor posterImage:(UIImage *)posterImage
{
    
    if (posterImage) {
        [_boardImageV setImage:posterImage];
        self.backgroundColor = backgroundColor;
    }else{
        [_boardImageV setImage:nil];
        self.backgroundColor = [UIColor whiteColor];
    }
}


/**
 *  设置不同的样式
 *
 *  @param index 样式的选择
 */
- (void)setStyleIndex:(NSInteger)index
{
    _styleIndex = index;
    _styleFileNameStr = nil;
    NSString *picCountFlag = @"";
    switch (_assetsArr.count) {
        case 2:
            picCountFlag = @"two";
            break;
        case 3:
            picCountFlag = @"three";
            break;
        case 4:
            picCountFlag = @"four";
            break;
        case 5:
            picCountFlag = @"five";
            break;
        default:
            break;
    }
    if (![picCountFlag isEqualToString:@""]) {
        _styleFileNameStr = [NSString stringWithFormat:@"number_%@_style_%ld.plist",picCountFlag,(long)_styleIndex];
        _styleDict = nil;
        _styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle].resourcePath
                                                                 stringByAppendingPathComponent:_styleFileNameStr]];
        if (_styleDict) {
            [self resetAllView];
            [self resetStyle];
        }
    }
}

/**
 *  更换图片和frame的大小
 */
- (void)resetStyle
{
    if (_styleDict) {
        CGSize superSize = CGSizeFromString([[_styleDict objectForKey:@"SuperViewInfo"] objectForKey:@"size"]);
        superSize = [KNC_MeituContentView pri_mmp_sizeScaleWithSize:superSize scale:2.0f];
        NSArray *subViewArray = [_styleDict objectForKey:@"SubViewArray"];
        for(int j = 0; j < [subViewArray count]; j++)
        {
            __block CGRect rect = CGRectZero;
            __block UIBezierPath *path = nil;
            PHAsset *asset = [self.assetsArr objectAtIndex:j];
            
            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:(PHImageContentModeAspectFill) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                
                UIImage *image = result;
                
                NSDictionary *subDict = [subViewArray objectAtIndex:j];
                if([subDict objectForKey:@"frame"])
                {
                    rect = CGRectFromString([subDict objectForKey:@"frame"]);
                    rect = [KNC_MeituContentView pri_mmp_rectScaleWithRect:rect scale:2.0f];
                    rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
                    rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
                    rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
                    rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
                }
                rect = [self rectWithArray:[subDict objectForKey:@"pointArray"] andSuperSize:superSize];
                if ([subDict objectForKey:@"pointArray"]) {
                    NSArray *pointArray = [subDict objectForKey:@"pointArray"];
                    path = [UIBezierPath bezierPath];
                    if (pointArray.count > 2) {//当点的数量大于2个的时候
                        //生成点的坐标
                        for(int i = 0; i < [pointArray count]; i++)
                        {
                            NSString *pointString = [pointArray objectAtIndex:i];
                            if (pointString) {
                                CGPoint point = CGPointFromString(pointString);
                                point = [KNC_MeituContentView pri_mmp_pointScaleWithPoint:point scale:2.0f];
                                point.x = (point.x)*self.frame.size.width/superSize.width -rect.origin.x;
                                point.y = (point.y)*self.frame.size.height/superSize.height -rect.origin.y;
                                if (i == 0) {
                                    [path moveToPoint:point];
                                }else{
                                    [path addLineToPoint:point];
                                }
                            }
                            
                        }
                    }else{
                        //当点的左边不能形成一个面的时候  至少三个点的时候 就是一个正规的矩形
                        //点的坐标就是rect的四个角
                        [path moveToPoint:CGPointMake(0, 0)];
                        [path addLineToPoint:CGPointMake(rect.size.width, 0)];
                        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
                        [path addLineToPoint:CGPointMake(0, rect.size.height)];
                    }
                    [path closePath];
                }
                
                if (j < [self.contentViewArray count]) {
                    KNC_MeituImageEditView *imageView = (KNC_MeituImageEditView *)[self.contentViewArray objectAtIndex:j];
                    imageView.tapDelegate = self;
                    imageView.frame = rect;
                    imageView.backgroundColor = [UIColor grayColor];
                    imageView.realCellArea = path;
                    [imageView pri_mmp_setImageViewData:image rect:rect];
                    imageView.oldRect = rect;
                    //回调或者说是通知主线程刷新，
                }
                
            }];
            
            //            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];//fullScreenImage
            
            //            UIImage *image = result;
            //            UIImage *image = [UIImage imageNamed:@"testBoder_2"];
            //
            //            NSDictionary *subDict = [subViewArray objectAtIndex:j];
            //            if([subDict objectForKey:@"frame"])
            //            {
            //                rect = CGRectFromString([subDict objectForKey:@"frame"]);
            //                rect = [KNC_MeituContentView pri_mmp_rectScaleWithRect:rect scale:2.0f];
            //                rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
            //                rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
            //                rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
            //                rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
            //            }
            //            rect = [self rectWithArray:[subDict objectForKey:@"pointArray"] andSuperSize:superSize];
            //            if ([subDict objectForKey:@"pointArray"]) {
            //                NSArray *pointArray = [subDict objectForKey:@"pointArray"];
            //                path = [UIBezierPath bezierPath];
            //                if (pointArray.count > 2) {//当点的数量大于2个的时候
            //                    //生成点的坐标
            //                    for(int i = 0; i < [pointArray count]; i++)
            //                    {
            //                        NSString *pointString = [pointArray objectAtIndex:i];
            //                        if (pointString) {
            //                            CGPoint point = CGPointFromString(pointString);
            //                            point = [KNC_MeituContentView pri_mmp_pointScaleWithPoint:point scale:2.0f];
            //                            point.x = (point.x)*self.frame.size.width/superSize.width -rect.origin.x;
            //                            point.y = (point.y)*self.frame.size.height/superSize.height -rect.origin.y;
            //                            if (i == 0) {
            //                                [path moveToPoint:point];
            //                            }else{
            //                                [path addLineToPoint:point];
            //                            }
            //                        }
            //
            //                    }
            //                }else{
            //                    //当点的左边不能形成一个面的时候  至少三个点的时候 就是一个正规的矩形
            //                    //点的坐标就是rect的四个角
            //                    [path moveToPoint:CGPointMake(0, 0)];
            //                    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
            //                    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
            //                    [path addLineToPoint:CGPointMake(0, rect.size.height)];
            //                }
            //                [path closePath];
            //            }
            //
            //            if (j < [_contentViewArray count]) {
            //                KNC_MeituImageEditView *imageView = (KNC_MeituImageEditView *)[_contentViewArray objectAtIndex:j];
            //                imageView.tapDelegate = self;
            //                imageView.frame = rect;
            //                imageView.backgroundColor = [UIColor grayColor];
            //                imageView.realCellArea = path;
            //                [imageView setImageViewData:image rect:rect];
            //                imageView.oldRect = rect;
            //                //回调或者说是通知主线程刷新，
            //            }
        }
    }
    [self bringSubviewToFront:self.boardImageV];
}


- (CGRect)rectWithArray:(NSArray *)array andSuperSize:(CGSize)superSize
{
    CGRect rect = CGRectZero;
    CGFloat minX = INT_MAX;
    CGFloat maxX = 0;
    CGFloat minY = INT_MAX;
    CGFloat maxY = 0;
    for (int i = 0; i < [array count]; i++) {
        NSString *pointString = [array objectAtIndex:i];
        CGPoint point = CGPointFromString(pointString);
        if (point.x <= minX) {
            minX = point.x;
        }
        if (point.x >= maxX) {
            maxX = point.x;
        }
        if (point.y <= minY) {
            minY = point.y;
        }
        if (point.y >= maxY) {
            maxY = point.y;
        }
        rect = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    }
    rect = [KNC_MeituContentView pri_mmp_rectScaleWithRect:rect scale:2.0f];
    rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
    rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
    rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
    rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
    return rect;
}

/**
 *  设置所有的样式
 */
- (void)resetAllView
{
    [self styleSettingWithView:_oneView];
    [self styleSettingWithView:_twoView];
    [self styleSettingWithView:_threeView];
    [self styleSettingWithView:_fourView];
    [self styleSettingWithView:_fiveView];
    
}

/**
 *  设置样式
 */
- (void)styleSettingWithView:(KNC_MeituImageEditView *)view
{
    view.frame = CGRectZero;
    [view setClipsToBounds:YES];
    [view setBackgroundColor:[UIColor grayColor]];
    view.imageview.image = nil;
    view.realCellArea = nil;
    [view pri_mmp_setImageViewData:nil];
    [view setUserInteractionEnabled:YES];
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
    [view addGestureRecognizer:longGesture];
}
//释放资源
- (void)releaseViewWith:(KNC_MeituImageEditView *)view
{
    [view removeFromSuperview];
    view = nil;
}

- (void)dealloc
{
    [_contentViewArray removeAllObjects];
    _contentViewArray = nil;
    _assetsArr = nil;
    _styleFileNameStr = nil;
    _styleDict = nil;
    
    [self releaseViewWith:_oneView];
    [self releaseViewWith:_twoView];
    [self releaseViewWith:_threeView];
    [self releaseViewWith:_fourView];
    [self releaseViewWith:_fiveView];
    
    [_boardImageV removeFromSuperview];
    _boardImageV = nil;
    _tempView = nil;
    
    NSLog(@"meitu content view release");
}


- (void)tapWithEditView:(KNC_MeituImageEditView *)sender
{
    if (_delegateMove && [_delegateMove respondsToSelector:@selector(movedEditView)]) {
        [_delegateMove movedEditView];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


//长按换位的功能
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender{
    
    KNC_MeituImageEditView *btn = (KNC_MeituImageEditView *)sender.view;
    NSLog(@"btn.tag::%ld",(long)btn.tag);
    if (sender.state == UIGestureRecognizerStateBegan){
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        [self bringSubviewToFront:btn];
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
//        CGFloat deltaX = newPoint.x;
//        CGFloat deltaY = newPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        //NSLog(@"center = %@",NSStringFromCGPoint(btn.center));
        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
        NSLog(@"===%ld",(long)index);
        
        if (index<0){
            contain = NO;
            _tempView = nil;
        }
        else{
            if (index != -1) {
                _tempView = _contentViewArray[index];
            }
            
//            [UIView animateWithDuration:Duration animations:^{
//
//                                CGPoint temp = CGPointZero;
//                                KNC_MeituImageEditView *button = _contentViewArray[index];
//                                temp = button.center;
//                                button.center = originPoint;
//                                btn.center = temp;
//                                originPoint = btn.center;
//                                contain = YES;
//            }];
        }
        
        
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain)
            {
                //                btn.center = originPoint;
                if (_tempView) {
                    [self exchangeFromIndex:btn.tag-1 toIndex:_tempView.tag-1];
                }else{
                    
                    [btn setNotReloadFrame:btn.oldRect];
                }
            }
            _tempView = nil;
        }];
    }
}


- (void)exchangeFromIndex:(NSInteger)fIndex toIndex:(NSInteger)toIndex
{
    
    ALAsset *a = [_assetsArr objectAtIndex:fIndex];
    ALAsset *b = [_assetsArr objectAtIndex:toIndex];
    
    [_assetsArr replaceObjectAtIndex:fIndex withObject:b];
    [_assetsArr replaceObjectAtIndex:toIndex withObject:a];
    
    KNC_MeituImageEditView *fromView = [_contentViewArray objectAtIndex:fIndex];
    KNC_MeituImageEditView *toView = [_contentViewArray objectAtIndex:toIndex];
    
    [_contentViewArray replaceObjectAtIndex:fIndex withObject:toView];
    [_contentViewArray replaceObjectAtIndex:toIndex withObject:fromView];
    
    KNC_MeituImageEditView *ttView = [[KNC_MeituImageEditView alloc] init];
    ttView.realCellArea = fromView.realCellArea;
    ttView.oldRect = fromView.oldRect;
    ttView.tag = fromView.tag;
    
    
    fromView.frame = toView.oldRect;
    fromView.realCellArea = toView.realCellArea;
    
    [fromView pri_mmp_setImageViewData:[UIImage imageWithColor:[UIColor whiteColor]] rect:toView.oldRect];
    
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestImageForAsset:a targetSize:PHImageManagerMaximumSize contentMode:(PHImageContentModeAspectFill) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        [fromView pri_mmp_setImageViewData:result];
    }];
    fromView.tag = toView.tag;
    fromView.oldRect = toView.oldRect;
    
    toView.frame = ttView.oldRect;
    toView.realCellArea = ttView.realCellArea;
    [toView pri_mmp_setImageViewData:[UIImage imageWithColor:[UIColor whiteColor]] rect:ttView.oldRect];
    [manager requestImageForAsset:b targetSize:PHImageManagerMaximumSize contentMode:(PHImageContentModeAspectFill) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        [toView setImageViewData:result rect:ttView.oldRect];
        [toView pri_mmp_setImageViewData:result];
    }];
    toView.tag = ttView.tag;
    toView.oldRect = ttView.oldRect;
    [self bringSubviewToFront:self.boardImageV];
    ttView = nil;
}



- (NSInteger)indexOfPoint:(CGPoint)point withButton:(KNC_MeituImageEditView *)btn
{
    for (NSInteger i = 0;i<_contentViewArray.count;i++)
    {
        KNC_MeituImageEditView *button = _contentViewArray[i];
        if (button != btn)
        {
            if (CGRectContainsPoint(button.oldRect, point))
            {
                return i;
            }
        }
    }
    return -1;
}




+ (CGRect)pri_mmp_rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGRect retRect = CGRectZero;
    retRect.origin.x = rect.origin.x/scale;
    retRect.origin.y = rect.origin.y/scale;
    retRect.size.width = rect.size.width/scale;
    retRect.size.height = rect.size.height/scale;
    return  retRect;
}

+ (CGPoint)pri_mmp_pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x/scale;
    retPointt.y = point.y/scale;
    return  retPointt;
}


+ (CGSize)pri_mmp_sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale
{
    if (scale<=0) {
        scale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width/scale;
    retSize.height = size.height/scale;
    return  retSize;
}

@end
