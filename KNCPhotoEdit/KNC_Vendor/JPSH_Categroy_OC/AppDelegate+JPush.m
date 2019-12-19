//
//  AppDelegate+JPush.m
//
//  Created by Mac on 2019/6/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import <JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate (JPush)

/**
 注册JPush
 
 @param appKey 推送的appKey
 @param options launchOptions
 */
- (void)flow_jpushRegWithAppKey:(NSString *_Nonnull)appKey launchOptions:(NSDictionary * _Nullable)options {
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    // 注册
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // 配置
    [JPUSHService setupWithOption:options appKey:appKey channel:@"App Store" apsForProduction:YES advertisingIdentifier:nil];
    
#if !DEBUG
    
    [self redirectLogToDocumentFolder];
#endif
}

/// log
- (void)redirectLogToDocumentFolder {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"tempImg.jpg"];
    
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    // 先删除已经存在的文件
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
}

/**
 接到远程推送
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

/**
 获取deviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
}


/**
 注册远程推送失败
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"获取Device token 失败");
}


/**
 销毁红点
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    
    [JPUSHService setBadge:0];
    
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [application cancelAllLocalNotifications];
}


#pragma mark - JPush 代理方法 --
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler();
}
#pragma clang diagnostic pop
@end
