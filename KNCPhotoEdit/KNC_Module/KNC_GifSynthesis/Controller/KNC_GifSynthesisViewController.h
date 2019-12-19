//
//  KNC_GifSynthesisViewController.h
//  PSLongFigure
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnSueInfo)(void);

@interface KNC_GifSynthesisViewController : KNC_BaseViewController

@property(nonatomic,strong) ReturnSueInfo SueInfo;

-(void)inputAlubm;

@end

NS_ASSUME_NONNULL_END
