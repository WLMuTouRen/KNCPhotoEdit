//
//  KNC_SnapshotHandler.h
//  PSLongFigure
//
//  Created by Vernon on 2019/12/09.
//  Copyright © 2019年 Vernon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KNC_SnapshotHandler;

@protocol PPSnapshotHandlerDelegate <NSObject>

@optional

- (void)snapshotHandler:(KNC_SnapshotHandler *)snapshotHandler didFinish:(UIImage *)captureImage forView:(UIView *)view;

@end

@interface KNC_SnapshotHandler : NSObject

+ (instancetype)defaultHandler;

@property (nonatomic, weak) id<PPSnapshotHandlerDelegate> delegate;

- (void)knc_snapshotForView:(__kindof UIView *)view;

@end
