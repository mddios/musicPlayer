//
//  AppDelegate.m
//  musicPlayer
//
//  Created by coohua on 15/7/10.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

/// 1.成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}
/// 3.事件处理函数
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPause:
            NSLog(@"暂停");
            break;
        case UIEventSubtypeRemoteControlPlay:
            NSLog(@"播放");
            break;
        case UIEventSubtypeRemoteControlNextTrack:
        {
            NSLog(@"下一个任务"); // 下一首歌
            
            //            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"test" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"hello" otherButtonTitles:nil];
            //
            //            [sheet showInView:self.window];
            //            self.sheet = sheet;
            break;
        }
        case UIEventSubtypeRemoteControlPreviousTrack:
            NSLog(@"上一个任务"); // 上一首歌
            break;
        default:
            break;
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 根控制器为导航控制器
    UINavigationController *naVC = [[UINavigationController alloc] init];

    TableViewController *vc = [[TableViewController alloc] init];

    naVC.viewControllers = @[vc];
    self.window.rootViewController = naVC;
    
    [self.window makeKeyAndVisible];
    
    // 2.一般播放音乐后调用，这里为了方便测试直接调用
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
