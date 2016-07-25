//
//  AppDelegate.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "AppDelegate.h"
#import "XGRootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"HelloWorld");
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[XGRootViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end