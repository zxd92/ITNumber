//
//  XGRootViewController.m
//  侧栏放大缩小
//
//  Created by 小果 on 16/3/5.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGRootViewController.h"
#import "XGContentViewController.h"
#import "XGMenuViewController.h"
#import "XGSettingController.h"

@interface XGRootViewController ()

@property (nonatomic, weak) UINavigationController *nav;

@end

@implementation XGRootViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 1、主视图
    XGContentViewController *content = [[XGContentViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:content];
    self.nav = nav;
    // 添加子视图控制器
    [self addChildViewController:nav];
    // 添加到mainView中
    [self.mainView addSubview:nav.view];
    
    // 2、添加menu视图
    XGMenuViewController *menu = [[XGMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:menu];
    [self.leftView addSubview:menu.view];
    
    // 3、添加setting视图
    XGSettingController *setting = [[XGSettingController alloc] init];
    [self addChildViewController:setting];
    [self.rightView addSubview:setting.view];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedMenu:) name:@"MenuViewControllerSelectedItem" object:nil];

}

-(void)selectedMenu:(NSNotification *)notification {
    
    // 替换导航的根视图
    // 使用通知中的className来创建视图控制器
    UIViewController *vc = [[NSClassFromString(notification.object) alloc] init];
    // 更改nav的根视图控制器
    self.nav.viewControllers = @[vc];
    
    [self resetLocation];
}




@end
