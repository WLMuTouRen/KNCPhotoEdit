
//
//  GIFMainPath.h
//  PSLongFigure
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#ifndef GIFMainPath_h
#define GIFMainPath_h

#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//加载图片
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#define NameFont(x) [UIFont fontWithName:@"PingFangSC-Light" size:x]//苹方细体
#define NameBFont(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]//苹方体

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

//回到主线程
CG_INLINE void runMain(dispatch_block_t block){
    dispatch_async(dispatch_get_main_queue(), block);
}

//是否是iPad
#define IS_iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_iPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_iPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_iPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_iPad : NO)

//底部安全高度
#define BOTTOM_HEIGHT  ((IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max) == NO ? 0.0 : 34.0)

//获取沙盒 Cache
#define PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define synthesisPath [PathCache stringByAppendingPathComponent:@"/synthesis.gif"]

// View 圆角和加边框
#define ViewBorderRadius(view, Radius, Width, Color)\
\
[view.layer setCornerRadius:(Radius)];\
[view.layer setMasksToBounds:YES];\
[view.layer setBorderWidth:(Width)];\
[view.layer setBorderColor:[Color CGColor]]

#endif /* GIFMainPath_h */
