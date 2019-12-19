//
//  AppDelegate.m
//  KNCPhotoEdit
//
//  Created by 翔 on 2019/12/19.
//  Copyright © 2019 com.BaseProject.com. All rights reserved.
//

#import "AppDelegate.h"
#import "KNC_HomeViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import "AppDelegate+JPush.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[KNC_HomeViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    [self knc_customCofigWithOptions:launchOptions];
    return YES;
}

- (void)knc_customCofigWithOptions:(NSDictionary *)options {
    // 推送
    [self flow_jpushRegWithAppKey:@"c470877e4971aa01bbb9fba0" launchOptions:options];
    
    
#ifdef DEBUG
    [MobClick setAutoPageEnabled:YES];
    [UMConfigure initWithAppkey:@"5dfb45cd0cafb28f66000628" channel:@"Debug_photo_edit"];
#else
    [UMConfigure initWithAppkey:@"5dfb45cd0cafb28f66000628" channel:@"Release_photo_edit"];
    [MobClick setAutoPageEnabled:YES];
#endif
    
}

@end
