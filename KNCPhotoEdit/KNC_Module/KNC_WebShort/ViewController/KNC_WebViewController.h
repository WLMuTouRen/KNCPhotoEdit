//
//  KNC_WebViewController.h
//  PSLongFigure
//
//  Created by mac on 2019/12/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface KNC_WebViewController : KNC_BaseViewController
@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *url_Str;

@property (nonatomic , assign) BOOL  ishiddenBottom;

@end

NS_ASSUME_NONNULL_END
