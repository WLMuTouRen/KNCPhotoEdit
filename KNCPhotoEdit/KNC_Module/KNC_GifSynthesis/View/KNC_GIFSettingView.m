//
//  KNC_GIFSettingView.m
//  PictureStitch
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_GIFSettingView.h"
#import "KNC_GIFSettingCollectionViewCell.h"
@interface KNC_GIFSettingView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    CGFloat kiss_W,kiss_H;
}



@property(nonatomic,strong)UISlider *changeSlider;
@property(nonatomic,strong)UILabel *changeLabel;

@property(nonatomic,strong)UICollectionView *imageColl;

@end

@implementation KNC_GIFSettingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        kiss_W = frame.size.width;
        kiss_H = frame.size.height;
        
        self.imageArr = [[NSMutableArray alloc]init];
        
        [self addSubview:self.changeSlider];
        [self addSubview:self.changeLabel];
        [self addSubview:self.imageColl];
        
        
        [self hiddenUI:YES];
    }
    return self;
}

- (void)setImageArr:(NSMutableArray *)imageArr{
    if (imageArr.count != 0) {
        [self hiddenUI:NO];
        _imageArr = imageArr;
        [self.imageColl reloadData];
    }else{
        [self hiddenUI:YES];
    }
    
}

-(void)hiddenUI:(BOOL)ishidden{
    _changeSlider.hidden = ishidden;
    _changeLabel.hidden = ishidden;
    _imageColl.hidden = ishidden;
}

- (UISlider *)changeSlider{
    if (!_changeSlider) {
        // 创建Slider 设置Frame
        _changeSlider = [[UISlider alloc] initWithFrame:CGRectMake(kiss_W*0.05, kiss_H*0.1, kiss_W*0.75, kiss_W*0.2)];
        // 属性配置
        // minimumValue  : 当值可以改变时，滑块可以滑动到最小位置的值，默认为0.0
        _changeSlider.minimumValue = 0.1;
        // maximumValue : 当值可以改变时，滑块可以滑动到最大位置的值，默认为1.0
        _changeSlider.maximumValue = 1.0;
        // 当前值，这个值是介于滑块的最大值和最小值之间的，如果没有设置边界值，默认为0-1；
        _changeSlider.value = 0.5;
        
        // 设置滑块条最大值处设置的图片在不同的状态
        [_changeSlider setMaximumTrackImage:GetImage(@"jindutiao") forState:UIControlStateNormal];
        // 设置滑块条最小值处设置的图片在不同的状态
        [_changeSlider setMinimumTrackImage:GetImage(@"jindutiao") forState:UIControlStateNormal];
        // 设置滑块图片
        [_changeSlider setThumbImage:GetImage(@"jindu anniu") forState:UIControlStateNormal];
        
        // continuous : 如果设置YES，在拖动滑块的任何时候，滑块的值都会改变。默认设置为YES
        [_changeSlider setContinuous:YES];
        
        // 事件监听
        [_changeSlider addTarget:self action:@selector(sliderValurChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _changeSlider;
}

- (UILabel *)changeLabel{
    if (!_changeLabel) {
        _changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_changeSlider.frame), kiss_H*0.1, kiss_W*0.15, kiss_W*0.2)];
        _changeLabel.text = @"0.50s";
        _changeLabel.textAlignment = NSTextAlignmentCenter;
        _changeLabel.font = NameBFont(15);
        _changeLabel.textColor = KNC_RGBColor(200, 200, 200);
        [_changeLabel setMinimumScaleFactor:10];
    }
    return _changeLabel;
}

- (UICollectionView *)imageColl{
    if (!_imageColl) {
        //UICollectionViewLayout  --流水布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        //设置最小的行间距
        layout.minimumLineSpacing = 0;
        //设置最小的列间距
        layout.minimumInteritemSpacing = 0;
        //单元格大小
        layout.itemSize = CGSizeMake(kiss_W*0.15, kiss_W*0.15);
        
        //滚动方向
        //UICollectionViewScrollDirectionVertical(垂直)
        //UICollectionViewScrollDirectionHorizontal(水平)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //创建网格
        _imageColl = [[UICollectionView alloc]initWithFrame:CGRectMake(kiss_W*0.05, kiss_H*0.4, kiss_W*0.9, kiss_W*0.15) collectionViewLayout:layout];
        
        _imageColl.layer.cornerRadius = 5;
        _imageColl.layer.masksToBounds = YES;
        
        _imageColl.backgroundColor = KNC_RGBColor(230, 230, 230);
        
        //注册cell
        [_imageColl registerClass:[KNC_GIFSettingCollectionViewCell class] forCellWithReuseIdentifier:@"cellImage"];
        
        //设置代理
        _imageColl.delegate = self;
        //设置数据源
        _imageColl.dataSource = self;
    }
    return _imageColl;
}


#pragma mark - 监听事件
- (void)sliderValurChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    UITouch *touchEvent = [[event allTouches]anyObject];
    switch(touchEvent.phase) {
        case UITouchPhaseBegan:
            NSLog(@"开始拖动");
            break;
        case UITouchPhaseMoved:
            _changeLabel.text = [NSString stringWithFormat:@"%.2fs",slider.value];
            break;
        case UITouchPhaseEnded:
            [self.delegate choseSpeed:slider.value];
            break;
        default:break;
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

//_selectColl代理，数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KNC_GIFSettingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellImage" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.blackColor;
    cell.imageView.image = self.imageArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate pushAdjustmentController];
}

@end
