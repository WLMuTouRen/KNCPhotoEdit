//
//  KNC_MeituImageEditView.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_MeituImageEditView.h"

@interface KNC_MeituImageEditView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation KNC_MeituImageEditView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initImageView];
    }
    return self;
}

- (void)initImageView{
    self.backgroundColor = [UIColor grayColor];
    
    _contentScrView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    _contentScrView.delegate = self;
    _contentScrView.showsHorizontalScrollIndicator = NO;
    _contentScrView.showsVerticalScrollIndicator = NO;
    [self addSubview:_contentScrView];
    
    
    self.imageview = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageview.frame = CGRectMake(0, 0, SCREEN_Width * 2.5, SCREEN_Width * 2.5);
    _imageview.userInteractionEnabled = YES;
    //    [_imageview setClipsToBounds:YES];
    //    _imageview.contentMode = UIViewContentModeScaleAspectFit;
    [_contentScrView addSubview:_imageview];
    
    // Add gesture,double tap zoom imageView.
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [_imageview addGestureRecognizer:doubleTapGesture];
//    [doubleTapGesture release];
    
    float minimumScale = self.frame.size.width / _imageview.frame.size.width;
    [_contentScrView setMinimumZoomScale:minimumScale];
    [_contentScrView setZoomScale:minimumScale];
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}



- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _contentScrView.frame = CGRectInset(self.bounds, 0, 0);
    self.imageview.frame = CGRectMake(0, 0, SCREEN_Width * 2.5, SCREEN_Width * 2.5);
    float minimumScale = self.frame.size.width / _imageview.frame.size.width;
    [_contentScrView setMinimumZoomScale:minimumScale];
    [_contentScrView setZoomScale:minimumScale];
}

- (void)setNotReloadFrame:(CGRect)frame{
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    _contentScrView.frame = self.bounds;
    self.imageview.frame = CGRectMake(0, 0, SCREEN_Width * 2.5, SCREEN_Width * 2.5);
    float minimumScale = self.frame.size.width / _imageview.frame.size.width;
    [_contentScrView setMinimumZoomScale:minimumScale];
    [_contentScrView setZoomScale:minimumScale];
}



- (void)pri_mmp_setImageViewData:(UIImage *)imageData rect:(CGRect)rect{
    self.frame = rect;
    [self pri_mmp_setImageViewData:imageData];
}

- (void)pri_mmp_setImageViewData:(UIImage *)imageData{
    _imageview.image = imageData;
    if (imageData == nil) {
        return;
    }
    
    CGRect rect  = CGRectZero;
    CGFloat scale = 1.0f;
    CGFloat w = 0.0f;
    CGFloat h = 0.0f;
    
    
    
    if(self.contentScrView.frame.size.width > self.contentScrView.frame.size.height){
        
        w = self.contentScrView.frame.size.width;
        h = w*imageData.size.height/imageData.size.width;
        if(h < self.contentScrView.frame.size.height){
            h = self.contentScrView.frame.size.height;
            w = h*imageData.size.width/imageData.size.height;
        }
        
    }else{
        
        h = self.contentScrView.frame.size.height;
        w = h*imageData.size.width/imageData.size.height;
        if(w < self.contentScrView.frame.size.width){
            w = self.contentScrView.frame.size.width;
            h = w*imageData.size.height/imageData.size.width;
        }
    }
    rect.size = CGSizeMake(w, h);
    
    CGFloat scale_w = w / imageData.size.width;
    CGFloat scale_h = h / imageData.size.height;
    if (w > self.frame.size.width || h > self.frame.size.height) {
        scale_w = w / self.frame.size.width;
        scale_h = h / self.frame.size.height;
        if (scale_w > scale_h) {
            scale = 1/scale_w;
        }else{
            scale = 1/scale_h;
        }
    }
    
    if (w <= self.frame.size.width || h <= self.frame.size.height) {
        scale_w = w / self.frame.size.width;
        scale_h = h / self.frame.size.height;
        if (scale_w > scale_h) {
            scale = scale_h;
        }else{
            scale = scale_w;
        }
    }
    
    @synchronized(self){
        _imageview.frame = rect;
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [self.realCellArea CGPath];
        maskLayer.fillColor = [[UIColor whiteColor] CGColor];
        maskLayer.frame = _imageview.frame;
        self.layer.mask = maskLayer;
        
        [_contentScrView setZoomScale:0.2 animated:YES];
        
        [self setNeedsLayout];
        
    }
    
}



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    BOOL contained = [_realCellArea containsPoint:point];
    if(_tapDelegate && [_tapDelegate respondsToSelector:@selector(tapWithEditView:)]){
        [_tapDelegate tapWithEditView:nil];
    }
    return contained;
}


#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    float newScale = _contentScrView.zoomScale * 1.2;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:_imageview]];
    [_contentScrView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    if (scale == 0) {
        scale = 1;
    }
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageview;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [scrollView setZoomScale:scale animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    return;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    return;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollViewDidScroll---------");
    //    if (scrollView.contentOffset.x < -30 ||scrollView.contentOffset.y < -30||
    //        scrollView.contentOffset.x > scrollView.contentSize.width + 30 ||scrollView.contentOffset.y > scrollView.contentSize.height + 30) {
    //        [self.imageview removeFromSuperview];
    //        [self.superview addSubview:self.imageview];
    //        self.contentSize = scrollView.frame.size;
    //        [self endEditing:YES];
    //        self.imageview.frame = CGRectMake(0, 0, 50, 50);
    //        self.userInteractionEnabled = NO;
    //        [self setScrollEnabled:NO];
    //    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touch = [[touches anyObject] locationInView:self.superview];
    self.imageview.center = touch;
    
}

//#pragma mark - View cycle
//- (void)dealloc
//{
//    [_contentScrView release];
//    [_realCellArea release];
//    [_imageview release];
//
//    _contentScrView = nil;
//    _realCellArea = nil;
//    _imageview = nil;
////    [super dealloc];
//
//    NSLog(@"meitu Edit view release");
//}

@end
