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
    
    [self ps_mmp_customCofigWithOptions:launchOptions];
    return YES;
}

- (void)ps_mmp_customCofigWithOptions:(NSDictionary *)options {
    // 推送
    [self flow_jpushRegWithAppKey:@"c7bffa944bf3511dee69ae3c" launchOptions:options];
    
    
#ifdef DEBUG
    [MobClick setAutoPageEnabled:YES];
    [UMConfigure initWithAppkey:@"5df9f0a1570df36e17000a1e" channel:@"Debug_ps_long_figure"];
#else
    [UMConfigure initWithAppkey:@"5df9f0a1570df36e17000a1e" channel:@"Release_ps_long_figure"];
    [MobClick setAutoPageEnabled:YES];
#endif
    
}

@end
