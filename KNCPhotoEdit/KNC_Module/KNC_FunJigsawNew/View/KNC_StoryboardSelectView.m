//
//  KNC_StoryboardSelectView.m
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "KNC_StoryboardSelectView.h"
@interface KNC_StoryboardSelectView()

@property (nonatomic, strong) UIButton          *selectedStoryboardBtn;
@property (nonatomic, assign, readwrite) NSInteger      selectStyleIndex;

@end

@implementation KNC_StoryboardSelectView

- (id)initWithFrame:(CGRect)frame picCount:(NSInteger)picCount{
    self = [super initWithFrame:frame];
    if (self) {

        self.picCount = picCount;
        [self knc_func_setResource];
    }
    return self;
}

- (void)setPicCount:(NSInteger)picCount {
    if (_picCount != picCount) {
        _picCount = picCount;
        
        [self knc_func_setResource];
    }
}

- (void)knc_func_setResource{
    
    [self p_clearView];
    
    _storyboardV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [_storyboardV setShowsVerticalScrollIndicator:NO];
    [_storyboardV setShowsHorizontalScrollIndicator:NO];
//    [_storyboardV setBackgroundColor:[HexColor(0x454545) colorWithAlphaComponent:0.6]];
    [self addSubview:_storyboardV];
    
    CGFloat width = 140/2.0f;
    CGFloat height = 100/2.0f;
    
    NSArray *imageNameArray = nil;
    
    switch (self.picCount) {
        case 2:
            self.hidden = NO;
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle_storyboard1_icon",
                              @"makecards_puzzle_storyboard2_icon",
                              @"makecards_puzzle_storyboard3_icon",
                              @"makecards_puzzle_storyboard4_icon",
                              @"makecards_puzzle_storyboard5_icon",
                              @"makecards_puzzle_storyboard6_icon",nil];
            break;
        case 3:
            self.hidden = NO;
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle3_storyboard1_icon",
                              @"makecards_puzzle3_storyboard2_icon",
                              @"makecards_puzzle3_storyboard3_icon",
                              @"makecards_puzzle3_storyboard4_icon",
                              @"makecards_puzzle3_storyboard5_icon",
                              @"makecards_puzzle3_storyboard6_icon",nil];
            break;
        case 4:
            self.hidden = NO;
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle4_storyboard1_icon",
                              @"makecards_puzzle4_storyboard2_icon",
                              @"makecards_puzzle4_storyboard3_icon",
                              @"makecards_puzzle4_storyboard4_icon",
                              @"makecards_puzzle4_storyboard5_icon",
                              @"makecards_puzzle4_storyboard6_icon",nil];
            break;
        case 5:
            self.hidden = NO;
            imageNameArray = [NSArray arrayWithObjects:@"makecards_puzzle5_storyboard1_icon",
                              @"makecards_puzzle5_storyboard2_icon",
                              @"makecards_puzzle5_storyboard3_icon",
                              @"makecards_puzzle5_storyboard4_icon",
                              @"makecards_puzzle5_storyboard5_icon",
                              @"makecards_puzzle5_storyboard6_icon",nil];
            break;
        default:
            self.hidden = YES;
            break;
    }
    
    for (int i = 0; i < [imageNameArray count]; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width+(width-37)/2.0f, 2.5f, 37, 45)];
        [button setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"makecards_puzzle_storyboard_strokr_icon"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(storyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i+1];
        [_storyboardV addSubview:button];
        if (i==0) {
            [button setSelected:YES];
            _selectedStoryboardBtn = button;
        }
        button  = nil;
    }
    [_storyboardV setContentSize:CGSizeMake([imageNameArray count]*width, height)];
    
}


- (void)storyboardAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button == _selectedStoryboardBtn) {
        return;
    }
    self.selectStyleIndex = button.tag;
    [_selectedStoryboardBtn setSelected:NO];
    _selectedStoryboardBtn = button;
    [_selectedStoryboardBtn setSelected:YES];
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(didSelectedStoryboardPicCount:styleIndex:)]) {
        [_delegateSelect didSelectedStoryboardPicCount:self.picCount styleIndex:self.selectStyleIndex];
    }
}

- (void)p_clearView {
    
    if (_storyboardV) {
        [_storyboardV removeFromSuperview];
        _storyboardV = nil;
    }
    _selectedStoryboardBtn = nil;
}

- (void)dealloc{
    [self p_clearView];
}



@end
