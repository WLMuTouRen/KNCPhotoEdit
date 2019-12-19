//
//  KNC_StoryboardSelectView.h
//  PSLongFigure
//
//  Created by mac on 2019/12/10.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KNC_StoryboardSelectViewDelegate;

@interface KNC_StoryboardSelectView : UIView

@property (nonatomic, strong) UIScrollView  *storyboardV;
@property (nonatomic, assign) id<KNC_StoryboardSelectViewDelegate> delegateSelect;
@property (nonatomic, assign) NSInteger      picCount;
@property (nonatomic, assign, readonly) NSInteger      selectStyleIndex;

- (id)initWithFrame:(CGRect)frame picCount:(NSInteger)picCount;

@end

@protocol KNC_StoryboardSelectViewDelegate <NSObject>

- (void)didSelectedStoryboardPicCount:(NSInteger)picCount styleIndex:(NSInteger)styleIndex;

@end
