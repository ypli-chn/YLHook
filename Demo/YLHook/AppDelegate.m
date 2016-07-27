//
//  AppDelegate.m
//  YLHook
//
//  Created by Yunpeng on 16/7/26.
//  Copyright © 2016年 Yunpeng. All rights reserved.
//

#import "AppDelegate.h"
#import "YLHook.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[YLHook hookClassByName:@"UIViewController"] makeEvents:^(YLHookEventMaker *make) {
        make.after.sel(viewDidLoad).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]after viewDidLoad",[[aspectInfo instance] class]);
        });
        make.before.sel(viewWillAppear:).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]before viewWillAppear",[[aspectInfo instance] class]);
        });
        make.before.sel(viewDidAppear:).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]before viewDidAppear",[[aspectInfo instance] class]);
        });
    }];
    
    
    [UIViewController yl_makeEvents:^(YLHookEventMaker *make) {
        make.after.sel(viewWillAppear:).execute.block(^(id<AspectInfo> aspectInfo){
        //execute is an optional semantic filler
            NSLog(@"[%@]after viewWillAppear",[[aspectInfo instance] class]);
        });
    }];
    
    
    // Handle error
    [[YLHook hookClassByName:@"FirstViewController"] makeEvents:^(YLHookEventMaker *make) {
        make.after.sel(viewDidLoad).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]after viewDidLoad",[[aspectInfo instance] class]);
        });
    } catch:^(NSError *error) {
        // Aspects don't allow a method be hooked more than once within the subclass hierarchy
        // So there's an error
        NSLog(@"%@",error);
    }];
    
    
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
